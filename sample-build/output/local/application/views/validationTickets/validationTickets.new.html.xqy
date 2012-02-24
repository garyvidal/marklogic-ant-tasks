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
      <form name="form_validationTicket" method="post"
            action="/validationTickets/save.html">
         <ul>
            <li>
               <label class="desc">ID</label>
               <div>
                  <input class="field text small" name="id" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Driver ID</label>
               <div>
                  <input class="field text small" name="driverId" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Package ID</label>
               <div>
                  <input class="field text small" name="pkgid" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Total Errors</label>
               <div>
                  <input class="field text small" name="errorCount" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Total Warnings</label>
               <div>
                  <input class="field text small" name="warningCount" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Total Info</label>
               <div>
                  <input class="field text small" name="infoCount" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Schema Errors</label>
               <div>
                  <input class="field text small" name="schemaErrors" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Schematron Errors</label>
               <div>
                  <input class="field text small" name="schematronErrors" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Status</label>
               <div>
                  <input class="field text small" name="status" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Files System URI</label>
               <div>
                  <input class="field text small" name="filesystemURI" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Report</label>
               <div>
                  <input class="field text small" name="report" type="text" value=""/>
               </div>
            </li>
            <li class="buttons">
               <li class="buttons">
                  <button class="ui-state-default ui-corner-all ui-button" type="submit">Save</button>
               </li>
            </li>
         </ul>
      </form>
   </div>
   <div class="clearfix"/>
</div>