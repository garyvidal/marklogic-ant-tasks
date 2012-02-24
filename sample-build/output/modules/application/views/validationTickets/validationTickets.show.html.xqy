(:@GENERATED@:)
xquery version "1.0-ml";
declare default element namespace "http://www.w3.org/1999/xhtml";
import module namespace response = "http://www.xquerrail-framework.com/response" at "/_framework/response.xqy";
declare option xdmp:output "indent-untyped=yes";
declare variable $response as map:map external;
let $init := response:initialize($response)
return
<div id="form-wrapper">
   <div class="inner-page-title">
      <h2>Validation Ticket</h2>
   </div>
   <div class="content-box">
      <form name="form_validationTicket" method="get" action="/validationTickets/edit.html">
         <ul>
            <li>
               <label class="desc">ID</label>
               <span>{response:body()/*:id}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Driver ID</label>
               <span>{response:body()/*:driverId}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Package ID</label>
               <span>{response:body()/*:pkgid}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Total Errors</label>
               <span>{response:body()/*:errorCount}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Total Warnings</label>
               <span>{response:body()/*:warningCount}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Total Info</label>
               <span>{response:body()/*:infoCount}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Schema Errors</label>
               <span>{response:body()/*:schemaErrors}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Schematron Errors</label>
               <span>{response:body()/*:schematronErrors}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Status</label>
               <span>{response:body()/*:status}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Files System URI</label>
               <span>{response:body()/*:filesystemURI}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Report</label>
               <span>{response:body()/*:report}{" "}</span>
               <br/>
            </li>
            <li class="buttons">
               <button class="ui-state-default ui-button" type="submit">Edit</button>
            </li>
         </ul>
      </form>
      <h2>XML Format</h2>
      <div style="width:400px">
         <pre>{
     xdmp:quote(response:body())
     }</pre>
      </div>
   </div>
   <div class="clearfix"/>
</div>