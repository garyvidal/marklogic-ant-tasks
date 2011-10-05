package com.marklogic.ant.taskdefs;

import java.util.Vector;

import org.apache.tools.ant.types.DataType;

/**
 * <p>
 * Defines a set of collection names assigned when using @see
 * </p>
 * @author fsanders 
 * 
 */
public class CollectionSet extends DataType {

	/** A vector of collection strings*/
	private Vector<String> collections = new Vector<String>();
	
	/** Ant */
	public void addConfiguredCollection(ContentCollection c) {
		if( !collections.contains(c.getName()))
			collections.add(c.getName());
	}
	
	public String[] getCollections() {
		String[] collectionsArray = new String[collections.size()];
		return collections.toArray(collectionsArray);
	}
	
}
