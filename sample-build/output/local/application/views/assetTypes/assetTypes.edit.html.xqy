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
      <h2>Edit Asset Types</h2>
   </div>
   <div class="content-box">
      <form name="form_assetType" method="post" action="/assetTypes/save.html">
         <ul class="editPanel">
            <li>
               <label class="desc" for="id">ID</label>
               <input id="d4e227" name="id" class="field text" value="{response:body()//*:id}"/>
            </li>
            <li>
               <label class="desc" for="description">Asset Description</label>
               <input id="d4e234" name="description" class="field text"
                      value="{response:body()//*:description}"/>
            </li>
            <li>
               <label class="desc" for="namespace-uri">Namespace</label>
               <input id="d4e241" name="namespace-uri" class="field text"
                      value="{response:body()//*:namespace-uri}"/>
            </li>
            <li>
               <label class="desc" for="element">Root Name</label>
               <input id="d4e249" name="element" class="field text"
                      value="{response:body()//*:element}"/>
            </li>
            <li>
               <label class="desc" for="xmlSchemaLocation">Schema Location</label>
               <input id="d4e256" name="xmlSchemaLocation" class="field text"
                      value="{response:body()//*:xmlSchemaLocation}"/>
            </li>
            <li>
               <label class="desc" for="isActive">Active</label>
               <input id="d4e263" name="isActive" class="field text"
                      value="{response:body()//*:isActive}"
                      type="checkbox">
          {
           if(response:body()/*:isActive = 'true') 
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