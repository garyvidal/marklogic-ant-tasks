xquery version "1.0-ml";

(:~
 : Library Module to wrap existing XSD and Schematron validation.
 : Creates the existing Job file and performs all validation routines.
  
~:)
module namespace lib = "http://marklogic.com/ps/lib/validation";

import module namespace util = "http://marklogic.com/ps/lib/utilities" 
    at "/application/lib/utils.xqy";    
    
import module namespace ticket = "http://www.condenast.com/dam/2.0/model/validationTicket" 
    at "/application/model/validationTicket-model.xqy";    
    
import module namespace driver = "http://www.condenast.com/dam/2.0/model/validationDriver" 
    at "/application/model/validationDriver-model.xqy";    
    
import module namespace schema = "http://www.condenast.com/dam/2.0/model/schema" 
    at "/application/model/schema-model.xqy";   
    
import module namespace schematron = "http://www.condenast.com/dam/2.0/model/schematron" 
    at "/application/model/schematron-model.xqy";    

declare namespace sch  = "http://purl.oclc.org/dsdl/schematron";
declare namespace svrl = "http://purl.oclc.org/dsdl/svrl";
declare namespace zip = "xdmp:zip";

declare default function namespace "http://www.w3.org/2005/xpath-functions";

declare option xdmp:mapping "false";

(:~
 : Validates a document against an XML Schema (xsd)
 : Returns a validation results whether passed or failed 
 : if failed it returns the reason for the failure.
~:)
declare function lib:validate-schema(
    $xml as node(),
    $filename as xs:string,
    $ns as xs:string,
    $schema-uri as xs:string
)
{
let $valid :=  
   try {
       let $xml      := util:rebase-ns($xml,"xlink","http://www.w3.org/1999/xlink")
       let $validate := util:validate-with-schema($xml,$ns,$schema-uri)
   return <schema-valid>{fn:true()}</schema-valid>
     }
     catch( $ex ) {
       <schema-valid>{fn:false()}</schema-valid>,
       <validation-error>
         <code>{$ex//error:code/fn:string()}</code>
         <element>{fn:replace($ex//error:datum[1],"_SCHEMA_:","")}</element>
         <expected>{fn:replace($ex//error:datum[2],"_SCHEMA_:","")}</expected>
         <path>{fn:replace($ex//error:datum[3],"_SCHEMA_:","")}</path>
         <message>{fn:replace($ex//error:format-string,"_SCHEMA_:","")}</message>
      </validation-error>
    }
return
   <schema-validation>
   <schema-location>{$schema-uri}</schema-location>
   <root-element>{fn:local-name(fn:root($xml))}</root-element>
   <default-namespace>{$ns}</default-namespace>
   <filename>{$filename}</filename>
   {$valid}
   </schema-validation>
};

(:~
 :  Validates an XML file against a Schematron Schema
 :  and extracts artifacts from the SVRL report output into a 
 :  validation summary
~:)
declare function lib:validate-schematron
(
  $xml as document-node(),
  $schematron as element(sch:schema)
)
{
  let $validation := sch-lib:validate-document($xml,$schematron)
  let $errors := $validation//svrl:failed-assert[@flag eq  "ERROR"]
  let $warns   := $validation//svrl:failed-assert[@flag eq  "WARN"]
  let $infos   := $validation//svrl:failed-assert[@flag eq  "INFO"]
  let $report := $validation//svrl:successful-report
  let $rule-errors := $validation//svrl:fired-rule[svrl:failed-assert[@flag eq "ERROR"]]
  return 
  <schematron-validation>
     <schematron-valid>{fn:count($rule-errors) eq 0}</schematron-valid>    
     <rule-count>{fn:count($schematron//sch:rule)}</rule-count>
     <rule-fired>{fn:count($validation//svrl:fired-rule)}</rule-fired>
     <rule-error>{fn:count($rule-errors)}</rule-error>          
     <assert-count>{fn:count($validation//svrl:fired-rule[svrl:failed-assert|svrl:successful-report])}</assert-count>
     <error-count>{fn:count($errors)}</error-count>
     <warning-count>{fn:count($warns)}</warning-count>
     <info-count>{fn:count($infos)}</info-count>
     <report-count>{fn:count($report)}</report-count>
     <warnings>
      {for $warn in $warns
        let $path := xdmp:path(xdmp:value(fn:concat("$xml",$warn/@location)))
       return
         <warning id="{$warn/@id}">
            <rule-id>{fn:data($warn/ancestor::svrl:fired-rule/@id)}</rule-id>
            <context>{fn:data($warn/ancestor::svrl:fired-rule/@context)}</context>
            <location>{$path}</location>
            <message>{$warn/svrl:text/text()}</message>
         </warning>
      }
     </warnings>
     <errors>
     {
        for $error in $errors
        let $path := xdmp:path(xdmp:value(fn:concat("$xml",$error/@location)))
        return
          <error id="{$error/@id}">
            <rule-id>{fn:data($error/ancestor::svrl:fired-rule/@id)}</rule-id>
            <context>{fn:data($error/ancestor::svrl:fired-rule/@context)}</context>
            <location>{$path}</location>
            <message>{$error/svrl:text/text()}</message>
          </error>
     }
     </errors>
     <infos>
     {
        for $info in $infos
        let $path := xdmp:path(xdmp:value(fn:concat("$xml",$info/@location)))
        return
          <info id="{$info/@id}">
            <rule-id>{fn:data($info/ancestor::svrl:fired-rule/@id)}</rule-id>
            <context>{fn:data($info/ancestor::svrl:fired-rule/@context)}</context>
            <location>{$path}</location>
            <message>{$info/svrl:text/text()}</message>
          </info>
     }
     </infos>
     {$validation}
  </schematron-validation>/*
};

(:~
 : Performs the validation routines and creates a jobdetail element
 : 
~:)
declare function lib:validate-file(
    $uri as xs:string, $ticketId as xs:string
)
{
   (: fetch the doc to validate :)
   let $doc := fn:doc($uri)
   
   (: Fetch the ticket and validation driver :)
   let $ticket := ticket:get($ticketId)
   let $driver := driver:get($ticket/driverId)
   
   (: Extract the schemas and schematrons from driver :)
   let $schemas := $driver//schemas
   let $schematrons := $driver//schematrons 
   
   (: Validate the document with all the schemas :)
   let $xs-validate :=
       for $schema in $schemas 
       let $namespace := $schema/namespace/fn:string()
       let $schema-loc := $schema/schema-location/fn:string()
       return 
           lib:validate-schema($rebased/element(),fn:base-uri($doc), $namespace,$schema-loc)
      
   (: Validate with all schematrons :)
   let $schematron-validation := 
        for $sch in $schematrons
        let $schematron := schematron:get($sch)/sch:schema
        let $validate := if($schematron) then lib:validate-schematron($doc,$schematron) else ()
        return
         if($schema) then
          <schematron-validation>
          <schematron-id>{fn:data($schema/@id)}</schematron-id>
          {$validate}
          </schematron-validation>
        else ()
        
    let $is-xsvalid  := $xs-validate/schema-valid eq "true"
    let $is-schvalid := every $v in $schematron-validation//schematron-valid satisfies $v eq "true"
    let $is-valid := if($is-xsvalid and $is-schvalid) then "Valid" else "Invalid"
    let $dtm := fn:current-dateTime()
    
    return 
    <jobdetail>
      <id>{xdmp:random()}</id>      
      <created>{$dtm}</created>
      <created-year>{fn:year-from-dateTime($dtm)}</created-year>
      <created-month>{fn:month-from-dateTime($dtm)}</created-month>
      <creator>{xdmp:get-current-user()}</creator>
      <job-id>{fn:string($job/id)}</job-id>
      {$job/project-id}
      {$job/vendor-id}
      {$job/schema-id}
      <filename>{fn:base-uri($doc)}</filename>
      <status>{$is-valid}</status>
      <pf-status></pf-status>
      {$xs-validate}
      <schematron-validations>{$schematron-validation}</schematron-validations>
    </jobdetail> 
};