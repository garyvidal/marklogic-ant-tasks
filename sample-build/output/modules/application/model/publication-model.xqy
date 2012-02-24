xquery version "1.0-ml";
(:~
: Model : publication 
:         Publication Group
: @author 
: @version   
: Requires Models:
 :    issnCode,
~:)

module namespace model = "http://www.condenast.com/dam/2.0/model/publication";

(:Default Imports:)
import module namespace search = "http://marklogic.com/appservices/search" at 
"/MarkLogic/appservices/search/search.xqy";

import module namespace issnCode = "http://www.condenast.com/dam/2.0/model/issnCode"
    at "/application/model/issnCode-model.xqy";

(:~
 : Model Definition 
 :)
declare variable $model as element() := 
<model xmlns="http://www.xquerrail-framework.com/domain"
       xmlns:security="http://www.xquery/security"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       name="publication"
       description="Publication Group"
       persistence="document">
        <document>/vocabularies/publications.xml</document>
        <declare-namespace prefix="cndam" namespace-uri="http://www.condenast.com/dam/2.0"/> 
        <import-model name="issnCode"/>
        <element name="publicationId" type="string" identity="true" label="ID">
            <navigation searchable="true" sortable="true" facetable="true"/>
            <constraint required="true"/>
        </element>
        <element name="publicationName" type="string" label="Publication Name">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <element name="issnNumber" type="string" label="ISSN Number">
            <navigation searchable="true" sortable="true"/>
            <constraint required="true"/>
        </element>
        <hasMany name="issnCodes" type="issnCode" reference="model:issnCode:reference"/>        
    </model>
;
(:~
 : Search Options Configuration
 :)
declare variable $model:search-options := 
  <search:options xmlns:domain="http://www.xquerrail-framework.com/domain"
                xmlns:search="http://marklogic.com/appservices/search"
                xmlns:builder="http://www.xquerrail-framework.com/builder">
   <search:constraint name="publicationId">
      <search:element name="search:publicationId" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="publicationId" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="publicationName">
      <search:element name="search:publicationName"
                      namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="publicationName" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="issnNumber">
      <search:element name="search:issnNumber" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="issnNumber" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:operator name="sort">
      <search:state name="publicationId">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="publicationId"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="publicationId-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="publicationId"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="publicationId-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="publicationId"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="publicationName">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="publicationName"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="publicationName-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="publicationName"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="publicationName-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="publicationName"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="issnNumber">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="issnNumber"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="issnNumber-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="issnNumber"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="issnNumber-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="issnNumber"/>
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
    fn:doc("/vocabularies/publications.xml"),fn:generate-id($elem),".xml"
     )
};
(:Model Operations:)

(:~
 : Create publication
 : 
    $publicationId as xs:string, 
    $publicationName as xs:string, 
    $issnNumber as xs:string
 :) 
declare function model:create( 
   $publicationName as xs:string, 
   $issnNumber as xs:string  
  ) {
  let $publicationId := model:create-id()
  let $create := 
   <publication>
   <publicationId>{$publicationId}</publicationId>
   <publicationName>{$publicationName}</publicationName>
   <issnNumber>{$issnNumber}</issnNumber>
</publication>
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
 :  Retrieves a publication by id
 :  @param $publicationId
~:) 
declare function model:get($publicationId as xs:string
) as element(publication)? {
    cts:search(fn:doc("/vocabularies/publications.xml")/publications/publication,
        cts:and-query((
            cts:element-value-query(xs:QName("publicationId"),$publicationId),
            cts:document-query("/vocabularies/publications.xml")
        )), ("filtered")
    )
};

(:~
 : Update Operation publication
 :
 :
   : @param $publicationId - publicationId
   : @param $publicationName - publicationName
   : @param $issnNumber - issnNumber
 :) 
declare function model:update(
   $publicationId as xs:string?,
  
   $publicationName as xs:string,
   $issnNumber as xs:string
) as element(publication) 
{ 
   let $current := model:get($publicationId)
   let $update := 
<publication>
         <publicationId>{$publicationId}</publicationId>
         <publicationName>{$publicationName}</publicationName>
         <issnNumber>{$issnNumber}</issnNumber>
     </publication>
  return
  ( if($current) 
    then xdmp:node-replace($current,$update)
    else 
    if(fn:doc("/vocabularies/publications.xml")/publications) 
    then xdmp:node-insert-child(fn:doc("/vocabularies/publications.xml")/publications,$update)
    else xdmp:document-insert(
       "/vocabularies/publications.xml",
       <publications>{$update}</publications>,
       xdmp:default-permissions(),
       xdmp:default-collections()
    )
   ,$update
  )
};

(:~
 :  Deletes a publication
 :  @param $publicationId - Id of document delete
 :  @return xs:boolean denoted whether delete occurred
 :)  
declare function model:delete($publicationId as xs:string
) as xs:boolean
{
  let $current := model:get($publicationId)
  return
    try {(
      xdmp:node-delete($current),
      fn:true()
     )} catch($ex) {
      fn:false()  
    }
};

(:~
: Returns a list of publication
: @return  element(publication)*   
:)    
declare function model:list() as element(list)? 
{
  let $list  := 
    fn:doc("/vocabularies/publications.xml")/publications
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
     <publications>{$list}</publications>
     }</list>
}; 

(:~
: Find a record of publication
: @return  element(publication)*   
:)    
declare function model:find(
  $query as xs:string,
  $page as xs:integer,
  $size as xs:integer
) as element(publications)? 
{
   let $start    := (($page - 1) * $size) + 1
   let $end      := $page * $size 
   let $search   := cts:search(fn:doc("/vocabularies/publications.xml")/publications/publication,$query)[$start to $end]
   let $estimate := cts:search(fn:doc("/vocabularies/publications.xml")/publications/publication,$query)
   return 
    <results count="{$estimate}">{
      $search
      }</results>

}; 
 
(:~
 : Provide search interface for publication
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
: @return a sequence of publication
:)
declare function model:build-relationships-to-self($ids as xs:string*) 
as element(publication)*
{
    for $id in $ids
    let $model := model:get($id)
    return
        <publication publicationId="{ $model/@publicationId }">{ $model/name/text() }</publication>
};
 
(:~
: This function will create the  issnCodes related 
: to this publication then insert it into the doucment
: @param $currentId is the id of the publication.
: @param $ids the ids of content you want to build the relationship too.
:)
declare function model:create-issnCodes($currentId as xs:string,$ids as xs:string*)
as empty-sequence()
{
    let $current := model:get($currentId)	  
   	let $node :=   
   		   <issnCodes>{
   		     issnCode:build-relationships-to-self($ids)
   		   }</issnCodes>
    return 
        xdmp:node-insert-child($current,$node)
};

(:~
: This function will return the  issnCodes related to this publication
: @param $currentId is the id of the publication .
: @return issnCodes related to this publication
:)
declare function model:get-issnCodes($currentId as xs:string)
as element(issnCodes) 
{
    let $current := model:get($currentId)	  
    return 
        $current/issnCodes
};

(:~
: This function will replace the issnCodes related 
: to this publication then replace the whole issnCodes node
: @param $currentId is the id of the publication.
: @param $ids the ids of the content you want to build a relationship too.
:)
declare function model:update-issnCodes($currentId as xs:string,$ids as xs:string*)
as empty-sequence()
{
    let $current := model:get($currentId)/issnCodes	  
    let $node :=   
        <issnCodes>{
         issnCode:build-relationships-to-self($ids)
         }</issnCodes>
    return 
        xdmp:node-replace($current,$node)
};

(:~
: This function will remove all issnCodes related to this publication
: @param $currentId is the id of the publication .
:)
declare function model:delete-issnCodes($currentId as xs:string)
as element(issnCodes) 
{
    let $current := model:get($currentId)	  
    return 
        xdmp:node-delete($current/issnCodes)
};
 			