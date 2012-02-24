declare default element namespace "http://www.w3.org/1999/xhtml";

<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Conde Nast - Digital Asset Management</title>
        
        <link href="/resources/css/ui/ui.base.css" rel="stylesheet" media="all" />
        <link href="/resources/css/ui/ui.jqgrid.css" rel="stylesheet" media="all"/>
        <link href="/resources/css/themes/condenast/ui.css" rel="stylesheet" title="style" media="all" />
        
        
        <script type="text/javascript" src="/resources/js/jquery-1.4.2.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.core.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.widget.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.mouse.js">//</script>
        <script type="text/javascript" src="/resources/js/superfish.js">//</script>
        <script type="text/javascript" src="/resources/js/live_search.js">//</script>
        <script type="text/javascript" src="/resources/js/tooltip.js">//</script>
        <script type="text/javascript" src="/resources/js/cookie.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.sortable.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.draggable.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.resizable.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.position.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.button.js">//</script>
        <script type="text/javascript" src="/resources/js/ui/ui.dialog.js">//</script>
        <script type="text/javascript" src="/resources/js/custom.js">//</script>
        <script type="text/javascript" src="/resources/js/grid.locale-en.js">//</script>
        <script type="text/javascript" src="/resources/js/jquery.jqgrid.min.js">//</script>
        <script type="text/javascript" src="/resources/js/app.js">//</script>
        <?controller-script?>
        
    </head>
    <body>
        <div id="page_wrapper">
           <?template name="header"?>
           <div class="clear"></div>
           <div id="page-layout">
                <div id="page-content">
                    <div id="page-content-wrapper" class="no-bg-image wrapper-full"> 
                        <?view?>
                        <div class="clear"></div>
                    </div>          
                    <div class="clear"></div>
                </div>
            </div>          
        </div> 
        <div class="clear"></div>
        <?template name="footer"?>    
    </body>
</html>