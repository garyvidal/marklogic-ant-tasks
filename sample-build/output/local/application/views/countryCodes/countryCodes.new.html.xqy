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
      <h2>Country Codes</h2>
   </div>
   <div class="content-box">
      <form name="form_countryCode" method="post" action="/countryCodes/save.html">
         <ul>
            <li>
               <label class="desc">ISO Country Code</label>
               <div>
                  <input class="field text small" name="id" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Name</label>
               <div>
                  <input class="field text small" name="name" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">ISO 3 digit</label>
               <div>
                  <input class="field text small" name="iso3" type="text" value=""/>
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