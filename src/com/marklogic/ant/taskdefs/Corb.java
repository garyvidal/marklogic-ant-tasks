package com.marklogic.ant.taskdefs;

import java.net.URI;
import java.net.URISyntaxException;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Task;
import com.marklogic.developer.corb.Manager;
import com.marklogic.developer.corb.TransformOptions;
/*
 * Executes a Corb (bulk processing) task against an existing database connection @link http://marklogic.github.com/corb/
 * 
 * <h2>Parameters</h2>
 * <table>
 *   <tr><th>Attribute</th><th>Description</th><th>Default</th><th>Required</th></tr>
 *   <tr><td>xccurl</td><td>XCC Connection String </td><td>None</td><td>Yes</td></tr>
 *   <tr><td>collection</td><td>A collection to run the corb against</td><td>Empty String ""</td><td>Yes</td></tr>
 *   <tr><td>module<td></td>XQuery Module filesystem path if not in corb package</td><td>Empty String ""</td><td>Yes</td></tr>
 *   <tr><td>threads<td></td>The Number of threads to run corb job</td><td>1</td><td>No</td></tr>
 *   <tr><td>urisModule</td><td>Alternate uris-module xquery file, replacing provided corb default</td><td>Empty String ""</td><td>No</td></tr>
 *   <tr><td>moduleRoot</td><td>Assumes "/" if not provided</td><td>Slash("/")</td><td>No</td></tr>
 *   <tr><td>install</td><td>Will module and urisModule will be installed on start</td><td>Default 'true';set to '0' or 'false' to skip installation</td><td>No</td></tr>
 * </table>
 * 
 * <h2>Usage</h2>
 * <p>Simple Task execution</p>
 * <corb xcc='xcc://user:password@server:port/DB' collection='' module='./uri-logger.xqy'/>
 * 
 * 
 * @author: Gary Vidal (gary.vidal@marklogic.com)
 * 
 * */
public class Corb extends Task {
	private String xccUrl = null;
	private String collection = null;
	private String module = null;
	private int threads = 1;
	private String urisModule = null;
	private String moduleRoot = null;
	private String moduleDB = null;
	private boolean install = true;
	/**
	 * @return the xccUrl
	 */
	public String getXccUrl() {
		return xccUrl;
	}

	/**
	 * @param xccUrl the xccUrl to set
	 */
	public void setXccUrl(String xccUrl) {
		this.xccUrl = xccUrl;
	}

	/**
	 * @return the collection
	 */
	public String getCollection() {
		return collection;
	}

	/**
	 * @param collection the collection to set
	 */
	public void setCollection(String collection) {
		this.collection = collection;
	}

	/**
	 * @return the module
	 */
	public String getModule() {
		return module;
	}

	/**
	 * @param module the module to set
	 */
	public void setModule(String module) {
		this.module = module;
	}

	/**
	 * @return the threads
	 */
	public int getThreads() {
		return threads;
	}

	/**
	 * @param threads the threads to set
	 */
	public void setThreads(int threads) {
		this.threads = threads;
	}

	/**
	 * @return the urisModule
	 */
	public String getUrisModule() {
		return urisModule;
	}

	/**
	 * @param urisModule the urisModule to set
	 */
	public void setUrisModule(String urisModule) {
		this.urisModule = urisModule;
	}

	/**
	 * @return the moduleRoot
	 */
	public String getModuleRoot() {
		return moduleRoot;
	}

	/**
	 * @param moduleRoot the moduleRoot to set
	 */
	public void setModuleRoot(String moduleRoot) {
		this.moduleRoot = moduleRoot;
	}

	/**
	 * @return the moduleDB
	 */
	public String getModuleDB() {
		return moduleDB;
	}

	/**
	 * @param moduleDB the moduleDB to set
	 */
	public void setModuleDB(String moduleDB) {
		this.moduleDB = moduleDB;
	}

	/**
	 * @return the install
	 */
	public boolean isInstall() {
		return install;
	}

	/**
	 * @param install the install to set
	 */
	public void setInstall(boolean install) {
		this.install = install;
	}


	
	public void execute() {
		if(xccUrl == null) {
			throw new BuildException("The xccurl property must be set");
		}
		//if(collection == null) {
		//	throw new BuildException("The collection property must be set");
		//}
		if(module == null || module.equals("")) {
			throw new BuildException("The module property must be set");
		}
		doExecute();
	}
	private void doExecute(){
		String[] args = new String[8];
		args[0] = this.xccUrl;
		args[1] = this.collection;
		args[2] = this.module != null ? this.module : "";
		args[3] = "" + this.threads;
		args[4] = this.urisModule != null ? this.urisModule : "";
		args[5] = this.moduleRoot != null ? this.moduleRoot : "";
		args[6] = this.moduleDB != null ? this.moduleDB : "";
		args[7] = new Boolean(this.install).toString();
		try {
			Manager.main(args);
		} catch (URISyntaxException e) {
			log(e.getMessage(),Project.MSG_ERR);
			throw new BuildException(e.getMessage());
			
		}
	}
}
