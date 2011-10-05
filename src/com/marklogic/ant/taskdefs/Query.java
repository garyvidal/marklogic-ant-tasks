package com.marklogic.ant.taskdefs;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Vector;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.types.FileSet;


//XCC Imports
import com.marklogic.xcc.ContentSource;
import com.marklogic.xcc.ContentSourceFactory;
import com.marklogic.xcc.Request;
import com.marklogic.xcc.ResultSequence;
import com.marklogic.xcc.Session;
import com.marklogic.xcc.exceptions.RequestException;


public class Query extends Task {

	private URI xccURL = null;
	private String query = null;
	private String output = null;
	private boolean appendOutput = false;
	private Vector<FileSet> filesets = new Vector<FileSet>();
	private boolean failOnError = true;
	private ParamSet paramSet = null;
	
	public void setXccurl( String xccURL ) {
		try {
			this.xccURL = new URI(xccURL);
		} catch (URISyntaxException e) {
			//We do this to trigger the build exception.
			xccURL = null;
			log("xccurl is not a valid URI!", Project.MSG_ERR);
			log(e, Project.MSG_ERR);
		}
	}

	public void setQuery(String query) {
		this.query = query;
	}
	public String getQuery(){
		return this.query;
	}
	public void addConfiguredFileset(FileSet fileset) {
		if (!filesets.contains(fileset)) {
			filesets.add(fileset);
		}
	}
	public void setOutput(String output) {
		this.output = output;
	}

	public String getOutput() {
		return output;
	}

	public void setAppendOutput(boolean appendOutput) {
		this.appendOutput = appendOutput;
	}

	public boolean isAppendOutput() {
		return appendOutput;
	}
	public void setFailOnError(boolean failOnError) {
		this.failOnError = failOnError;
	}
    public void addParamSet(ParamSet paramSet){
    	this.paramSet  = paramSet;
    }
    
	public FileSet[] getFileSets() {
		FileSet[] fs = new FileSet[filesets.size()];
		fs = filesets.toArray(fs);
		return fs;
	}
	
	public void execute() throws BuildException {
		if( xccURL == null  ) {
			throw new BuildException("Valid xccurl attribute is required.");
		}		
		if(query == null && filesets == null){
			throw new BuildException("A query or fileset attributes must be set");
		}
		log("xccURL: " + xccURL, Project.MSG_VERBOSE);
		ContentSource cs = null;
		Session s = null;
		try {
			cs = ContentSourceFactory.newContentSource(xccURL);
			s = cs.newSession();
		} catch (Exception e) {
			log("Error Creating XCC Connection!", Project.MSG_ERR);
			log(e, Project.MSG_ERR);
			throw(new BuildException("Error Creating XCC Connection"));
		}
		
		if( s != null) {
			doQuery(s);
		}
	}
	private void doQuery(Session s) throws BuildException {
		Request r = null;
		try {
			if(query != null){
				r = s.newAdhocQuery(query);
				if(paramSet != null){
					for(Param param : paramSet.getParams()) {
					  log("Variable:" + param.toString(),Project.MSG_DEBUG);
					  r.setVariable(
					    TypeUtils.createVariable(
					    		param.getNs(), 
					    		param.getName(), 
					    		param.getValue(), 
					    		param.getType()));
					}
				}
				log("Query Executing: " + query, Project.MSG_INFO);
				ResultSequence rs = s.submitRequest(r);
				String outValue = rs != null ? rs.asString() : "-empty-";
				if(output != null) {
					writeFile(output,outValue);
				}
				log("Query Results: " + outValue, Project.MSG_INFO);
			}
		} catch (Exception e) {
			
			String msg = "Error Executing Query!\n" + e.getMessage();
			log(msg, Project.MSG_ERR);
			if(failOnError){
				throw(new BuildException(msg));
			}
		}

		
		//We'll need a Directory Scanner to get the filenames.
		DirectoryScanner ds = null;
		//Create a vector for the files.
		log("Query Executing Scripts: " + filesets.size(),Project.MSG_INFO);
		//We want to iterate the fileSet and execute any scripts required
		for( FileSet fs : filesets ) {
			ds = fs.getDirectoryScanner(getProject());
			File baseDir = ds.getBasedir();
			log("FS Basedir: " + baseDir, Project.MSG_DEBUG);
			for( String fileName : ds.getIncludedFiles() ) {
				File f = new File(baseDir, fileName);
			    try {
			    	String fc  = readFile(f);
			    	log("ExScriptFile:" + fileName,Project.MSG_INFO);
			    	r = s.newAdhocQuery(fc);
					if(paramSet != null){
						for(Param param : paramSet.getParams()) {
						  log("Variable:" + param.toString(),Project.MSG_DEBUG);
						  r.setVariable(
						    TypeUtils.createVariable(
						    		param.getNs(), 
						    		param.getName(), 
						    		param.getValue(), 
						    		param.getType()));
						}
					}
					ResultSequence rs = s.submitRequest(r);
					
					if(output != null){
						writeFile(output,rs.asString());
					}
					log("ExScriptResult:" + rs.asString(),Project.MSG_INFO);
				} 
			    catch (Exception e) {
				    log("ExScriptError:" + e.getMessage(),Project.MSG_ERR);
					if(failOnError){
					   throw new BuildException("Request Error:" + e.getMessage() + e.toString());
					}
			    }	
			}
		}
		
	}
	private void writeFile(String fileName,String content){
		try { 
		    FileWriter fstream = new FileWriter(fileName,appendOutput);
			BufferedWriter out = new BufferedWriter(fstream); 
			out.write(content);
			out.close(); 
			fstream.close();
		} catch (IOException e) {
			throw new BuildException(e.getMessage());
		} 
	}
	private String readFile(File file){
        StringBuffer contents = new StringBuffer();
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(file));
            String text = null;

            // repeat until all lines is read
            while ((text = reader.readLine()) != null) {
                contents.append(text)
                    .append(System.getProperty(
                        "line.separator"));
            }
        } catch (FileNotFoundException e) {
        	throw new BuildException(e.getMessage());
        } catch (IOException e) {
        	throw new BuildException(e.getMessage());
        } finally {
            try{
                if (reader != null) {
                    reader.close();
                }
            } catch (IOException e) {
            	throw new BuildException(e.getMessage());           
             }
        }
        
       return contents.toString();

		
	}
}
