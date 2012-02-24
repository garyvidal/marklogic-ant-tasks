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
      <h2>Asset Types</h2>
      <div class="tools">
         <a class="ui-button ui-button-text ui-state-default ui-corner-all"
            href="/assetTypes/new.html">
            <span class="ui-icon ui-icon-plusthick"/>New</a>
         <a class="ui-button ui-button-text ui-state-default ui-corner-all"
            href="edit.htmlid=">
            <span class="ui-icon ui-icon-pencil"/>Edit
          </a>
      </div>
   </div>
   <div class="list-box">
      <table id="assetType_table"/>
      <div id="assetType_table_pager"/>
   </div>
   <div class="form-box" style="width:500px;height:500px;background:#ccc;float:left;">
      <div class="ui-state-default ui-widget-header">Form Header</div>
      <div id="form-content">Form Here</div>
   </div>
   <div class="clearfix"/>
   <script type="text/javascript">
var gridModel = {{
     url: '/assetTypes/list.xml',
     pager: jQuery('#assetType_table_pager'),
     datatype: "xml",
     colModel:[
  {{ name:'id', label:'ID', index:'id', xmlmap:'id', 
     jsonmap:'id', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'description', label:'Asset Description', index:'description', xmlmap:'description', 
     jsonmap:'description', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'namespace-uri', label:'Namespace', index:'namespace-uri', xmlmap:'namespace-uri', 
     jsonmap:'namespace-uri', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'element', label:'Root Name', index:'element', xmlmap:'element', 
     jsonmap:'element', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'xmlSchemaLocation', label:'Schema Location', index:'xmlSchemaLocation', xmlmap:'xmlSchemaLocation', 
     jsonmap:'xmlSchemaLocation', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'isActive', label:'Active', index:'isActive', xmlmap:'isActive', 
     jsonmap:'isActive', dataType:'boolean', resizable: true, sortable: true,  width:'80'}}],
     loadonce:true,
     rowNum:9999999,
     pgbuttons: false,
    loadonce:true,
    rowNum:9999999,
    pgbuttons: false,
   
     //Grid Text
     emptyrecords: "No assetType's Found",
     loadtext: "Loading assetType's",
     gridview: true,
     viewrecords :true,
     rownumbers:true,
     width: '500',
     height: '500',
     multiselect: false,
     xmlReader : xmlListReaderSettings('id','assetTypes','assetType'),
     onSelectRow: function(id){{ 
       if(id){{ 
         editForm('assetTypes','id',id,true);
       }} 
     }}
}};

/*initialize your grid model*/
$(document).ready(function(){{
   initListGrid("#assetType_table",gridModel)
}});
</script>
</div>