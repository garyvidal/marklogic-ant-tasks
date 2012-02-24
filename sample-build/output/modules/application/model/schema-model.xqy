xquery version "1.0-ml";
(:~
: Model : schema 
:         Schemas for validating ingested content
: @author 
: @version   
: Requires Models:

~:)

module namespace model = "http://www.condenast.com/dam/2.0/model/schema";

(:Default Imports:)
import module namespace search = "http://marklogic.com/appservices/search" at 
"/MarkLogic/appservices/search/search.xqy";

(:~
 : Model Definition 
 :)
declare variable $model as element() := 
<model xmlns="http://www.xquerrail-framework.com/domain"
       xmlns:security="http://www.xquery/security"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       name="schema"
       description="Schemas for validating ingested content"
       persistence="document">
        <document>/config/validation/schemas.xml</document>
        <declare-namespace prefix="cndam" namespace-uri="http://www.condenast.com/dam/2.0"/>
        <element name="id" type="string" identity="true" label="Schema ID">
            <navigation searchable="true" sortable="true" facetable="true"/>
            <constraint required="true"/>
        </element>
        <element name="name" type="string" label="Name">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="schemaLocation" type="string" label="Schema Location">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="namespace" type="string" label="Schema namespace">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="isPrimary" type="boolean" label="Is Primary Schema">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
    </model>
;
(:~
 : Search Options Configuration
 :)
declare variable $model:search-options := 
  <search:options xmlns:domain="http://www.xquerrail-framework.com/domain"
                xmlns:search="http://marklogic.com/appservices/search"
                xmlns:builder="http://www.xquerrail-framework.com/builder">
   <search:constraint name="id">
      <search:element name="search:id" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="id" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="name">
      <search:element name="search:name" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="name" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="schemaLocation">
      <search:element name="search:schemaLocation"
                      namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="schemaLocation" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="namespace">
      <search:element name="search:namespace" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="namespace" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="isPrimary">
      <search:element name="search:isPrimary" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="isPrimary" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:operator name="sort">
      <search:state name="id">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="id"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="id-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="id"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="id-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="id"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="name">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="name"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="name-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="name"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="name-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="name"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schemaLocation">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="schemaLocation"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schemaLocation-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="schemaLocation"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schemaLocation-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="schemaLocation"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="namespace">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="namespace"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="namespace-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="namespace"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="namespace-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="namespace"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="isPrimary">
         <search:sort-order direction="ascending" type="boolean">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="isPrimary"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="isPrimary-descending">
         <search:sort-order direction="descending" type="boolean">
      {$collation}
      <search:element ns="" name="isPrimary"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="isPrimary-ascending">
         <search:sort-order direction="ascending" type="boolean">
            <search:element ns="http://www.condenast.com/dam/2.0" name="isPrimary"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
   </search:operator>
</search:options>
;


(:Options Definition:)
declare option xdmp:mapping "false";
declare variable $collation := "http://marklogic.com/collation/codepoint";

(:Required Functions:)
declare function model:create-id() {
     fn:string(xdmp:random())
};

declare function model:get-uri($elem){
    fn:concat(
    fn:doc("/config/validation/schemas.xml"),fn:generate-id($elem),".xml"
     )
};
(:Model Operations:)

(:~
 : Create schema
 : 
    $id as xs:string, 
    $name as xs:string, 
    $schemaLocation as xs:string, 
    $namespace as xs:string, 
    $isPrimary as xs:boolean
 :) 
declare function model:create( 
   $name as xs:string, 
   $schemaLocation as xs:string, 
   $namespace as xs:string, 
   $isPrimary as xs:boolean  
  ) {
  let $id := model:create-id()
  let $create := 
   <schema>
   <id>{$id}</id>
   <name>{$name}</name>
   <schemaLocation>{$schemaLocation}</schemaLocation>
   <namespace>{$namespace}</namespace>
   <isPrimary>{$isPrimary}</isPrimary>
</schema>
  return
  (
    xdmp:document-insert(
       model:get-uri($create),
       $create(:,
       model:get-permissions(),
       model:get-collections():)
     ),
     $create
  )
  };

  
(:~
 :  Retrieves a schema by id
 :  @param $id
~:) 
declare function model:get($id as xs:string
) as element(schema)? {
    cts:search(fn:doc("/config/validation/schemas.xml")/schemas/schema,
        cts:and-query((
            cts:element-value-query(xs:QName("id"),$id),
            cts:document-query("/config/validation/schemas.xml")
        )), ("filtered")
    )
};

(:~
 : Update Operation schema
 :
 :
   : @param $id - id
   : @param $name - name
   : @param $schemaLocation - schemaLocation
   : @param $namespace - namespace
   : @param $isPrimary - isPrimary
 :) 
declare function model:update(
   $id as xs:string?,
  
   $name as xs:string,
   $schemaLocation as xs:string,
   $namespace as xs:string,
   $isPrimary as xs:boolean
) as element(schema) 
{ 
   let $current := model:get($id)
   let $update := 
<schema>
         <id>{$id}</id>
         <name>{$name}</name>
         <schemaLocation>{$schemaLocation}</schemaLocation>
         <namespace>{$namespace}</namespace>
         <isPrimary>{$isPrimary}</isPrimary>
     </schema>
  return
  ( if($current) 
    then xdmp:node-replace($current,$update)
    else 
    if(fn:doc("/config/validation/schemas.xml")/schemas) 
    then xdmp:node-insert-child(fn:doc("/config/validation/schemas.xml")/schemas,$update)
    else xdmp:document-insert(
       "/config/validation/schemas.xml",
       <schemas>{$update}</schemas>,
       xdmp:default-permissions(),
       xdmp:default-collections()
    )
   ,$update
  )
};

(:~
 :  Deletes a schema
 :  @param $id - Id of document delete
 :  @return xs:boolean denoted whether delete occurred
 :)  
declare function model:delete($id as xs:string
) as xs:boolean
{
  let $current := model:get($id)
  return
    try {(
      xdmp:node-delete($current),
      fn:true()
     )} catch($ex) {
      fn:false()  
    }
};

(:~
: Returns a list of schema
: @return  element(schema)*   
:)    
declare function model:list() as element(list)? 
{
  let $list  := 
    fn:doc("/config/validation/schemas.xml")/schemas
  let $count := 
  fn:count($list) 
  return 
     <list xmlns:domain="http://www.xquerrail-framework.com/domain"
      xmlns:search="http://marklogic.com/appservices/search"
      xmlns:builder="http://www.xquerrail-framework.com/builder">{
     $list/@*,
     <currentpage>1</currentpage>,
     <totalpages>1</totalpages>,
     <totalrecords>{$count}</totalrecords>,
     <schemas>{$list}</schemas>
     }</list>
}; 

(:~
: Find a record of schema
: @return  element(schema)*   
:)    
declare function model:find(
  $query as xs:string,
  $page as xs:integer,
  $size as xs:integer
) as element(schemas)? 
{
   let $start    := (($page - 1) * $size) + 1
   let $end      := $page * $size 
   let $search   := cts:search(fn:doc("/config/validation/schemas.xml")/schemas/schema,$query)[$start to $end]
   let $estimate := cts:search(fn:doc("/config/validation/schemas.xml")/schemas/schema,$query)
   return 
    <results count="{$estimate}">{
      $search
      }</results>

}; 
 
(:~
 : Provide search interface for schema
 : @param $query - Search query 
 : @param $sort - Sorting Key to sort results by
 : @param $start 
~:)
declare function model:search(
$query as xs:string,
$sort as xs:string,
$sort-order as xs:string,
$start as xs:integer,
$end as xs:integer
) as element(search:response)
{
   let $final := fn:concat($query," ",$sort)
   return
     search:search($final,$model:search-options,$start,$end)
};
 
(:~ 
: This function will create a sequence of nodes that represent each
: model for inlining in other relationships. 
: @param $ids a sequence of ids for models to be extracted
: @return a sequence of schema
:)
declare function model:build-relationships-to-self($ids as xs:string*) 
as element(schema)*
{
    for $id in $ids
    let $model := model:get($id)
    return
        <schema id="{ $model/@id }">{ $model/name/text() }</schema>
};
 