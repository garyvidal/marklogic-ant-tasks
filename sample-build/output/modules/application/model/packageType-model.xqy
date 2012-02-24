xquery version "1.0-ml";
(:~
: Model : packageType 
:         Package Type
: @author 
: @version   
: Requires Models:
 :    assetType,
~:)

module namespace model = "http://www.condenast.com/dam/2.0/model/packageType";

(:Default Imports:)
import module namespace search = "http://marklogic.com/appservices/search" at 
"/MarkLogic/appservices/search/search.xqy";

import module namespace assetType = "http://www.condenast.com/dam/2.0/model/assetType"
    at "/application/model/assetType-model.xqy";

(:~
 : Model Definition 
 :)
declare variable $model as element() := 
<model xmlns="http://www.xquerrail-framework.com/domain"
       xmlns:security="http://www.xquery/security"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       name="packageType"
       description="Package Type"
       persistence="document">
        <document>/packageTypes/packageTypes.xml</document>
        <declare-namespace prefix="cndam" namespace-uri="http://www.condenast.com/dam/2.0"/>
        <import-model name="assetType"/>
        <element name="id" type="string" identity="true">
            <navigation searchable="true" sortable="true" facetable="true"/>
            <constraint required="true"/>
        </element>
        <element name="name" type="string">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
       	<hasMany name="assetTypes" type="assetType" reference="model:assetType:reference"/>
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
    fn:doc("/packageTypes/packageTypes.xml"),fn:generate-id($elem),".xml"
     )
};
(:Model Operations:)

(:~
 : Create packageType
 : 
    $id as xs:string, 
    $name as xs:string
 :) 
declare function model:create( 
   $name as xs:string  
  ) {
  let $id := model:create-id()
  let $create := 
   <packageType>
   <id>{$id}</id>
   <name>{$name}</name>
</packageType>
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
 :  Retrieves a packageType by id
 :  @param $id
~:) 
declare function model:get($id as xs:string
) as element(packageType)? {
    cts:search(fn:doc("/packageTypes/packageTypes.xml")/packageTypes/packageType,
        cts:and-query((
            cts:element-value-query(xs:QName("id"),$id),
            cts:document-query("/packageTypes/packageTypes.xml")
        )), ("filtered")
    )
};

(:~
 : Update Operation packageType
 :
 :
   : @param $id - id
   : @param $name - name
 :) 
declare function model:update(
   $id as xs:string?,
  
   $name as xs:string
) as element(packageType) 
{ 
   let $current := model:get($id)
   let $update := 
<packageType>
         <id>{$id}</id>
         <name>{$name}</name>
     </packageType>
  return
  ( if($current) 
    then xdmp:node-replace($current,$update)
    else 
    if(fn:doc("/packageTypes/packageTypes.xml")/packageTypes) 
    then xdmp:node-insert-child(fn:doc("/packageTypes/packageTypes.xml")/packageTypes,$update)
    else xdmp:document-insert(
       "/packageTypes/packageTypes.xml",
       <packageTypes>{$update}</packageTypes>,
       xdmp:default-permissions(),
       xdmp:default-collections()
    )
   ,$update
  )
};

(:~
 :  Deletes a packageType
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
: Returns a list of packageType
: @return  element(packageType)*   
:)    
declare function model:list() as element(list)? 
{
  let $list  := 
    fn:doc("/packageTypes/packageTypes.xml")/packageTypes
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
     <packageTypes>{$list}</packageTypes>
     }</list>
}; 

(:~
: Find a record of packageType
: @return  element(packageType)*   
:)    
declare function model:find(
  $query as xs:string,
  $page as xs:integer,
  $size as xs:integer
) as element(packageTypes)? 
{
   let $start    := (($page - 1) * $size) + 1
   let $end      := $page * $size 
   let $search   := cts:search(fn:doc("/packageTypes/packageTypes.xml")/packageTypes/packageType,$query)[$start to $end]
   let $estimate := cts:search(fn:doc("/packageTypes/packageTypes.xml")/packageTypes/packageType,$query)
   return 
    <results count="{$estimate}">{
      $search
      }</results>

}; 
 
(:~
 : Provide search interface for packageType
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
: @return a sequence of packageType
:)
declare function model:build-relationships-to-self($ids as xs:string*) 
as element(packageType)*
{
    for $id in $ids
    let $model := model:get($id)
    return
        <packageType id="{ $model/@id }">{ $model/name/text() }</packageType>
};
 
(:~
: This function will create the  assetTypes related 
: to this packageType then insert it into the doucment
: @param $currentId is the id of the packageType.
: @param $ids the ids of content you want to build the relationship too.
:)
declare function model:create-assetTypes($currentId as xs:string,$ids as xs:string*)
as empty-sequence()
{
    let $current := model:get($currentId)	  
   	let $node :=   
   		   <assetTypes>{
   		     assetType:build-relationships-to-self($ids)
   		   }</assetTypes>
    return 
        xdmp:node-insert-child($current,$node)
};

(:~
: This function will return the  assetTypes related to this packageType
: @param $currentId is the id of the packageType .
: @return assetTypes related to this packageType
:)
declare function model:get-assetTypes($currentId as xs:string)
as element(assetTypes) 
{
    let $current := model:get($currentId)	  
    return 
        $current/assetTypes
};

(:~
: This function will replace the assetTypes related 
: to this packageType then replace the whole assetTypes node
: @param $currentId is the id of the packageType.
: @param $ids the ids of the content you want to build a relationship too.
:)
declare function model:update-assetTypes($currentId as xs:string,$ids as xs:string*)
as empty-sequence()
{
    let $current := model:get($currentId)/assetTypes	  
    let $node :=   
        <assetTypes>{
         assetType:build-relationships-to-self($ids)
         }</assetTypes>
    return 
        xdmp:node-replace($current,$node)
};

(:~
: This function will remove all assetTypes related to this packageType
: @param $currentId is the id of the packageType .
:)
declare function model:delete-assetTypes($currentId as xs:string)
as element(assetTypes) 
{
    let $current := model:get($currentId)	  
    return 
        xdmp:node-delete($current/assetTypes)
};
 			