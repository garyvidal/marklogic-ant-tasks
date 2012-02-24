xquery version "1.0-ml";
(:~
: Model : issnCode 
:         ISSN Codes
: @author 
: @version   
: Requires Models:

~:)

module namespace model = "http://www.condenast.com/dam/2.0/model/issnCode";

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
       name="issnCode"
       description="ISSN Codes"
       persistence="document">
        <document>/vocabularies/issnCodes.xml</document>
        <declare-namespace prefix="cndam" namespace-uri="http://www.condenast.com/dam/2.0"/>
        <element name="id" type="string" identity="true">
            <navigation searchable="true" sortable="true" facetable="true"/>
            <constraint required="true"/>
        </element>
        <element name="name" type="string">
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
    fn:doc("/vocabularies/issnCodes.xml"),fn:generate-id($elem),".xml"
     )
};
(:Model Operations:)

(:~
 : Create issnCode
 : 
    $id as xs:string, 
    $name as xs:string
 :) 
declare function model:create( 
   $name as xs:string  
  ) {
  let $id := model:create-id()
  let $create := 
   <issnCode>
   <id>{$id}</id>
   <name>{$name}</name>
</issnCode>
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
 :  Retrieves a issnCode by id
 :  @param $id
~:) 
declare function model:get($id as xs:string
) as element(issnCode)? {
    cts:search(fn:doc("/vocabularies/issnCodes.xml")/issnCodes/issnCode,
        cts:and-query((
            cts:element-value-query(xs:QName("id"),$id),
            cts:document-query("/vocabularies/issnCodes.xml")
        )), ("filtered")
    )
};

(:~
 : Update Operation issnCode
 :
 :
   : @param $id - id
   : @param $name - name
 :) 
declare function model:update(
   $id as xs:string?,
  
   $name as xs:string
) as element(issnCode) 
{ 
   let $current := model:get($id)
   let $update := 
<issnCode>
         <id>{$id}</id>
         <name>{$name}</name>
     </issnCode>
  return
  ( if($current) 
    then xdmp:node-replace($current,$update)
    else 
    if(fn:doc("/vocabularies/issnCodes.xml")/issnCodes) 
    then xdmp:node-insert-child(fn:doc("/vocabularies/issnCodes.xml")/issnCodes,$update)
    else xdmp:document-insert(
       "/vocabularies/issnCodes.xml",
       <issnCodes>{$update}</issnCodes>,
       xdmp:default-permissions(),
       xdmp:default-collections()
    )
   ,$update
  )
};

(:~
 :  Deletes a issnCode
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
: Returns a list of issnCode
: @return  element(issnCode)*   
:)    
declare function model:list() as element(list)? 
{
  let $list  := 
    fn:doc("/vocabularies/issnCodes.xml")/issnCodes
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
     <issnCodes>{$list}</issnCodes>
     }</list>
}; 

(:~
: Find a record of issnCode
: @return  element(issnCode)*   
:)    
declare function model:find(
  $query as xs:string,
  $page as xs:integer,
  $size as xs:integer
) as element(issnCodes)? 
{
   let $start    := (($page - 1) * $size) + 1
   let $end      := $page * $size 
   let $search   := cts:search(fn:doc("/vocabularies/issnCodes.xml")/issnCodes/issnCode,$query)[$start to $end]
   let $estimate := cts:search(fn:doc("/vocabularies/issnCodes.xml")/issnCodes/issnCode,$query)
   return 
    <results count="{$estimate}">{
      $search
      }</results>

}; 
 
(:~
 : Provide search interface for issnCode
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
: @return a sequence of issnCode
:)
declare function model:build-relationships-to-self($ids as xs:string*) 
as element(issnCode)*
{
    for $id in $ids
    let $model := model:get($id)
    return
        <issnCode id="{ $model/@id }">{ $model/name/text() }</issnCode>
};
 