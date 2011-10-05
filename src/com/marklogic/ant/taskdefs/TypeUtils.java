package com.marklogic.ant.taskdefs;

import java.util.Locale;
import java.util.TimeZone;
import java.math.BigDecimal;

import org.apache.tools.ant.BuildException;

import com.marklogic.xcc.ValueFactory;
import com.marklogic.xcc.types.ValueType;
import com.marklogic.xcc.types.XName;
import com.marklogic.xcc.types.XdmValue;
import com.marklogic.xcc.types.XdmVariable;
import com.marklogic.xcc.types.impl.XsDurationImpl;

public class TypeUtils {
  public static XdmValue getValue(String type,String value){
	 XdmValue val = null;
	 try {
		if(type != null) { 
			if(type.equals("string")){
				val = ValueFactory.newXSString(value);
			} else if(type.equals("long") || type.equals("integer")){
				val = ValueFactory.newXSInteger(Integer.parseInt(value));		
			} else if(type.equals("date")){
				val = ValueFactory.newXSDate(value, TimeZone.getDefault(), Locale.getDefault());
			} else if(type.equals("datetime")){
				val = ValueFactory.newXSDateTime(value, TimeZone.getDefault(), Locale.getDefault());		
			} else if(type.equals("time")){
				val = ValueFactory.newXSTime(value, TimeZone.getDefault(), Locale.getDefault());		
			} else if(type.equals("element")){
				val = ValueFactory.newElement(value);
			} else if(type.equals("double")){
				val = ValueFactory.newValue(ValueType.XS_DOUBLE, Double.parseDouble(value));
			} else if(type.equals("decimal")){
				val = ValueFactory.newValue(ValueType.XS_DECIMAL,new BigDecimal(value));
			} else if(type.equals("float")){
				val = ValueFactory.newValue(ValueType.XS_FLOAT,Float.parseFloat(value));		
			} else if(type.equals("anyuri")){
				val = ValueFactory.newValue(ValueType.XS_ANY_URI,value);
			} else if(type.equals("base64")){
				val = ValueFactory.newXSString( value);
			} else if(type.equals("boolean")){
				val = ValueFactory.newValue(ValueType.XS_BOOLEAN,Boolean.parseBoolean(value));
			}else if(type.equals("duration")){
				val = ValueFactory.newValue(ValueType.XS_DURATION,value);
			} else if(type.equals("binary")){
				val = ValueFactory.newBinaryNode(value);
			} else {
				val = ValueFactory.newXSString(value);
			}
		} else {
			val  = ValueFactory.newXSString(value);
		}
			
 	}catch(IllegalArgumentException e){
 		throw new BuildException(e.getMessage() + e.getStackTrace());
 	}
	return val;  
  }	
  public static XdmVariable createVariable(String uri,String name,String value,String type) {
	  XName xname = new XName(uri,name);
	  XdmVariable var = null;
	  XdmValue val = null;
	  val = getValue(type,value);
	  var = ValueFactory.newVariable(xname,val);
	  return var;
  }
  public static void main(String[] args){
	  System.out.println(createVariable(null,"localname","value",null));
  }
}
