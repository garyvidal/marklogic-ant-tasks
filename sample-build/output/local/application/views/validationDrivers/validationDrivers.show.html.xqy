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
      <h2>Validation Driver</h2>
   </div>
   <div class="content-box">
      <form name="form_validationDriver" method="get" action="/validationDrivers/edit.html">
         <ul>
            <li>
               <label class="desc">Code</label>
               <span>{response:body()/*:code}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Name</label>
               <span>{response:body()/*:name}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Description</label>
               <span>{response:body()/*:description}{" "}</span>
               <br/>
            </li>
            <li>
               <label class="desc">Module URI</label>
               <span>{response:body()/*:moduleURI}{" "}</span>
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