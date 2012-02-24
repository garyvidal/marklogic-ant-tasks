declare default element namespace "http://www.w3.org/1999/xhtml";

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
        <title><?title?> | Conde Nast Digital Asset Managment</title>
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>
        <link rel="stylesheet" type="text/css" href="/resources/css/jquery-ui-1.8.17.custom.css"/>
        <link rel="stylesheet" type="text/css" href="/resources/css/jquery-layout-1.3.0.css"/>
        <link rel="stylesheet" type="text/css" href="/resources/css/ui.jqgrid.css"/>
        
        <script type="text/javascript" src="/resources/js/jquery-1.7.1.min.js">//</script>
        <script type="text/javascript" src="/resources/js/jquery-ui-1.8.17.custom.min.js">//</script>
        <script type="text/javascript" src="/resources/js/jquery.layout-1.3.0.js">//</script>

        <script type="text/javascript" src="/resources/js/superfish.js">//</script>
        <script type="text/javascript" src="/resources/js/i18n/grid.locale-en.js">//</script>
        <script type="text/javascript" src="/resources/js/jquery.jqGrid.min.js">//</script>
        <script type="text/javascript" src="/resources/js/app.js">//</script>
        <script type="text/javascript" src="/resources/js/cnRun.js">//</script>
    
    </head>
    <body>
        <div id="pagewrapper">
            <?template name="header"?>
            <div id="main" class="ui-corner-bottom">
                <?view?>
                <br class="clearit" />
            </div><!-- end main -->
            <div id="foot">
                <p>&copy; Conde Nast Digital Asset Managment</p>
            </div><!-- end foot -->
        </div><!-- end pagewrapper-->
    </body>
</html>
