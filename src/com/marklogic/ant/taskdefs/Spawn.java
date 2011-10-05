package com.marklogic.ant.taskdefs;

import java.net.URI;
import java.net.URISyntaxException;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Task;

//XCC Imports
import com.marklogic.xcc.ContentSource;
import com.marklogic.xcc.ContentSourceFactory;
import com.marklogic.xcc.Request;
import com.marklogic.xcc.ResultSequence;
import com.marklogic.xcc.Session;
import com.marklogic.xcc.exceptions.RequestException;
import com.marklogic.xcc.types.XdmVariable;

public class Spawn extends Task {
    private URI xccURL = null;
    private String moduleUri = null;
    private ParamSet paramSet = null;
	private boolean failOnError = true;
	public void setFailOnError(boolean failOnError )
	{
		this.failOnError = failOnError;
	}
	
    public void setXccUrl(String xccURL) {
    	try{
    		this.xccURL = new URI(xccURL);
    	} catch(URISyntaxException e) {
    		xccURL = null;
			log("xccurl is not a valid URI!", Project.MSG_ERR);
			log(e, Project.MSG_ERR);	
    	}
    }
    public void addParamSet(ParamSet paramSet){
    	this.paramSet  = paramSet;
    }
    public void setModuleUri(String moduleUri){
    	this.moduleUri = moduleUri;
    }
    public void execute() throws BuildException {
    	if(xccURL == null){
    		throw new BuildException("Valid xccurl attribute is required.");
    	}
    	if(moduleUri == null){
    		throw new BuildException("ModuleUri attribute is required");
    	}
    	if(moduleUri.equals("")){
    		throw new BuildException("ModuleUri attribute cannot be blank");
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
		//No reason to allocate a new variable each time so create here
		//and assign later.
		Request r = s.newModuleInvoke(this.moduleUri);
		log("Spawn:" + moduleUri, Project.MSG_INFO);		
			try {
				s.newModuleSpawn(moduleUri);
				if(paramSet != null){
					for(Param param : paramSet.getParams()) {
						  log("Variable:" + param.toString(),Project.MSG_INFO);
						  r.setVariable(
						    TypeUtils.createVariable(
						    		param.getNs(), 
						    		param.getName(), 
						    		param.getValue(), 
						    		param.getType()));
					}
				}
				ResultSequence rs = s.submitRequest(r);
				log(rs.asString(), Project.MSG_VERBOSE);
			} catch (RequestException reqErr) {
				String msg = "Error performing invoke: " + moduleUri;
				log(msg, Project.MSG_ERR);
				log(reqErr, Project.MSG_ERR);
				if(failOnError){
					throw( new BuildException(msg));
				}
			}	
		}
    }

