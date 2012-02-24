xquery version "1.0-ml";
declare default element namespace "http://www.w3.org/1999/xhtml";
<div class="default-main">
    <div id="container">
        <div class="pane ui-layout-west"></div>
       	<div class="pane ui-layout-center" id="middle-center">
       	    <div class="inner-north ui-layout-north" style="background:#ccc;"></div>
       	    <div class="inner-center ui-layout-center">
             </div> 
             <div class="inner-south ui-layout-south"></div>
        </div>
       	<div class="pane ui-layout-east">
       	         <div class="panel">
                    <h3>Results</h3>
                    <div class="panelContent" style="height:100px;">...</div>
                </div>
                
                <div class="panel">
                    <h3>Current Jobs</h3>
                    <div class="panelContent" style="height:100px;">...</div>
                </div>
       	</div>
    </div>

    <script type="text/javascript">
        // jQuery Layout 
    	jQuery('#container').layout();
    	jQuery('#middle-center').layout({{ 
    	   center__paneSelector: ".inner-center",
    	   south__paneSelector: ".inner-south",
           north__paneSelector: ".inner-north",
    	   south__size: 100,
    	   north__size: 30,
    	   south__initClosed: true,
    	   north__resizable: false,
    	   north__closable: false,
    	   north__spacing_open:0
    	}});
    </script>
</div>