xquery version "1.0-ml";
(:~
: Model : validationTicket 
:         Validation ticket will contain the work for a job
: @author 
: @version   
: Requires Models:

~:)

module namespace model = "http://www.condenast.com/dam/2.0/model/validationTicket";

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
       name="validationTicket"
       description="Validation ticket will contain the work for a job"
       persistence="directory">
        <directory>/tickets/validation/</directory> 
        <declare-namespace prefix="cndam" namespace-uri="http://www.condenast.com/dam/2.0"/>
        <element name="id" type="integer" identity="true" label="ID">
            <navigation searchable="true" sortable="false" facetable="false"/>
        </element>        
        <element name="driverId" type="integer" label="Driver ID">
            <navigation searchable="true" sortable="false" facetable="false"/>
        </element>
        <element name="pkgid" type="integer" label="Package ID">
            <navigation searchable="true" sortable="true" facetable="true"/>
        </element>
        <element name="errorCount" type="integer" label="Total Errors">
            <navigation searchable="true" sortable="true" facetable="true"/>
        </element>
        <element name="warningCount" type="integer" label="Total Warnings">
            <navigation searchable="true" sortable="true" facetable="true"/>
        </element>
        <element name="infoCount" type="integer" label="Total Info">
            <navigation searchable="true" sortable="true" facetable="true"/>
        </element>
        <element name="schemaErrors" type="integer" label="Schema Errors">
            <navigation searchable="true" sortable="true" facetable="true"/>
        </element>
        <element name="schematronErrors" type="integer" label="Schematron Errors">
            <navigation searchable="true" sortable="true" facetable="true"/>
        </element>
        <element name="status" type="string" label="Status">
            <constraint inList="status-values"/>
            <navigation searchable="true" sortable="true" facetable="true"/>
        </element>
        <element name="filesystemURI" type="string" label="Files System URI">
            <constraint inList="status-value"/>
            <navigation searchable="true" sortable="true" facetable="true"/>
        </element>
        <element name="report" type="string" label="Report"/>
        <optionlist type="string" name="status-values" child-element="option">
            <option>Pass</option>
            <option>Fail</option>
         </optionlist>
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
   <search:constraint name="driverId">
      <search:element name="search:driverId" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="driverId" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="pkgid">
      <search:element name="search:pkgid" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="pkgid" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="errorCount">
      <search:element name="search:errorCount" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="errorCount" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="warningCount">
      <search:element name="search:warningCount" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="warningCount" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="infoCount">
      <search:element name="search:infoCount" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="infoCount" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="schemaErrors">
      <search:element name="search:schemaErrors" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="schemaErrors" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="schematronErrors">
      <search:element name="search:schematronErrors"
                      namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="schematronErrors" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="status">
      <search:element name="search:status" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="status" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:constraint name="filesystemURI">
      <search:element name="search:filesystemURI" namespace="http://marklogic.com/appservices/search"
                      exclude-result-prefixes="#all">
         <search:element name="filesystemURI" ns="http://www.condenast.com/dam/2.0"/>
      </search:element>
   </search:constraint>
   <search:operator name="sort">
      <search:state name="id">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="id"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="id-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="id"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="id-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="id"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="driverId">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="driverId"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="driverId-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="driverId"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="driverId-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="driverId"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="pkgid">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="pkgid"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="pkgid-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="pkgid"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="pkgid-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="pkgid"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="errorCount">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="errorCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="errorCount-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="errorCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="errorCount-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="errorCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="warningCount">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="warningCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="warningCount-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="warningCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="warningCount-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="warningCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="infoCount">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="infoCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="infoCount-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="infoCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="infoCount-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="infoCount"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schemaErrors">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="schemaErrors"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schemaErrors-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="schemaErrors"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schemaErrors-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="schemaErrors"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schematronErrors">
         <search:sort-order direction="ascending" type="integer">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="schematronErrors"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schematronErrors-descending">
         <search:sort-order direction="descending" type="integer">
      {$collation}
      <search:element ns="" name="schematronErrors"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="schematronErrors-ascending">
         <search:sort-order direction="ascending" type="integer">
            <search:element ns="http://www.condenast.com/dam/2.0" name="schematronErrors"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="status">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="status"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="status-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="status"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="status-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="status"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="filesystemURI">
         <search:sort-order direction="ascending" type="string">
      {$collation}
      <search:element ns="http://www.condenast.com/dam/2.0" name="filesystemURI"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="filesystemURI-descending">
         <search:sort-order direction="descending" type="string">
      {$collation}
      <search:element ns="" name="filesystemURI"/>
         </search:sort-order>
         <search:sort-order>
            <search:score/>
         </search:sort-order>
      </search:state>
      <search:state name="filesystemURI-ascending">
         <search:sort-order direction="ascending" type="string">
            <search:element ns="http://www.condenast.com/dam/2.0" name="filesystemURI"/>
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
    "/tickets/validation//",fn:generate-id($elem),".xml"
     )
};
(:Model Operations:)

(:~
 : Returns a list of status-values
 : @return  element(status-values)*   
 :)    
declare function model:list-status-values() as element(status-values)* 
{
<status-values>
   <option>Pass</option>
   <option>Fail</option>
</status-values> 
}; 

(:~
 : Create validationTicket
 : 
    $id as xs:integer, 
    $driverId as xs:integer, 
    $pkgid as xs:integer, 
    $errorCount as xs:integer, 
    $warningCount as xs:integer, 
    $infoCount as xs:integer, 
    $schemaErrors as xs:integer, 
    $schematronErrors as xs:integer, 
    $status as xs:string, 
    $filesystemURI as xs:string, 
    $report as xs:string
 :) 
declare function model:create( 
   $driverId as xs:integer, 
   $pkgid as xs:integer, 
   $errorCount as xs:integer, 
   $warningCount as xs:integer, 
   $infoCount as xs:integer, 
   $schemaErrors as xs:integer, 
   $schematronErrors as xs:integer, 
   $status as xs:string, 
   $filesystemURI as xs:string, 
   $report as xs:string  
  ) {
  let $id := model:create-id()
  let $create := 
   <validationTicket>
   <id>{$id}</id>
   <driverId>{$driverId}</driverId>
   <pkgid>{$pkgid}</pkgid>
   <errorCount>{$errorCount}</errorCount>
   <warningCount>{$warningCount}</warningCount>
   <infoCount>{$infoCount}</infoCount>
   <schemaErrors>{$schemaErrors}</schemaErrors>
   <schematronErrors>{$schematronErrors}</schematronErrors>
   <status>{$status}</status>
   <filesystemURI>{$filesystemURI}</filesystemURI>
   <report>{$report}</report>
</validationTicket>
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
 :  Retrieves a validationTicket by id
 :  @param $id
~:) 
declare function model:get($id as xs:integer
) as element(validationTicket)? {
    cts:search(/validationTicket,
        cts:and-query((
            cts:element-value-query(xs:QName("id"),$id),
            cts:directory-query("/tickets/validation/","infinity")
        )), ("filtered")
    )
};

(:~
 : Update Operation validationTicket
 :
 :
   : @param $id - id
   : @param $driverId - driverId
   : @param $pkgid - pkgid
   : @param $errorCount - errorCount
   : @param $warningCount - warningCount
   : @param $infoCount - infoCount
   : @param $schemaErrors - schemaErrors
   : @param $schematronErrors - schematronErrors
   : @param $status - status
   : @param $filesystemURI - filesystemURI
   : @param $report - report
 :) 
declare function model:update(
   $id as xs:integer?,
  
   $driverId as xs:integer,
   $pkgid as xs:integer,
   $errorCount as xs:integer,
   $warningCount as xs:integer,
   $infoCount as xs:integer,
   $schemaErrors as xs:integer,
   $schematronErrors as xs:integer,
   $status as xs:string,
   $filesystemURI as xs:string,
   $report as xs:string
) as element(validationTicket) 
{ 
   let $current := model:get($id)
   let $update := 
<validationTicket>
         <id>{$id}</id>
         <driverId>{$driverId}</driverId>
         <pkgid>{$pkgid}</pkgid>
         <errorCount>{$errorCount}</errorCount>
         <warningCount>{$warningCount}</warningCount>
         <infoCount>{$infoCount}</infoCount>
         <schemaErrors>{$schemaErrors}</schemaErrors>
         <schematronErrors>{$schematronErrors}</schematronErrors>
         <status>{$status}</status>
         <filesystemURI>{$filesystemURI}</filesystemURI>
         <report>{$report}</report>
     </validationTicket>
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
 :  Deletes a validationTicket
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
: Returns a list of validationTicket
: @return  element(validationTicket)*   
:)    
declare function model:list() as element(list)? 
{
  let $list  := 
    /validationTicket
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
     <validationTickets>{$list}</validationTickets>
     }</list>
}; 

(:~
: Find a record of validationTicket
: @return  element(validationTicket)*   
:)    
declare function model:find(
  $query as xs:string,
  $page as xs:integer,
  $size as xs:integer
) as element(validationTickets)? 
{
   let $start    := (($page - 1) * $size) + 1
   let $end      := $page * $size 
   let $search   := cts:search(/validationTicket,$query)[$start to $end]
   let $estimate := cts:search(/validationTicket,$query)
   return 
    <results count="{$estimate}">{
      $search
      }</results>

}; 
 
(:~
 : Provide search interface for validationTicket
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
: @return a sequence of validationTicket
:)
declare function model:build-relationships-to-self($ids as xs:string*) 
as element(validationTicket)*
{
    for $id in $ids
    let $model := model:get($id)
    return
        <validationTicket id="{ $model/@id }">{ $model/name/text() }</validationTicket>
};
 