function initGrid()
{
	jQuery("#list_grid").jqGrid({
	   	url:'/timezones/list.xml',
		datatype: "xml",
	   	colNames:['ID','Name'],
	   	colModel:[
   	         { name:'id', index:'id',xmlmap:'id', resizable: false, sortable: false, width:'200'},
   	         { name:'name', index:'name',xmlmap:'name', resizable: true, sortable: true, width:'400' },
   	 ],
	   	xmlReader: {
		root: "issnCodes",
	    row: "issnCode",
		   repeatitems: false,
		   id: "id"
		},
	 	rowNum:10,
	   	pager: jQuery('#list_grid_pager'),
	   	multiselect: false,
	   	emptyrecords: "No Content Types Found",
	   	sortname: 'name',
	   	gridview: true,
	   	sortorder: "desc",
	   	loadonce: false,
	   	width:'800',
	   	height:'400'
  })
  .navGrid('#list_grid_pager',{edit:false,add:false,del:false,search:true, reload:true})
  .trigger("reloadGrid");
}
$(document).ready(function(){
  initGrid();
});