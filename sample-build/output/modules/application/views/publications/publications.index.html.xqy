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
      <h2>Publications</h2>
      <div class="tools">
         <a class="ui-button ui-button-text ui-state-default ui-corner-all"
            href="/publications/new.html">
            <span class="ui-icon ui-icon-plusthick"/>New</a>
         <a class="ui-button ui-button-text ui-state-default ui-corner-all"
            href="edit.htmlpublicationId=">
            <span class="ui-icon ui-icon-pencil"/>Edit
          </a>
      </div>
   </div>
   <div class="list-box">
      <table id="publication_table"/>
      <div id="publication_table_pager"/>
   </div>
   <div class="form-box" style="width:500px;height:500px;background:#ccc;float:left;">
      <div class="ui-state-default ui-widget-header">Form Header</div>
      <div id="form-content">Form Here</div>
   </div>
   <div class="clearfix"/>
   <script type="text/javascript">
var gridModel = {{
     url: '/publications/list.xml',
     pager: jQuery('#publication_table_pager'),
     datatype: "xml",
     colModel:[
  {{ name:'publicationId', label:'ID', index:'publicationId', xmlmap:'publicationId', 
     jsonmap:'publicationId', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'publicationName', label:'Publication Name', index:'publicationName', xmlmap:'publicationName', 
     jsonmap:'publicationName', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'issnNumber', label:'ISSN Number', index:'issnNumber', xmlmap:'issnNumber', 
     jsonmap:'issnNumber', dataType:'string', resizable: true, sortable: true,  width:'80'}}],
     loadonce:true,
     rowNum:9999999,
     pgbuttons: false,
    loadonce:true,
    rowNum:9999999,
    pgbuttons: false,
   
     //Grid Text
     emptyrecords: "No publication's Found",
     loadtext: "Loading publication's",
     gridview: true,
     viewrecords :true,
     rownumbers:true,
     width: '500',
     height: '500',
     multiselect: false,
     xmlReader : xmlListReaderSettings('publicationId','publications','publication'),
     onSelectRow: function(id){{ 
       if(id){{ 
         editForm('publications','publicationId',id,true);
       }} 
     }}
}};

/*initialize your grid model*/
$(document).ready(function(){{
   initListGrid("#publication_table",gridModel)
}});
</script>
</div>