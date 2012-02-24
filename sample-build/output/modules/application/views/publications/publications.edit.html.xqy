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
      <h2>Edit Publications</h2>
   </div>
   <div class="content-box">
      <form name="form_publication" method="post" action="/publications/save.html">
         <ul class="editPanel">
            <li>
               <label class="desc" for="publicationId">ID</label>
               <input id="d4e143" name="publicationId" class="field text"
                      value="{response:body()//*:publicationId}"/>
            </li>
            <li>
               <label class="desc" for="publicationName">Publication Name</label>
               <input id="d4e150" name="publicationName" class="field text"
                      value="{response:body()//*:publicationName}"/>
            </li>
            <li>
               <label class="desc" for="issnNumber">ISSN Number</label>
               <input id="d4e158" name="issnNumber" class="field text"
                      value="{response:body()//*:issnNumber}"/>
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