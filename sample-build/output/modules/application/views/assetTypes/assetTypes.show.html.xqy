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
      <form name="form_assetType" method="get" action="/assetTypes/edit.html">
         <ul>
            <li>
               <label class="desc">ID</label>
               <span>{response:body()/*:id}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Asset Description</label>
               <span>{response:body()/*:description}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Namespace</label>
               <span>{response:body()/*:namespace-uri}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Root Name</label>
               <span>{response:body()/*:element}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Schema Location</label>
               <span>{response:body()/*:xmlSchemaLocation}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Active</label>
               <span>{response:body()/*:isActive}{" "}</span>
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