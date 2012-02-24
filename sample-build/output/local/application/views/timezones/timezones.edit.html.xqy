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
      <h2>Edit Time Zones</h2>
   </div>
   <div class="content-box">
      <form name="form_timezone" method="post" action="/timezones/save.html">
         <ul class="editPanel">
            <li>
               <label class="desc" for="id">ID</label>
               <input id="d4e66" name="id" class="field text" value="{response:body()//*:id}"/>
            </li>
            <li>
               <label class="desc" for="offset">GMT Offset</label>
               <input id="d4e73" name="offset" class="field text" value="{response:body()//*:offset}"/>
            </li>
            <li>
               <label class="desc" for="name">Name</label>
               <input id="d4e80" name="name" class="field text" value="{response:body()//*:name}"/>
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