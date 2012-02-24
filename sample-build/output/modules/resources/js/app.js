/*Initialize Grid*/

function xmlListReaderSettings(idField,rootField,rowField)
{
   var settings = 
   {
      root    : rootField, 
      row     : rowField,
      id      : idField,
      page    : 'list>currentpage', 
      total   : 'list>totalpages', 
      records : 'list>totalrecords',
      repeatitems: false
   };
   return settings;
}
function showForm(controller,idfield,id)
{
  $.ajax({
     url : '/' + controller + '/show.html',
     data: {id:id,_partial:true},
     success:function(r) {
        $("#form-content").empty().stop().html(r);
     }
  });
}
function editForm(controller,idfield,id)
{
  /*$.ajax({
     url : '/' + controller + '/edit.html',
     data: {id:id,_partial:true},
     success:function(r) {
        $("#form-content").empty().stop().html(r);
     }
  });*/
  window.location.href = controller + "/edit.html?" + idfield + '=' + id
}
function initListGrid(gridId,gridParams)
{
   jQuery(gridId).jqGrid(gridParams)
  .navGrid(gridId + '_pager',{edit:false,add:false,del:false,search:true, reload:true})
  .trigger("reloadGrid");
  
   jQuery(gridId).setGridWidth($(".content-box").width());
   jQuery(gridId).setGridHeight($(".content-box").height());
}
jQuery(document).ready(function(){
    jQuery('.ui-button').button();
});