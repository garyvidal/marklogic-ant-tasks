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
import com.marklogic.xcc.RequestOptions;
import com.marklogic.xcc.ResultSequence;
import com.marklogic.xcc.Session;
import com.marklogic.xcc.exceptions.RequestException;

public class Invoke extends Task {
    private URI xccURL = null;
    private String moduleUri = null;
    private ParamSet paramSet = null;
    private Options options = null;
	private boolean failOnError = true;

	public void setFailOnError(boolean failOnError )
	{
		this.failOnError = failOnError;
	}
    //RequestOptions
    
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
    
    public String getModuleUri(){
    	return this.moduleUri;
    }
    
    public void addOptions(Options options){
    	this.options = options;
    }
	public Options getOptions() {
		return options;
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
    	log("xccURL: " + xccURL, Project.MSG_INFO);
		ContentSource cs = null;
		Session s = null;
		try {
			cs = ContentSourceFactory.newContentSource(	xccURL);
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
		log("Invoke: "+ moduleUri, Project.MSG_INFO);		
		try {
			r = s.newModuleInvoke(this.moduleUri);
	        r.setOptions(getRequestOptions(r));
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
			log("Invoke Results:" + rs.asString(), Project.MSG_INFO);
		} catch (RequestException reqErr) {
			String msg = "Error performing invoke: " + moduleUri;
			log(msg, Project.MSG_ERR);
			log(reqErr, Project.MSG_ERR);
			if(failOnError){
				throw( new BuildException(msg));
			}
		}	
	}
    private RequestOptions getRequestOptions(Request r) {
    	RequestOptions requestOpts = r.getEffectiveOptions();
    	
    	return requestOpts;
    }
    public static void main(String[] args){
    	Invoke invoke = new Invoke();
    	ParamSet paramSet = new ParamSet();
    	Param param = new Param();
    	
    	invoke.setXccUrl("xcc://admin:admin@localhost:9090/pce");
    	param.setNs(null);
    	param.setName("foo");
    	param.setValue("Bob Dobalina");
    	param.setType("string");
    	paramSet.addParam(param);
    	invoke.addParamSet(paramSet);
    	invoke.setModuleUri("test/test.xqy");
    	invoke.execute();
    }
}

