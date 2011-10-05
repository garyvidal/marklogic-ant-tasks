package com.marklogic.ant.taskdefs;

//Java Imports.
import java.util.Vector;

//Ant Imports
import org.apache.tools.ant.types.DataType;
import org.apache.tools.ant.types.FileSet;


public class DocSet extends DataType {
	
	private String destdir = "/";
	private Vector<FileSet> filesets = new Vector<FileSet>();
	private PermissionSet perms = null;
	private CollectionSet cols;
	
	public void setDestdir(String destdir) {
		//make sure that this is really a directory 
		//as far as Mark Logic is concerned.
		if( !destdir.endsWith("/"))
			destdir = destdir + "/";
		this.destdir = destdir;
	}
	
	public String getDestdir() {
		return this.destdir;
	}
	
	public void addConfiguredFileset(FileSet fileset) {
		if (!filesets.contains(fileset)) {
			filesets.add(fileset);
		}
	}
	
	public FileSet[] getFileSets() {
		FileSet[] fs = new FileSet[filesets.size()];
		fs = filesets.toArray(fs);
		return fs;
	}
	
	public void addConfiguredPermissionset( PermissionSet pSet ) {
		this.perms = pSet;
	}
	
	public PermissionSet getPerms() {
		return this.perms;
	}
	
	public void addConfiguredCollectionset( CollectionSet cSet ) {
		this.cols = cSet;
	}
	
	public CollectionSet getCols() {
		return this.cols;
	}

}
