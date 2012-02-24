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
      <h2>Validation Ticket</h2>
      <div class="tools">
         <a class="ui-button ui-button-text ui-state-default ui-corner-all"
            href="/validationTickets/new.html">
            <span class="ui-icon ui-icon-plusthick"/>New</a>
         <a class="ui-button ui-button-text ui-state-default ui-corner-all"
            href="edit.htmlid=">
            <span class="ui-icon ui-icon-pencil"/>Edit
          </a>
      </div>
   </div>
   <div class="list-box">
      <table id="validationTicket_table"/>
      <div id="validationTicket_table_pager"/>
   </div>
   <div class="form-box" style="width:500px;height:500px;background:#ccc;float:left;">
      <div class="ui-state-default ui-widget-header">Form Header</div>
      <div id="form-content">Form Here</div>
   </div>
   <div class="clearfix"/>
   <script type="text/javascript">
var gridModel = {{
     url: '/validationTickets/list.xml',
     pager: jQuery('#validationTicket_table_pager'),
     datatype: "xml",
     colModel:[
  {{ name:'id', label:'ID', index:'id', xmlmap:'id', 
     jsonmap:'id', dataType:'integer', resizable: true, sortable: true,  width:'80'}},
  {{ name:'driverId', label:'Driver ID', index:'driverId', xmlmap:'driverId', 
     jsonmap:'driverId', dataType:'integer', resizable: true, sortable: true,  width:'80'}},
  {{ name:'pkgid', label:'Package ID', index:'pkgid', xmlmap:'pkgid', 
     jsonmap:'pkgid', dataType:'integer', resizable: true, sortable: true,  width:'80'}},
  {{ name:'errorCount', label:'Total Errors', index:'errorCount', xmlmap:'errorCount', 
     jsonmap:'errorCount', dataType:'integer', resizable: true, sortable: true,  width:'80'}},
  {{ name:'warningCount', label:'Total Warnings', index:'warningCount', xmlmap:'warningCount', 
     jsonmap:'warningCount', dataType:'integer', resizable: true, sortable: true,  width:'80'}},
  {{ name:'infoCount', label:'Total Info', index:'infoCount', xmlmap:'infoCount', 
     jsonmap:'infoCount', dataType:'integer', resizable: true, sortable: true,  width:'80'}},
  {{ name:'schemaErrors', label:'Schema Errors', index:'schemaErrors', xmlmap:'schemaErrors', 
     jsonmap:'schemaErrors', dataType:'integer', resizable: true, sortable: true,  width:'80'}},
  {{ name:'schematronErrors', label:'Schematron Errors', index:'schematronErrors', xmlmap:'schematronErrors', 
     jsonmap:'schematronErrors', dataType:'integer', resizable: true, sortable: true,  width:'80'}},
  {{ name:'status', label:'Status', index:'status', xmlmap:'status', 
     jsonmap:'status', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'filesystemURI', label:'Files System URI', index:'filesystemURI', xmlmap:'filesystemURI', 
     jsonmap:'filesystemURI', dataType:'string', resizable: true, sortable: true,  width:'80'}},
  {{ name:'report', label:'Report', index:'report', xmlmap:'report', 
     jsonmap:'report', dataType:'string', resizable: true, sortable: true,  width:'80'}}],
     loadonce:true,
     rowNum:9999999,
     pgbuttons: false,
    loadonce:true,
    rowNum:9999999,
    pgbuttons: false,
   
     //Grid Text
     emptyrecords: "No validationTicket's Found",
     loadtext: "Loading validationTicket's",
     gridview: true,
     viewrecords :true,
     rownumbers:true,
     width: '500',
     height: '500',
     multiselect: false,
     xmlReader : xmlListReaderSettings('id','validationTickets','validationTicket'),
     onSelectRow: function(id){{ 
       if(id){{ 
         editForm('validationTickets','id',id,true);
       }} 
     }}
}};

/*initialize your grid model*/
$(document).ready(function(){{
   initListGrid("#validationTicket_table",gridModel)
}});
</script>
</div>