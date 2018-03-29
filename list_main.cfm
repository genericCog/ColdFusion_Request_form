
<cfquery name="getRequests" datasource="#APPLICATION.asd#">
	SELECT	*
    FROM 	itnss_requirement
</cfquery>



<style type="text/css">
td {
	padding:5px;
}

#navmenu {
	list-style:none;
	margin-right:25px;
	padding:10px;
}

#navmenu li {
	cursor:pointer;
	padding:10px;}
	
#navmenu li:hover {
	background-color:#C1EBFF;}
	
</style>

<cfoutput>
<div style="margin:25px 0px;">
	<!--- Left Column --->
	<div style="float:left; margin-right:25px;">
    	<ul id="navmenu">
        	<li><a href="new_request.cfm">Generate New ITNSS</a></li>
            <li>My Submissions</li>
            <li><a href="list.cfm">View All Submissions</a></li>
            <li>Advanced Search</li>
        </ul>
        
        <br style="clear:both;">
	</div>
	
    <div style="float:left; width:100%; max-width:1300px;  min-width:200px;">
        <div style="color:##F00;">
        	<strong>NOTICE:&nbsp;&nbsp;</strong>
            Approval of the ITNSS is required as the first step in any IT ACQUISITION (hardware or software).&nbsp;&nbsp;
            This is not approval to deploy or install as additional steps and approval are needed for management 
            of the IT asset per AFMAN 33-153.&nbsp;&nbsp;Read each approvers comments for further information.
        </div>
        
        <br style="clear:both;">
        
        <table border="1" cellpadding="0" cellspacing="0" style="width:100%">
            <tr>
            	<th>STATUS</th>
                <th>TRACKING NUMBER</th>
                <th>TITLE</th>
                <th>REQUESTOR</th>
                <th>SUBMITTED</th>
            </tr>
            
            <cfloop query="getRequests">
            
            <!--- Get Requestor Info --->
            <cfquery name="getRequestor" datasource="#APPLICATION.asd#">
                SELECT *
                FROM	account_info
                WHERE 	cac_edipi = '#getRequests.poc#'
                    AND non_user <> 1
                    AND status_code = 1
            </cfquery>
            <cfset pocFullName = UCASE(getRequestor.first_name & " " & getRequestor.last_name)>

                <tr>
                	<td align="center">#itnss_status#</td>
                    <td width="150px">RQ-2018-#itnss_requirement_id#</td>
                    <td><a href="detail.cfm?requestID=#itnss_requirement_id#">#title#</a></td>
                    <td align="center">#pocFullName#</td>
                    <td align="center">#dateFormat(date_created, 'MM/DD/YYYY')#</td>
                </tr>
            </cfloop>
        </table>
	<br style="clear:both;">
	
</div>
<br style="clear:both;">


</div>
</cfoutput>

