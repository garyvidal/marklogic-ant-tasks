(:@GENERATED@:)
xquery version "1.0-ml";
declare default element namespace "http://www.w3.org/1999/xhtml";
import module namespace response = "http://www.xquerrail-framework.com/response" at "/_framework/response.xqy";
declare option xdmp:output "indent-untyped=yes";
declare variable $response as map:map external;
let $init := response:initialize($response)
return
<div xmlns="http://www.w3.org/1999/xhtml" id="form-wrapper">
   <div class="inner-page-title">
      <h2>Edit Validation Ticket</h2>
   </div>
   <div class="content-box">
      <form name="form_validationTicket" method="post"
            action="/validationTickets/save.html">
         <ul class="editPanel">
            <li>
               <label class="desc" for="id">ID</label>
               <input id="d4e385" name="id" class="field text" value="{response:body()//*:id}"/>
            </li>
            <li>
               <label class="desc" for="driverId">Driver ID</label>
               <input id="d4e390" name="driverId" class="field text"
                      value="{response:body()//*:driverId}"/>
            </li>
            <li>
               <label class="desc" for="pkgid">Package ID</label>
               <input id="d4e395" name="pkgid" class="field text" value="{response:body()//*:pkgid}"/>
            </li>
            <li>
               <label class="desc" for="errorCount">Total Errors</label>
               <input id="d4e401" name="errorCount" class="field text"
                      value="{response:body()//*:errorCount}"/>
            </li>
            <li>
               <label class="desc" for="warningCount">Total Warnings</label>
               <input id="d4e406" name="warningCount" class="field text"
                      value="{response:body()//*:warningCount}"/>
            </li>
            <li>
               <label class="desc" for="infoCount">Total Info</label>
               <input id="d4e411" name="infoCount" class="field text"
                      value="{response:body()//*:infoCount}"/>
            </li>
            <li>
               <label class="desc" for="schemaErrors">Schema Errors</label>
               <input id="d4e416" name="schemaErrors" class="field text"
                      value="{response:body()//*:schemaErrors}"/>
            </li>
            <li>
               <label class="desc" for="schematronErrors">Schematron Errors</label>
               <input id="d4e421" name="schematronErrors" class="field text"
                      value="{response:body()//*:schematronErrors}"/>
            </li>
            <li>
               <label class="desc" for="status">Status</label>
               <select id="d4e426" name="status" class="field text">
       {for $opt in response:data("status")//*:option
        return
          <option>
          {if($opt/@value eq {response:body()//*:status})
           then attribute selected {"selected"}
           else ()
          }{$opt/text()}          
          </option>
       }
      </select>
            </li>
            <li>
               <label class="desc" for="filesystemURI">Files System URI</label>
               <select id="d4e434" name="filesystemURI" class="field text">
       {for $opt in response:data("status")//*:option
        return
          <option>
          {if($opt/@value eq {response:body()//*:filesystemURI})
           then attribute selected {"selected"}
           else ()
          }{$opt/text()}          
          </option>
       }
      </select>
            </li>
            <li>
               <label class="desc" for="report">Report</label>
               <input id="d4e441" name="report" class="field text"
                      value="{response:body()//*:report}"/>
            </li>
            <li class="buttons">
               <label/>
               <button id="saveButton" class="ui-state-default ui-corner-all ui-button" type="submit">Save</button>
               <button id="cancelButton" class="ui-state-default ui-corner-all ui-button"
                       type="button">Cancel</button>
            </li>
         </ul>
      </form>
   </div>
   <div class="clearfix"/>
</div>