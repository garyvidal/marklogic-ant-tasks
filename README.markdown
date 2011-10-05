#Marklogic ANT Tasks Library

Provides various support for MarkLogic Functionality to use in Build Deployment Scenarios

##Dependencies:
* marklogic xcc jar
* saxon jar


##Tasks
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

####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
</table>
Example:

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

####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>documents</td><td>Comma Seperated List of document uris to delete</td><td>No</td></tr>
  <tr><td>directories</td><td>Comma Seperated List of directory uris to delete</td><td>No</td></tr>
  <tr><td>collections</td><td>Comma Seperated List of collection names to delete</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No, Default 'true'</td></tr>
</table>
Example:

```xml
  <ml:delete xccurl="${xccstring}"
          	documents="/path/to/doc1.xml,/path/to/doc2.xml"
       		  directories="/dir1/,/dir2/"
            collections="collection1,collection2"
            failonerror="false"
  />
```

###&lt;query&gt; Task

####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
</table>
Example:

```xml
  <ml:query/>
```

###&lt;invoke&gt; Task

####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
</table>
Example:

```xml
  <ml:invoke/>
```

###&lt;spawn&gt; Task

####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
</table>

#####Example:
```xml
  <ml:spawn/>
```

###&lt;corb&gt; Task

####Parameters
<table>
  <tr><th>Attribute</th><th>Description</th><th>Required</th></tr>
  <tr><td>xccurl</td><td>XCC Connection string</td><td>Yes</td></tr>
  <tr><td>failonerror</td><td>Determines wether an exception will cause task to fail</td><td>No</td></tr>
</table>
Example:

```xml
  <ml:corb/>
```

###&lt;xqdoc&gt; Task

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
###&lt;permissionset&gt; Element

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

