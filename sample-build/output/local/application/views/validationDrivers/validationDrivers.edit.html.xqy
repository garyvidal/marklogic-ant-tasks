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
      <h2>Edit Validation Driver</h2>
   </div>
   <div class="content-box">
      <form name="form_validationDriver" method="post"
            action="/validationDrivers/save.html">
         <ul class="editPanel">
            <li>
               <label class="desc" for="code">Code</label>
               <input id="d4e355" name="code" class="field text" value="{response:body()//*:code}"/>
            </li>
            <li>
               <label class="desc" for="name">Name</label>
               <input id="d4e363" name="name" class="field text" value="{response:body()//*:name}"/>
            </li>
            <li>
               <label class="desc" for="description">Description</label>
               <input id="d4e368" name="description" class="field text"
                      value="{response:body()//*:description}"/>
            </li>
            <li>
               <label class="desc" for="moduleURI">Module URI</label>
               <input id="d4e370" name="moduleURI" class="field text"
                      value="{response:body()//*:moduleURI}"/>
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