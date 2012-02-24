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
      <h2>Publications</h2>
   </div>
   <div class="content-box">
      <form name="form_publication" method="post" action="/publications/save.html">
         <ul>
            <li>
               <label class="desc">ID</label>
               <div>
                  <input class="field text small" name="publicationId" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">Publication Name</label>
               <div>
                  <input class="field text small" name="publicationName" type="text" value=""/>
               </div>
            </li>
            <li>
               <label class="desc">ISSN Number</label>
               <div>
                  <input class="field text small" name="issnNumber" type="text" value=""/>
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