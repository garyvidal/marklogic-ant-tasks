xquery version "1.0-ml";
(:~
: Model : countryCode 
:         Country Code Controlled Vocabulary
: @author 
: @version   
: Requires Models:

~:)

module namespace model = "http://www.condenast.com/dam/2.0/model/countryCode";

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
       name="countryCode"
       description="Country Code Controlled Vocabulary"
       persistence="document">
        <document>/vocabularies/countryCodes.xml</document>
        <declare-namespace prefix="cndam" namespace-uri="http://www.condenast.com/dam/2.0"/>
        <element name="id" type="string" identity="true" label="ISO Country Code">
            <navigation searchable="true" sortable="true" facetable="true"/>
            <constraint required="true"/>
        </element>
        <element name="name" type="string" label="Name">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="iso3" type="integer" label="ISO 3 digit">
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
   <search:constraint name="iso3">
      <search:element name="search:iso3" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="iso3" ns="http://www.condenast.com/dam/2.0"/>
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
      <search:state name="iso3">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="iso3"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="iso3-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="iso3"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="iso3-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="iso3"/>
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
    fn:doc("/vocabularies/countryCodes.xml"),fn:generate-id($elem),".xml"
     )
};
(:Model Operations:)

(:~
 : Create countryCode
 : 
    $id as xs:string, 
    $name as xs:string, 
    $iso3 as xs:integer
 :) 
declare function model:create( 
   $name as xs:string, 
   $iso3 as xs:integer  
  ) {
  let $id := model:create-id()
  let $create := 
   <countryCode>
   <id>{$id}</id>
   <name>{$name}</name>
   <iso3>{$iso3}</iso3>
</countryCode>
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
 :  Retrieves a countryCode by id
 :  @param $id
~:) 
declare function model:get($id as xs:string
) as element(countryCode)? {
    cts:search(fn:doc("/vocabularies/countryCodes.xml")/countryCodes/countryCode,
        cts:and-query((
            cts:element-value-query(xs:QName("id"),$id),
            cts:document-query("/vocabularies/countryCodes.xml")
        )), ("filtered")
    )
};

(:~
 : Update Operation countryCode
 :
 :
   : @param $id - id
   : @param $name - name
   : @param $iso3 - iso3
 :) 
declare function model:update(
   $id as xs:string?,
  
   $name as xs:string,
   $iso3 as xs:integer
) as element(countryCode) 
{ 
   let $current := model:get($id)
   let $update := 
<countryCode>
         <id>{$id}</id>
         <name>{$name}</name>
         <iso3>{$iso3}</iso3>
     </countryCode>
  return
  ( if($current) 
    then xdmp:node-replace($current,$update)
    else 
    if(fn:doc("/vocabularies/countryCodes.xml")/countryCodes) 
    then xdmp:node-insert-child(fn:doc("/vocabularies/countryCodes.xml")/countryCodes,$update)
    else xdmp:document-insert(
       "/vocabularies/countryCodes.xml",
       <countryCodes>{$update}</countryCodes>,
       xdmp:default-permissions(),
       xdmp:default-collections()
    )
   ,$update
  )
};

(:~
 :  Deletes a countryCode
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
: Returns a list of countryCode
: @return  element(countryCode)*   
:)    
declare function model:list() as element(list)? 
{
  let $list  := 
    fn:doc("/vocabularies/countryCodes.xml")/countryCodes
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
     <countryCodes>{$list}</countryCodes>
     }</list>
}; 

(:~
: Find a record of countryCode
: @return  element(countryCode)*   
:)    
declare function model:find(
  $query as xs:string,
  $page as xs:integer,
  $size as xs:integer
) as element(countryCodes)? 
{
   let $start    := (($page - 1) * $size) + 1
   let $end      := $page * $size 
   let $search   := cts:search(fn:doc("/vocabularies/countryCodes.xml")/countryCodes/countryCode,$query)[$start to $end]
   let $estimate := cts:search(fn:doc("/vocabularies/countryCodes.xml")/countryCodes/countryCode,$query)
   return 
    <results count="{$estimate}">{
      $search
      }</results>

}; 
 
(:~
 : Provide search interface for countryCode
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
: @return a sequence of countryCode
:)
declare function model:build-relationships-to-self($ids as xs:string*) 
as element(countryCode)*
{
    for $id in $ids
    let $model := model:get($id)
    return
        <countryCode id="{ $model/@id }">{ $model/name/text() }</countryCode>
};
 