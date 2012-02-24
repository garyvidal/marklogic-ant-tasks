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
      <h2>Edit Schemas</h2>
   </div>
   <div class="content-box">
      <form name="form_schema" method="post" action="/schemas/save.html">
         <ul class="editPanel">
            <li>
               <label class="desc" for="id">Schema ID</label>
               <input id="d4e280" name="id" class="field text" value="{response:body()//*:id}"/>
            </li>
            <li>
               <label class="desc" for="name">Name</label>
               <input id="d4e287" name="name" class="field text" value="{response:body()//*:name}"/>
            </li>
            <li>
               <label class="desc" for="schemaLocation">Schema Location</label>
               <input id="d4e294" name="schemaLocation" class="field text"
                      value="{response:body()//*:schemaLocation}"/>
            </li>
            <li>
               <label class="desc" for="namespace">Schema namespace</label>
               <input id="d4e302" name="namespace" class="field text"
                      value="{response:body()//*:namespace}"/>
            </li>
            <li>
               <label class="desc" for="isPrimary">Is Primary Schema</label>
               <input id="d4e309" name="isPrimary" class="field text"
                      value="{response:body()//*:isPrimary}"
                      type="checkbox">
          {
           if(response:body()/*:isPrimary = 'true') 
           then attribute checked {"checked"}
           else () 
          }         
      </input>
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