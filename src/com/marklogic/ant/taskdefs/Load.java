package com.marklogic.ant.taskdefs;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Vector;

import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.types.FileSet;

import com.marklogic.xcc.Content;
import com.marklogic.xcc.ContentCreateOptions;
import com.marklogic.xcc.ContentFactory;
import com.marklogic.xcc.ContentPermission;
import com.marklogic.xcc.ContentSource;
import com.marklogic.xcc.ContentSourceFactory;


//XCC Imports
import com.marklogic.xcc.Session;

public class Load extends Task {

	private URI xccURL = null;
	private DocSet dSet = null;
	private boolean failOnError = true;
	private String contentType = "";
	
	public void setFailOnError(boolean failOnError )
	{
		this.failOnError = failOnError;
	}
	public void setXccurl(String xccURL) throws BuildException {
		try {
			this.xccURL = new URI(xccURL);
		} catch (URISyntaxException e) {
			//We do this to trigger the build exception.
			xccURL = null;
			String msg = "xccurl is not a valid URI!";
			log(msg, Project.MSG_ERR);
			log(e, Project.MSG_ERR);
			throw(new BuildException(msg));
		}
	}
	public void setContenttype(String contentType)
	{
		this.contentType = contentType;
	}
	public void addConfiguredDocset(DocSet dSet) {
		// TODO add support for multiple DocSets.
		this.dSet = dSet;
	}
		
	public void execute() throws BuildException {
		if( dSet == null ) {
			throw new BuildException("docset Required.");
		}
		if( dSet.getDestdir() == "" ) {
			throw new BuildException("destdir must be set on docset.");			
		}
		log("Connecting to url: " + xccURL, Project.MSG_VERBOSE);
		log("Using basedir: " + dSet.getDestdir(), Project.MSG_VERBOSE);

		//Permissions are optional.
		if( dSet.getPerms() != null ) {
			log("Permissions: ", Project.MSG_VERBOSE);
			for( ContentPermission perm : dSet.getPerms().getPermissions() ) {
				if( perm != null) {
					log("\tRole: " + perm.getRole() + " Capability: " + perm.getCapability(), Project.MSG_VERBOSE);
				}
			}
		}
		
		//So are collections.
		if( dSet.getCols() != null ) {
			log("Collections: ", Project.MSG_VERBOSE);
			for( String col : dSet.getCols().getCollections() ) {
				if( col != null) {
					log("\tURI: " + col, Project.MSG_VERBOSE );
				}
			}
		}
		
		load();
	}
	
	/**
	 * Private Helper Function that actually performs the load.
	 * 
	 */
	private void load() throws BuildException {
		
		//Set Content Creation Options. 
		ContentCreateOptions opts = new ContentCreateOptions();
		if( dSet.getPerms() != null )
			opts.setPermissions(dSet.getPerms().getPermissions());
		if( dSet.getCols() != null )
			opts.setCollections(dSet.getCols().getCollections());
		
		//GV:2010-12-20 Added to support ContentType
		if(contentType.equals("xml")) {
			opts.setFormatXml();
		}
		else if(contentType.equals("binary")) {
			opts.setFormatBinary();
		}
		else if(contentType.equals("text")){
			opts.setFormatText();
		}
		log("ContentType: " + contentType, Project.MSG_INFO);
		
		//We'll need a Directory Scanner to get the filenames.
		DirectoryScanner ds = null;
		//Create a vector for the files.
		Vector<Content> content = new Vector<Content>();
		
		//Now add all the files, in all the FileSets to a Vector so we can get going.
		try {
			for( FileSet fs : dSet.getFileSets() ) {
				ds = fs.getDirectoryScanner(getProject());
				File baseDir = ds.getBasedir();
				log("FS Basedir: " + baseDir, Project.MSG_DEBUG);
/*
 * Removed on 12/4/2008 because I think we can just use the filename from the directory scanner.
				//Now let's replace the \'s to make it a search string.
				baseURI = baseURI.replaceAll("\\\\", "\\\\\\\\");
				//Add slashes to account for the end of the path.
				baseURI = baseURI + "\\\\";
*/
				for( String fileName : ds.getIncludedFiles() ) {
					File f = new File(baseDir, fileName);
					
					String path  = f.getCanonicalPath();
					path = dSet.getDestdir() + fileName;
					path = path.replace(File.separatorChar, '/');
					log("File Path: " + path,Project.MSG_DEBUG);
					if( !content.contains(f) && f != null) {
						content.add(ContentFactory.newContent(path, f, opts));
					}
				}
			}
		} catch (IOException ioError) {
			String msg = "IO Error Prevented File from being loaded.\n" + ioError.getMessage();
			log(msg, Project.MSG_ERR);
			if(failOnError){
				throw(new BuildException(msg));
			}
		}
		
		try {
			ContentSource cs = ContentSourceFactory.newContentSource(xccURL);
			Session session = cs.newSession();
			Content[] contentArray = new Content[content.size()];
			log("Loading Content...", Project.MSG_INFO);
			session.insertContent(content.toArray(contentArray));
			log("Content Loaded", Project.MSG_INFO);
		} catch (Exception e) {
			String msg = "Error Loading Content!\n" + e.getMessage();
			log(msg, Project.MSG_ERR);
			if(failOnError){
				throw(new BuildException(msg));
			}
		}
	}
	
}
