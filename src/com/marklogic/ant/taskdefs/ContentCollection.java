package com.marklogic.ant.taskdefs;

import org.apache.tools.ant.types.DataType;

public class ContentCollection extends DataType {
	
	private String name = "";
	
	public void setName(String _name) {
		this.name = _name;
	}
	
	public String getName() {
		return name;
	}

}
