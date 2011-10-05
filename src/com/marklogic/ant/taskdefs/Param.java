package com.marklogic.ant.taskdefs;

import org.apache.tools.ant.types.DataType;

public class Param extends DataType {
	private String name = null;
	private String ns    = null;
	private String value = null;
	private String type = null;
	
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public void addText(String text)
	{
	  this.value = text;
	}
	public void setNs(String ns) {
		this.ns = ns;
	}
	public String getNs() {
		return ns;
	}
	public void addValue(String value){
		this.value = value;
	}
	public void addConfiguredValue(String value){
		this.value  = value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getValue() {
		return value;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getType() {
		return type;
	}
	public String toString(){
		return "name=" + name + ", value=" + value;
	}
}
