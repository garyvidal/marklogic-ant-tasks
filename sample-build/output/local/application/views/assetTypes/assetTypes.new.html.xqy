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
      <h2>Asset Types</h2>
   </div>
   <div class="content-box">
      <form name="form_assetType" method="post" action="/assetTypes/save.html">
         <ul>
            <li>
               <label class="desc">ID</label>
               <div>
                  <input class="field text small" name="id" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Asset Description</label>
               <div>
                  <input class="field text small" name="description" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Namespace</label>
               <div>
                  <input class="field text small" name="namespace-uri" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Root Name</label>
               <div>
                  <input class="field text small" name="element" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Schema Location</label>
               <div>
                  <input class="field text small" name="xmlSchemaLocation" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Active</label>
               <div>
                  <input class="field text small" name="isActive" type="checkbox" value="true"/>
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