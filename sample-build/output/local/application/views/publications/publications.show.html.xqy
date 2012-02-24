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
      <form name="form_publication" method="get" action="/publications/edit.html">
         <ul>
            <li>
               <label class="desc">ID</label>
               <span>{response:body()/*:publicationId}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Publication Name</label>
               <span>{response:body()/*:publicationName}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">ISSN Number</label>
               <span>{response:body()/*:issnNumber}{" "}</span>
               <br/>
            </li>
            <li class="buttons">
               <button class="ui-state-default ui-button" type="submit">Edit</button>
            </li>
         </ul>
      </form>
      <h2>XML Format</h2>
      <div style="width:400px">
         <pre>{
     xdmp:quote(response:body())
     }</pre>
      </div>
   </div>
   <div class="clearfix"/>
</div>