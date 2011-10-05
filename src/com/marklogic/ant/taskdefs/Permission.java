package com.marklogic.ant.taskdefs;

import org.apache.tools.ant.types.DataType;

public class Permission extends DataType {
	
	public enum Capability {
		execute,
		insert,
		read,
		update
	}
	
	private Capability permission = null;
	private String role = "";
	
	public void setPermission(Capability permission) {
		this.permission = permission;
	}
	
	public Capability getPermission() {
		return this.permission;
	}
	
	public void setRole(String role) {
		this.role = role;
	}
	
	public String getRole() {
		return this.role;
	}

}
