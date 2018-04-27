<!--- Get session user info --->
<cfquery name="get_session_user" datasource="#APPLICATION.asd#">
	SELECT	*
    FROM	account_info
    WHERE	cac_edipi = '#session.intranet.user_eipd#'
    	AND	non_user <> 1 
    	AND status_code = 1
</cfquery>
<cfset session_user_cac = #get_session_user.cac_edipi#>

<cfquery name="get_user_records" datasource="#APPLICATION.asd#">
    SELECT *
    FROM   itnss_requirement
    WHERE  created_by = #session_user_cac#
</cfquery>

<style type="text/css">
    /* Consistent theme styles */
    .app_mod_header{margin-top:10px;margin-bottom:5px;}
    .outProcess_desc{background-color:#FFF9CF;padding:5px;margin-bottom:5px;}
    .outProcess_status{background-color:#EEE;padding:5px;margin-bottom:5px;border:1px solid #DDD;}
    .outProcess_status_bar{background-color:#FFEE5A;border:1px solid #EBD200;width:62%;padding:5px;text-align:center;font-size:1.25em;}
    .outProcess_actions{text-align:right;margin-bottom:25px;}
    .action_bar{background-color:#bbb;margin-bottom:25px;padding:5px;text-align:left;}
     td{border-top:1px solid #666;}
    #outSteps td{border-top:1px solid #666;padding:5px;}
    .status_box{height:15px;width:15px;background-color:#CCC;border:1px solid #999;float:left;margin-right:7px;margin-top:3px;}
    .status_box_green{height:15px;width:15px;background-color:#5FE85E;border:1px solid #1AAF19;float:left;margin-right:7px;margin-top:3px;}
    .status_box_yellow{height:15px;width:15px;background-color:#FFEA33;border:1px solid #A39200;float:left;margin-right:7px;margin-top:3px;}
    #keys{cursor:pointer;}

    /* Sidebar Navigation */
    td {padding:5px;}
    #navmenu {list-style:none;margin-right:25px;padding:10px;}
    #navmenu li {cursor:pointer;padding:10px;}
    #navmenu li:hover {background-color:#C1EBFF;}
	
    /* User Record Styles */
    .center_item{text-align:center;vertical-align:middle;}
    .indent_item{padding-left:25px;}
    td, th{border-left:1px solid rgba(16, 21, 24, 0.1);}
    .border_none{border-left:none;}
    /*Remove the borders from all table elements*/ 
    table{border:none;}
    thead {background-color:#a7a37e;border:1px solid rgb(224, 220, 183);line-height:35px;}
    tbody tr:nth-child(even) {background-color:rgba(224, 220, 183,0.3);}
    tbody tr:nth-child(even):hover {background-color:rgba(224, 220, 183,0.7);}
    tbody tr{line-height:25px;}
    tbody tr:hover {background-color:rgba(224, 220, 183,0.7);}
    
	<!---
	.adam_container{display:flex;justify-content:center;border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;}
    .generic_box{background-color:rgba(224, 220, 183,0.5);border:1px solid rgb(224, 220, 183);min-height:50px;min-width:75px;padding:2.5px 2.5px;margin:2.5px 2.5px;}
    .generic_box:hover{background-color:rgba(224, 220, 183,0.7);border:1px solid rgba(224, 220, 183,0.75);min-height:50px;min-width:75px;padding:2.5px 2.5px;margin:2.5px 2.5px;}
	--->
</style>


<cfoutput>
<div style="margin:25px 0px;min-height:700px;">
	<!--- Navigation --->
	<cfinclude template="navigation.cfm">
	
    <div style="margin-bottom:10px;"><strong>My Submissions</strong></div>
    
    <!--- Content --->
    <div id="ticket_tabs" style="float:left; max-width:1350px; width:80%; ">   
        <ul>
            <li><a href="##itnss_tab">In Progress</a></li>
        </ul>
                            
		<div id="main_content" style="float:left; width:100%; max-width:1350px;  min-width:200px; padding: 5px;">
        <table class="border_none" cellpadding="0" cellspacing="0" style="width:100%">
            <thead>
                <tr>
                    <th>STATUS</th>
                    <th>TRACKING NUMBER</th>
                    <th>TITLE</th>
                    <th>REQUESTOR</th>
                    <th>SUBMITTED</th>
                </tr>
            </thead>
            <tbody>
                <cfloop query="get_user_records">
                <tr>
                    <td class="border_none center_item">#itnss_status#</td>
                    <td class="center_item">RQ-2018-#itnss_requirement_id#</td>
                    <td class="indent_item"><a href="detail.cfm?requestID=#itnss_requirement_id#">#title#</a></td>
                    <cfloop query="get_session_user">
                    <td class="center_item">#last_name#, #first_name#</td>
                    </cfloop>
                    <td class="center_item">#dateFormat(date_created, 'MM/DD/YYYY')#</td>
                </tr>
                </cfloop>
            </tbody>
        </table>
        </div><!---END user_record_container--->
    
    </div><!--- END main_content --->
    
    <br style="clear:both;">
    
</div><!---END Ticket Tab --->
</cfoutput>

<script>
    //Initialize tabs
	$("#ticket_tabs").tabs();
</script>

        
        
        
	



