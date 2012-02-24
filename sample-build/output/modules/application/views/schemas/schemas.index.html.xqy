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
      <h2>Schemas</h2>
      <div class="tools">
         <a class="ui-button ui-button-text ui-state-default ui-corner-all"
            href="/schemas/new.html">
            <span class="ui-icon ui-icon-plusthick"/>New</a>
         <a class="ui-button ui-button-text ui-state-default ui-corner-all"
            href="edit.htmlid=">
            <span class="ui-icon ui-icon-pencil"/>Edit
          </a>
      </div>
   </div>
   <div class="list-box">
      <table id="schema_table"/>
      <div id="schema_table_pager"/>
   </div>
   <div class="form-box" style="width:500px;height:500px;background:#ccc;float:left;">
      <div class="ui-state-default ui-widget-header">Form Header</div>
      <div id="form-content">Form Here</div>
   </div>
   <div class="clearfix"/>
   <script type="text/javascript">
var gridModel = {{
     url: '/schemas/list.xml',
     pager: jQuery('#schema_table_pager'),
     datatype: "xml",
     colModel:[
  {{ name:'id', label:'Schema ID', index:'id', xmlmap:'id', 
     jsonmap:'id', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'name', label:'Name', index:'name', xmlmap:'name', 
     jsonmap:'name', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'schemaLocation', label:'Schema Location', index:'schemaLocation', xmlmap:'schemaLocation', 
     jsonmap:'schemaLocation', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'namespace', label:'Schema namespace', index:'namespace', xmlmap:'namespace', 
     jsonmap:'namespace', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'isPrimary', label:'Is Primary Schema', index:'isPrimary', xmlmap:'isPrimary', 
     jsonmap:'isPrimary', dataType:'boolean', resizable: true, sortable: true,  width:'80'}}],
     loadonce:true,
     rowNum:9999999,
     pgbuttons: false,
    loadonce:true,
    rowNum:9999999,
    pgbuttons: false,
   
     //Grid Text
     emptyrecords: "No schema's Found",
     loadtext: "Loading schema's",
     gridview: true,
     viewrecords :true,
     rownumbers:true,
     width: '500',
     height: '500',
     multiselect: false,
     xmlReader : xmlListReaderSettings('id','schemas','schema'),
     onSelectRow: function(id){{ 
       if(id){{ 
         editForm('schemas','id',id,true);
       }} 
     }}
}};

/*initialize your grid model*/
$(document).ready(function(){{
   initListGrid("#schema_table",gridModel)
}});
</script>
</div>