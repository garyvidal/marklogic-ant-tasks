xquery version "1.0-ml";
(:~
: Model : validationDriver 
:         Validation driver that will contain schemas/schematrons
: @author 
: @version   
: Requires Models:
 :    schema, :    schematron,
~:)

module namespace model = "http://www.condenast.com/dam/2.0/model/validationDriver";

(:Default Imports:)
import module namespace search = "http://marklogic.com/appservices/search" at 
"/MarkLogic/appservices/search/search.xqy";

import module namespace schema = "http://www.condenast.com/dam/2.0/model/schema"
    at "/application/model/schema-model.xqy";

import module namespace schematron = "http://www.condenast.com/dam/2.0/model/schematron"
    at "/application/model/schematron-model.xqy";

(:~
 : Model Definition 
 :)
declare variable $model as element() := 
<model xmlns="http://www.xquerrail-framework.com/domain"
       xmlns:security="http://www.xquery/security"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       name="validationDriver"
       description="Validation driver that will contain schemas/schematrons"
       persistence="directory">
        <directory>/config/validation/drivers/</directory>
        <declare-namespace prefix="cndam" namespace-uri="http://www.condenast.com/dam/2.0"/>
        <import-model name="schema"/>
        <import-model name="schematron"/>
        <element name="code" type="integer" identity="true" label="Code">
            <navigation searchable="true" sortable="false" facetable="false"/>
            <constraint required="true"/>
        </element>
        <element name="name" type="string" label="Name">
            <navigation searchable="true" facetable="true"/>
        </element>
        <element name="description" type="string" label="Description"/>
        <element name="moduleURI" type="string" label="Module URI"/>
     
        <hasMany name="schemas" type="schema" reference="model:schema:reference"/>
        <hasMany name="schematrons" type="schematron" reference="model:schematron:reference"/>
    </model>
;
(:~
 : Search Options Configuration
 :)
declare variable $model:search-options := 
  <search:options xmlns:domain="http://www.xquerrail-framework.com/domain"
                xmlns:search="http://marklogic.com/appservices/search"
                xmlns:builder="http://www.xquerrail-framework.com/builder">
   <search:constraint name="code">
      <search:element name="search:code" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="code" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="name">
      <search:element name="search:name" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="name" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:operator name="sort">
      <search:state name="code">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="code"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="code-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="code"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="code-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="code"/>
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
    "/config/validation/drivers//",fn:generate-id($elem),".xml"
     )
};
(:Model Operations:)

(:~
 : Create validationDriver
 : 
    $code as xs:integer, 
    $name as xs:string, 
    $description as xs:string, 
    $moduleURI as xs:string
 :) 
declare function model:create( 
   $name as xs:string, 
   $description as xs:string, 
   $moduleURI as xs:string  
  ) {
  let $code := model:create-id()
  let $create := 
   <validationDriver>
   <code>{$code}</code>
   <name>{$name}</name>
   <description>{$description}</description>
   <moduleURI>{$moduleURI}</moduleURI>
</validationDriver>
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
 :  Retrieves a validationDriver by id
 :  @param $code
~:) 
declare function model:get($code as xs:integer
) as element(validationDriver)? {
    cts:search(/validationDriver,
        cts:and-query((
            cts:element-value-query(xs:QName("code"),$code),
            cts:directory-query("/config/validation/drivers/","infinity")
        )), ("filtered")
    )
};

(:~
 : Update Operation validationDriver
 :
 :
   : @param $code - code
   : @param $name - name
   : @param $description - description
   : @param $moduleURI - moduleURI
 :) 
declare function model:update(
   $code as xs:integer?,
  
   $name as xs:string,
   $description as xs:string,
   $moduleURI as xs:string
) as element(validationDriver) 
{ 
   let $current := model:get($code)
   let $update := 
<validationDriver>
         <code>{$code}</code>
         <name>{$name}</name>
         <description>{$description}</description>
         <moduleURI>{$moduleURI}</moduleURI>
     </validationDriver>
  return
  ( if($current) 
    then xdmp:node-replace($current,$update)
    else 
    xdmp:document-insert(model:get-uri($update),
      $update,
      xdmp:default-permissions(),
      xdmp:default-collections()
    )
   ,$update
  )
};

(:~
 :  Deletes a validationDriver
 :  @param $code - Id of document delete
 :  @return xs:boolean denoted whether delete occurred
 :)  
declare function model:delete($code as xs:string
) as xs:boolean
{
  let $current := model:get($code)
  return
    try {(
      xdmp:node-delete($current),
      fn:true()
     )} catch($ex) {
      fn:false()  
    }
};

(:~
: Returns a list of validationDriver
: @return  element(validationDriver)*   
:)    
declare function model:list() as element(list)? 
{
  let $list  := 
    /validationDriver
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
     <validationDrivers>{$list}</validationDrivers>
     }</list>
}; 

(:~
: Find a record of validationDriver
: @return  element(validationDriver)*   
:)    
declare function model:find(
  $query as xs:string,
  $page as xs:integer,
  $size as xs:integer
) as element(validationDrivers)? 
{
   let $start    := (($page - 1) * $size) + 1
   let $end      := $page * $size 
   let $search   := cts:search(/validationDriver,$query)[$start to $end]
   let $estimate := cts:search(/validationDriver,$query)
   return 
    <results count="{$estimate}">{
      $search
      }</results>

}; 
 
(:~
 : Provide search interface for validationDriver
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
: @return a sequence of validationDriver
:)
declare function model:build-relationships-to-self($ids as xs:string*) 
as element(validationDriver)*
{
    for $id in $ids
    let $model := model:get($id)
    return
        <validationDriver code="{ $model/@code }">{ $model/name/text() }</validationDriver>
};
 
(:~
: This function will create the  schemas related 
: to this validationDriver then insert it into the doucment
: @param $currentId is the id of the validationDriver.
: @param $ids the ids of content you want to build the relationship too.
:)
declare function model:create-schemas($currentId as xs:string,$ids as xs:string*)
as empty-sequence()
{
    let $current := model:get($currentId)	  
   	let $node :=   
   		   <schemas>{
   		     schema:build-relationships-to-self($ids)
   		   }</schemas>
    return 
        xdmp:node-insert-child($current,$node)
};

(:~
: This function will return the  schemas related to this validationDriver
: @param $currentId is the id of the validationDriver .
: @return schemas related to this validationDriver
:)
declare function model:get-schemas($currentId as xs:string)
as element(schemas) 
{
    let $current := model:get($currentId)	  
    return 
        $current/schemas
};

(:~
: This function will replace the schemas related 
: to this validationDriver then replace the whole schemas node
: @param $currentId is the id of the validationDriver.
: @param $ids the ids of the content you want to build a relationship too.
:)
declare function model:update-schemas($currentId as xs:string,$ids as xs:string*)
as empty-sequence()
{
    let $current := model:get($currentId)/schemas	  
    let $node :=   
        <schemas>{
         schema:build-relationships-to-self($ids)
         }</schemas>
    return 
        xdmp:node-replace($current,$node)
};

(:~
: This function will remove all schemas related to this validationDriver
: @param $currentId is the id of the validationDriver .
:)
declare function model:delete-schemas($currentId as xs:string)
as element(schemas) 
{
    let $current := model:get($currentId)	  
    return 
        xdmp:node-delete($current/schemas)
};
 			
(:~
: This function will create the  schematrons related 
: to this validationDriver then insert it into the doucment
: @param $currentId is the id of the validationDriver.
: @param $ids the ids of content you want to build the relationship too.
:)
declare function model:create-schematrons($currentId as xs:string,$ids as xs:string*)
as empty-sequence()
{
    let $current := model:get($currentId)	  
   	let $node :=   
   		   <schematrons>{
   		     schematron:build-relationships-to-self($ids)
   		   }</schematrons>
    return 
        xdmp:node-insert-child($current,$node)
};

(:~
: This function will return the  schematrons related to this validationDriver
: @param $currentId is the id of the validationDriver .
: @return schematrons related to this validationDriver
:)
declare function model:get-schematrons($currentId as xs:string)
as element(schematrons) 
{
    let $current := model:get($currentId)	  
    return 
        $current/schematrons
};

(:~
: This function will replace the schematrons related 
: to this validationDriver then replace the whole schematrons node
: @param $currentId is the id of the validationDriver.
: @param $ids the ids of the content you want to build a relationship too.
:)
declare function model:update-schematrons($currentId as xs:string,$ids as xs:string*)
as empty-sequence()
{
    let $current := model:get($currentId)/schematrons	  
    let $node :=   
        <schematrons>{
         schematron:build-relationships-to-self($ids)
         }</schematrons>
    return 
        xdmp:node-replace($current,$node)
};

(:~
: This function will remove all schematrons related to this validationDriver
: @param $currentId is the id of the validationDriver .
:)
declare function model:delete-schematrons($currentId as xs:string)
as element(schematrons) 
{
    let $current := model:get($currentId)	  
    return 
        xdmp:node-delete($current/schematrons)
};
 			