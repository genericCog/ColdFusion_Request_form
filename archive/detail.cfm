<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EDGE" />
<title>Profile</title>
	
	<script src="jqueryui/external/jquery/jquery.js"></script>
	<script src="jqueryui/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="jqueryui/jquery-ui.min.css">
	 
	<cfinclude template="style/itnss_style.cfm">
	<cfinclude template="style/jqueryOverride_style.cfm">	
</head>

<body>
       
	<!--- REQUIRED: FRAMEWORK HEADER *** --->
    <cfinclude template="/framework/rqweb_header.cfm">    
 
 	<!--- Application Navigation
    <cfinclude template="/toast/navigation.cfm">  --->
          
	<!--- APPLICATION CONTENT *** --->
    <div style="width:100%; min-height:700px;">
		<cfinclude template="detail_index_main.cfm">
	</div>
		
    <!--- REQUIRED: FRAMEWORK FOOTER *** --->    	
	<cfinclude template="/framework/rqweb_footer.cfm">

</body>
</html>
