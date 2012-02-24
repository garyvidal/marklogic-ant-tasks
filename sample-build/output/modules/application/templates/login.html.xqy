declare default element namespace "http://www.w3.org/1999/xhtml";
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title><?title?></title>
    </head>
    <body>
    
    <div id="pagewrapper">
    	<div id="head">
    		<div id="headLevel1"> <?template name="header"?></div><!-- end headLevel1 -->
    		<div id="navigation"> <?template name="navigation"?></div><!-- end navigation -->
    	</div><!-- end head -->
    	<div id="main">  
    	   <?view?> 
    	</div><!-- end main -->
    	<div id="foot"></div><!-- end foot -->
    </div><!-- end pagewrapper -->
    
         
    </body>
</html>