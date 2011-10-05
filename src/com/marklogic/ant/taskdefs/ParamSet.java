package com.marklogic.ant.taskdefs;

import java.util.Vector;

import org.apache.tools.ant.types.DataType;


public class ParamSet extends DataType {
	private Vector<Param> params = new Vector<Param>();
	public void addParam(Param param){
		params.add(param);
	}
	public Param[] getParams(){
		Param[] params = new Param[this.params.size()];
		return this.params.toArray(params);	
	}
}
