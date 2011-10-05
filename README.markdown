#Marklogic ANT Tasks Library

Provides various support for MarkLogic Functionality to use in Build Deployment Scenarios

###Dependencies:
-----
* Latest Marklogic xcc.jar
* Task Specific Dependencies:
  * corb task dependencies  : corb.jar 
  * xqdoc task dependencies : xqdoc-ml.jar;saxon9he.jar;antlr-2.7.5.jar 


##ANT Tasks
<table>
   <tr><th>Task Name</th><th>Description</th></tr>
   <tr><td>load</td><td>Loads content from output of a fileset to MarkLogic Database</td></tr>
   <tr><td>delete</td><td>Deletes content from MarkLogic database</td></tr>
   
   <tr><td>query</td><td>Allows Adhoc query or set of queries to be run against a MarkLogic instance
                         residing in a filesystem</td></tr>
   <tr><td>invoke</td><td>Invoke an XQuery Module against a MarkLogic database</td></tr>
   <tr><td>spawn</td><td>Spawns an XQuery Module against a MarkLogic database</td></tr>
   <tr><td colspan="2">Experimental Tasks</td></tr>
   <tr><td>corb</td><td>Executes a corb job against MarkLogic database</td></tr>
   <tr><td>xqsync</td><td>Generates XQSync documents against a list of files in a filesystem directory</td></tr>
</table>

###&lt;load&gt; Task
======
Description:
Load content from filesystem into MarkLogic database. 

####Attribute Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
  <tr><td>contenttype</td><td>Sets the default contentType for defined docset.  This parameter is useful there is an unknown mimetype and you want to 
  explicitly set the type.  Value can be xml|binary|text.
  </td><td>No,<br/>           default=false</td></tr>
</table>
####Elements Nested Parameters
<table>
  <tr><th>Element Name</th><th>Description</th><th>Required</th></tr>
  <tr><td>docset</td><td>Defines the uri where the content will be loaded and additional permissions, collections and fileset residing on local filesystem.</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
</table>
Example (Complete):
Loads a document into /test-dir/ from ../src directory using fileset vector.  Additionally a set of permissions and collections are assigned to documents loaded.

```xml
  <ml:load xccurl="${xccstring}">
      <ml:docset destdir="/test-dir/">
          <ml:permissionset>
              <ml:permission role="nobody" permission="execute" />
              <ml:permission role="nobody" permission="insert" />
              <ml:permission role="nobody" permission="read" />
              <ml:permission role="nobody" permission="update" />
          </ml:permissionset>
          <ml:collectionset>
              <ml:collection name="collection1" />
              <ml:collection name="collection2" />
          </ml:collectionset>
          <fileset dir="../src" includes="**/*" />                
      </ml:docset>
  </ml:load>
```

###&lt;delete&gt; Task
======

Description: Deletes files/directories/collections from MarkLogic database.

####Attribute Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>documents</td><td>Comma Seperated List of document uris to delete</td><td>No</td></tr>
  <tr><td>directories</td><td>Comma Seperated List of directory uris to delete</td><td>No</td></tr>
  <tr><td>collections</td><td>Comma Seperated List of collection names to delete</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No<br/>default=false</td></tr>
</table>

Example: Deletes files from various documents, directories, or collections

```xml
  <ml:delete xccurl="${xccstring}"
	documents="/path/to/doc1.xml,/path/to/doc2.xml"
	directories="/dir1/,/dir2/"
	collections="collection1,collection2"
	failonerror="false"
  />
```

###&lt;query&gt; Task
======
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
  <tr><td>query</td><td>XQuery code to execute. At least the query attribute or a fileset is required to execute a given query task.</td><td>No</td></tr>
  <tr><td>output</td><td>File system path to write output for queries.  If not set will write output to standard output</td><td>No</td></tr>
  <tr><td>appendOutput</td><td>Boolean value to determine if any output is appended to the output uri value</td><td>No<br/>default=false</td></tr>
</table>
#### Nested Element Parameters
<table>
  <tr><th>Element</th><th>Description</th><th>Required</th></tr>
  <tr><td>fileset</td><td>When passed allows execution of multiple xquery files given a file vector</td><td>No</td></tr>
  <tr><td>paramset</td><td>Allows parameters to be passed to query or query files.</td><td>No</td></tr>
  
</table>
Example 1:(Simple Query)

```xml
   <ml:query xccurl="${xccstring}" query="1 + 2">
```

Returns
```text
3
```

Example 2:(Passing External Arguments against query attribute)

```xml
	<ml:query xccurl="${xccstring}" query="
	declare variable $NAME as xs:string external;
	declare variable $TIMES as xs:integer external;
	for $in in (1 to $TIMES)
	return $NAME	
	">
	<ml:paramset>
	    <ml:param name="NAME" ns="" type="string" value="Michael"/>
	    <ml:param name="TIMES" ns="" type="integer" value="3"/>
	</ml:paramset>
	</ml:query>
```
Returns

```xml
 Michael
 Michael
 Michael
```

Example 3: (Passing External Arguments to multiple xquery modules via a fileset)
Same as Example 2 except the query is saved in test-parameters.xqy

```xml
	<ml:query xccurl="${xccstring}">
	<fileset file="${basedir}/testcases/test-parameters.xqy"/>
	<ml:paramset>
		<ml:param name="NAME" ns="" type="string" value="Douglass"/>
		<ml:param name="TIMES" ns="" type="integer" value="3"/>
	</ml:paramset>
	</ml:query>
```

Returns

```xml
 Douglass
 Douglass
 Douglass
```

###&lt;invoke&gt; Task
=========
Description: Invokes a mainModule at a given uri.  The module must exists in the modules database configured for the app-server.

####Attribute Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
  <tr><td>moduleuri</td><td>The location of the URI relative to the module root defined in the appserver</td><td>Yes</td></tr>
</table>

#### Nested Element Parameters
<table>
  <tr><th>Element</th><th>Description</th><th>Required</th></tr>
  <tr><td>paramset</td><td>Allows parameters to be passed to query or query files.</td><td>No</td></tr>
  <tr><td>options</td><td>Invoke options to control invocation</td><td>No</td></tr>
</table>

Example:

```xml
    <ml:invoke xccurl="${xccstring}" moduleUri="test/test.xqy">
    	<ml:paramset>
    	   <ml:param name="foo" ns="" type="string" value="Douglass"/>
    	</ml:paramset>
    </ml:invoke>
```

###&lt;spawn&gt; Task
=====
Description : Spawns a task on the Marklogic Task Server against a given moduleUri.  The moduleUri must exist in the modules database for the appserver.
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
  <tr><td>moduleuri</td><td>The location of the URI relative to the module root defined in the appserver</td><td>Yes</td></tr>
</table>

#### Nested Element Parameters
<table>
  <tr><th>Element</th><th>Description</th><th>Required</th></tr>
  <tr><td>paramset</td><td>Allows parameters to be passed to query or query files.</td><td>No</td></tr>
</table>

Example 1: Spawns the 'test/test.xqy' passing parameter name foo
```xml
    <ml:spawn xccurl="${xccstring}" moduleUri="test/test.xqy">
    	<ml:paramset>
    		<ml:param name="foo" ns="" type="string" value="Douglass"/>
    	</ml:paramset>
    </ml:invoke>
```

###&lt;corb&gt; Task
Description:  Executes a Corb task.  This is a wrapper for the corb.jar.  The latest version of corb.jar can be found at here: https://github.com/marklogic/corb
======
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No<br/>default=false</td></tr>
  <tr><td>module</td><td>Module to execute when processing a given document uri</td><td>Yes</td></tr>
  <tr><td>collection</td><td>collection for uri selection</td><td>No</td></tr>
  <tr><td>urismodule</td><td>Custom uri module to invoked to select uris to process</td><td>No</td></tr>
  <tr><td>moduledb</td><td>Modules database to use when executing the module</td><td>No</td></tr>
  <tr><td>threads</td><td>Number of threads to run in parrallel when processing requests</td><td>No<br/>default=1</td></tr>
  <tr><td>install</td><td>Determines whether modules should be installed before executing the corb process.  It is important to note if the modules URI</td><td>No<br/>default=false</td></tr>
</table>
Example:

```xml
<ml:corb xccurl="${xccstring}" 
	collection="" 
	module="${basedir}/tests/corb/uri-logger.xqy"
	moduledb="Documents"
	moduleroot="/"
	threads="4"
	install="false" 
/>
```

###&lt;xqdoc&gt; Task
======
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
</table>
Example:

```xml
  <ml:xqdoc/>
```

##Nested Elements 

###&lt;docset&gt; Element
======
Description : Sets the directory uri location for loading content into database via ml:load task.
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>destdir</td><td>The destination directory appended to all loaded documents</td><td>Yes</td></tr>
</table>
Example:

```xml
      <ml:docset destdir="/test-dir/">
          <ml:permissionset>
              <ml:permission role="nobody" permission="execute" />
              <ml:permission role="nobody" permission="insert" />
              <ml:permission role="nobody" permission="read" />
              <ml:permission role="nobody" permission="update" />
          </ml:permissionset>
          <ml:collectionset>
              <ml:collection name="collection1" />
              <ml:collection name="collection2" />
          </ml:collectionset>
          <fileset dir="../src" includes="**/*" />                
      </ml:docset>
```

###&lt;permissionset&gt; Element
======
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
</table>

Example:

```xml
    <ml:permissionset>
        <ml:permission role="nobody" permission="execute" />
        <ml:permission role="nobody" permission="insert" />
        <ml:permission role="nobody" permission="read" />
        <ml:permission role="nobody" permission="update" />
    </ml:permissionset>
```

###&lt;permission&gt; Element
======
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>role</td><td>Name of role for given permission</td><td>Yes</td></tr>  
  <tr><td>permission</td><td>Capabality for given permission.  Can be 'read', 'insert',
'update','execute'.  Only one role/permission pair is allowed per &lt;permission/&gt; element</td><td>Yes</td></tr>
</table>
Example:

```xml
  <ml:permission role="role-name" permission="insert"/>
```

###&lt;collectionset&gt; Element
======
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
</table>
Example:

```xml
  <ml:collectionset>
     <ml:collection name="collection-name-1">
     <ml:collection name="collection-name-2">
  </ml:collectionset>
```

###&lt;collection&gt; Element
======
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>name</td><td>Name of a collection to add</td><td>Yes</td></tr>  
</table>

Example:

```xml
  <ml:collection name="my-collection"/>
```

###&lt;paramset&gt; Element
======
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
</table>
Example:

```xml
	<ml:paramset>
		<ml:param name="foo" ns="" type="string" value="Douglass"/>
	</ml:paramset>
```

###&lt;param&gt; Element
======
Description >
    Defines a parameter definition.
####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>name</td><td>Name of variable</td><td>Yes</td></tr>  
  <tr><td>ns</td><td>Namespace of the variable.</td><td>Yes</td></tr>  
  <tr><td>type</td><td>Type of the variable.</td><td>No, will cast to string if not set</td></tr>  
  <tr><td>value</td><td>Value of the variable</td><td>Yes</td></tr>  
</table>

Example:

```xml
  <ml:param name="foo" ns="" type="string" value="Douglass"/>
```

