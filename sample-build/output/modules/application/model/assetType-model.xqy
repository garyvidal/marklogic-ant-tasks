xquery version "1.0-ml";
(:~
: Model : assetType 
:         AssetType
: @author 
: @version   
: Requires Models:

~:)

module namespace model = "http://www.condenast.com/dam/2.0/model/assetType";

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
       name="assetType"
       description="AssetType"
       persistence="document">
        <document>/assetTypes/assetTypes.xml</document>
        <declare-namespace prefix="cndam" namespace-uri="http://www.condenast.com/dam/2.0"/>
        <element name="id" type="string" identity="true" label="ID">
            <navigation searchable="true" sortable="true" facetable="true"/>
            <constraint required="true"/>
        </element>
        <element name="description" type="string" label="Asset Description">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="namespace-uri" type="string" label="Namespace">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="element" type="string" label="Root Name">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="xmlSchemaLocation" type="string" label="Schema Location">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="isActive" type="boolean" label="Active">
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
   <search:constraint name="description">
      <search:element name="search:description" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="description" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="namespace-uri">
      <search:element name="search:namespace-uri" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="namespace-uri" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="element">
      <search:element name="search:element" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="element" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="xmlSchemaLocation">
      <search:element name="search:xmlSchemaLocation"
                      namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="xmlSchemaLocation" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="isActive">
      <search:element name="search:isActive" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="isActive" ns="http://www.condenast.com/dam/2.0"/>
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
      <search:state name="description">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="description"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="description-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="description"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="description-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="description"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="namespace-uri">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="namespace-uri"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="namespace-uri-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="namespace-uri"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="namespace-uri-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="namespace-uri"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="element">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="element"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="element-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="element"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="element-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="element"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="xmlSchemaLocation">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="xmlSchemaLocation"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="xmlSchemaLocation-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="xmlSchemaLocation"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="xmlSchemaLocation-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="xmlSchemaLocation"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="isActive">
         <search:sort-order direction="ascending" type="boolean">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="isActive"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="isActive-descending">
         <search:sort-order direction="descending" type="boolean">
      {$collation}
      <search:element ns="" name="isActive"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="isActive-ascending">
         <search:sort-order direction="ascending" type="boolean">
            <search:element ns="http://www.condenast.com/dam/2.0" name="isActive"/>
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
    fn:doc("/assetTypes/assetTypes.xml"),fn:generate-id($elem),".xml"
     )
};
(:Model Operations:)

(:~
 : Create assetType
 : 
    $id as xs:string, 
    $description as xs:string, 
    $namespace-uri as xs:string, 
    $element as xs:string, 
    $xmlSchemaLocation as xs:string, 
    $isActive as xs:boolean
 :) 
declare function model:create( 
   $description as xs:string, 
   $namespace-uri as xs:string, 
   $element as xs:string, 
   $xmlSchemaLocation as xs:string, 
   $isActive as xs:boolean  
  ) {
  let $id := model:create-id()
  let $create := 
   <assetType>
   <id>{$id}</id>
   <description>{$description}</description>
   <namespace-uri>{$namespace-uri}</namespace-uri>
   <element>{$element}</element>
   <xmlSchemaLocation>{$xmlSchemaLocation}</xmlSchemaLocation>
   <isActive>{$isActive}</isActive>
</assetType>
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
 :  Retrieves a assetType by id
 :  @param $id
~:) 
declare function model:get($id as xs:string
) as element(assetType)? {
    cts:search(fn:doc("/assetTypes/assetTypes.xml")/assetTypes/assetType,
        cts:and-query((
            cts:element-value-query(xs:QName("id"),$id),
            cts:document-query("/assetTypes/assetTypes.xml")
        )), ("filtered")
    )
};

(:~
 : Update Operation assetType
 :
 :
   : @param $id - id
   : @param $description - description
   : @param $namespace-uri - namespace-uri
   : @param $element - element
   : @param $xmlSchemaLocation - xmlSchemaLocation
   : @param $isActive - isActive
 :) 
declare function model:update(
   $id as xs:string?,
  
   $description as xs:string,
   $namespace-uri as xs:string,
   $element as xs:string,
   $xmlSchemaLocation as xs:string,
   $isActive as xs:boolean
) as element(assetType) 
{ 
   let $current := model:get($id)
   let $update := 
<assetType>
         <id>{$id}</id>
         <description>{$description}</description>
         <namespace-uri>{$namespace-uri}</namespace-uri>
         <element>{$element}</element>
         <xmlSchemaLocation>{$xmlSchemaLocation}</xmlSchemaLocation>
         <isActive>{$isActive}</isActive>
     </assetType>
  return
  ( if($current) 
    then xdmp:node-replace($current,$update)
    else 
    if(fn:doc("/assetTypes/assetTypes.xml")/assetTypes) 
    then xdmp:node-insert-child(fn:doc("/assetTypes/assetTypes.xml")/assetTypes,$update)
    else xdmp:document-insert(
       "/assetTypes/assetTypes.xml",
       <assetTypes>{$update}</assetTypes>,
       xdmp:default-permissions(),
       xdmp:default-collections()
    )
   ,$update
  )
};

(:~
 :  Deletes a assetType
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
: Returns a list of assetType
: @return  element(assetType)*   
:)    
declare function model:list() as element(list)? 
{
  let $list  := 
    fn:doc("/assetTypes/assetTypes.xml")/assetTypes
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
     <assetTypes>{$list}</assetTypes>
     }</list>
}; 

(:~
: Find a record of assetType
: @return  element(assetType)*   
:)    
declare function model:find(
  $query as xs:string,
  $page as xs:integer,
  $size as xs:integer
) as element(assetTypes)? 
{
   let $start    := (($page - 1) * $size) + 1
   let $end      := $page * $size 
   let $search   := cts:search(fn:doc("/assetTypes/assetTypes.xml")/assetTypes/assetType,$query)[$start to $end]
   let $estimate := cts:search(fn:doc("/assetTypes/assetTypes.xml")/assetTypes/assetType,$query)
   return 
    <results count="{$estimate}">{
      $search
      }</results>

}; 
 
(:~
 : Provide search interface for assetType
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
: @return a sequence of assetType
:)
declare function model:build-relationships-to-self($ids as xs:string*) 
as element(assetType)*
{
    for $id in $ids
    let $model := model:get($id)
    return
        <assetType id="{ $model/@id }">{ $model/name/text() }</assetType>
};
 