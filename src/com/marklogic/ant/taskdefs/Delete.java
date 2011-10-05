package com.marklogic.ant.taskdefs;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Collection;
import java.util.StringTokenizer;
import java.util.Vector;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Task;


//XCC Imports
import com.marklogic.xcc.ContentSource;
import com.marklogic.xcc.ContentSourceFactory;
import com.marklogic.xcc.Request;
import com.marklogic.xcc.ResultItem;
import com.marklogic.xcc.ResultSequence;
import com.marklogic.xcc.Session;
import com.marklogic.xcc.exceptions.RequestException;


public class Delete extends Task {

	private URI xccURL = null;
	
	private Vector<String> collections = new Vector<String>();
	private Vector<String> directories = new Vector<String>();
	private Vector<String> documents = new Vector<String>();
  
	private String query;
	
	private boolean failOnError = true;
	public void setFailOnError(boolean failOnError )
	{
		this.failOnError = failOnError;
	}
	
	public void setXccurl( String xccURL ) {
		try {
			this.xccURL = new URI(xccURL);
		} catch (URISyntaxException e) {
			//We do this to trigger the build exception.
			xccURL = null;
			log("xccurl is not a valid URI!", Project.MSG_ERR);
			log(e, Project.MSG_ERR);
		}
	}


	public void setCollections( String collections ) {
		StringTokenizer st = new StringTokenizer(collections, ",");
		while( st.hasMoreTokens() ) {
			this.collections.add( st.nextToken() );
		}
		
	}
	
	public void setDirectories(String directories) {
		StringTokenizer st = new StringTokenizer(directories, ",");
		while( st.hasMoreTokens() ) {
			this.directories.add( st.nextToken() );
		}
	}
	
	public void setDocuments(String documents) {
		StringTokenizer st = new StringTokenizer(documents, ",");
		while( st.hasMoreTokens() ) {
			this.documents.add( st.nextToken() );
		}
	}

	public void setQuery(String query) {
		this.query = query;
	}
		
	public void execute() throws BuildException {
		if( xccURL == null  ) {
			throw new BuildException("Valid xccurl attribute is required.");
		}		
		log("xccURL: " + xccURL, Project.MSG_VERBOSE);
		log("Deleting...", Project.MSG_VERBOSE);
		
		//This is just so that we can use the generic version of toArray.
		String[] strArray = new String[1];
		for(String str : collections.toArray(strArray) )
			log("Collection: " + str, Project.MSG_VERBOSE);
		for(String str : documents.toArray(strArray) )
			log("Document: " + str, Project.MSG_VERBOSE);
		for(String str : directories.toArray(strArray) )
			log("Directory: " + str, Project.MSG_VERBOSE);
		log("Query: " + query, Project.MSG_VERBOSE);
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
			deleteWithQuery(s);
			deleteDocuments(s);
			deleteCollections(s);
			deleteDirectories(s);
		}
		
	}
	
	private void deleteCollections( Session s ) {
		Vector<String> queries = new Vector<String>();
		if( collections.size() > 0 ) {
			log("Deleting Collections ", Project.MSG_INFO);
		}
		for( String collection : collections ) {
			queries.add(createDeleteCollectionQuery(collection));
			log(collection, Project.MSG_INFO);
		}
		executeQueries(queries, s);
	}

	private void deleteDirectories( Session s ) {
		//Build our list of queries and somewhere to store them. 
		Vector<String> queries = new Vector<String>();
		if( directories.size() > 0 ) {
			log("Deleting Directories: ", Project.MSG_INFO);
		}
		for( String directory : directories ) {
			queries.add(createDeleteDirectoryQuery(directory));
			log(directory, Project.MSG_INFO);
		}		
		
		executeQueries(queries, s);
	}

	private void deleteDocuments( Session s ) {
		deleteURIs(documents, s);
	}
		
	/**
	 * Generate a list of uris from the user provided query and 
	 * delete the uris.
	 * 
	 * @param s the session to use.
	 */
	private void deleteWithQuery( Session s ) throws BuildException {
		if( query != null && !query.equals("") ) {
			Vector<String> uris = new Vector<String>();
			Request r = s.newAdhocQuery(query);
			try {
				ResultSequence rs = s.submitRequest(r);
				log("URIs Returned by Query: ", Project.MSG_VERBOSE);
				while( rs.hasNext() ) {
					ResultItem ri = rs.next();
					log(ri.asString(),Project.MSG_VERBOSE);
					uris.add(ri.asString());
				}
				deleteURIs(uris, s);
			} catch (RequestException reqErr) {
				String msg = "Error executing uri selection query!: " + query; 
				log( msg, Project.MSG_ERR );
				log( reqErr, Project.MSG_ERR );
				throw(new BuildException(msg));
			}	
		}
	}
	
	private void deleteURIs(Collection<String> uris, Session s) {
		//Build our list of queries and somewhere to store them. 
		Vector<String> queries = new Vector<String>();
		if( uris.size() > 0 ) {
			log("Deleting File(s): ", Project.MSG_INFO);
		}
		for( String uri : uris ) {
			queries.add(createURIDeleteQuery(uri));
			log(uri, Project.MSG_INFO);
		}
		//Go run the queries.
		executeQueries(queries, s);
	}
	
	private void executeQueries(Collection<String> queries, Session s) throws BuildException{

		//No reason to allocate a new variable each time so create here
		//and assign later.
		Request r = null;
		
		log("Executing Deletion Queries: ", Project.MSG_VERBOSE);		
		for(String _query : queries ) {
			try {
				r = s.newAdhocQuery(_query);
				s.submitRequest(r); 
				log(_query, Project.MSG_VERBOSE);
			} catch (RequestException reqErr) {
				String msg = "Error performing deletion query: " + _query;
				log(msg, Project.MSG_ERR);
				log(reqErr, Project.MSG_ERR);
				if(failOnError)
				{
					throw( new BuildException(msg));
				}
			}
			
		}
	}
	
	private String createDeleteCollectionQuery(String collection) {
		return "xdmp:collection-delete(\"" + collection + "\")";
	}
	
	private String createDeleteDirectoryQuery(String directory) {
		return "xdmp:directory-delete(\"" + directory + "\")";		
	}
	
	private String createURIDeleteQuery(String uri) {
		return "xdmp:document-delete(\"" + uri + "\")";
	}

}
