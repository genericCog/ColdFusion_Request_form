

<style type="text/css">
.app_mod_header {
	margin-top:10px;
	margin-bottom:5px;
}

.outProcess_desc {
	background-color:#FFF9CF; /*#F9F8E3;*/
	padding:5px;
	margin-bottom:5px;}

.outProcess_status {
	background-color:#EEE;
	padding:5px;
	margin-bottom:5px;
	border:1px solid #DDD;
	}

.outProcess_status_bar {
	background-color:#FFEE5A;
	border:1px solid #EBD200;
	width:62%;
	padding:5px;
	text-align:center;
	font-size:1.25em;

}

.outProcess_actions {
	text-align:right;
	margin-bottom:25px;}

.action_bar {
	background-color:#bbb;
	margin-bottom:25px;
	padding:5px;
	text-align:left;}

 td {
	border-top:1px solid #666;}
		
#outSteps td {
	border-top:1px solid #666;
	padding:5px;}
	
.status_box {
	height:15px;
	width:15px;
	background-color:#CCC;
	border:1px solid #999;
	float:left;
	margin-right:7px;
	margin-top:3px;}
	
.status_box_green {
	height:15px;
	width:15px;
	background-color:#5FE85E;
	border:1px solid #1AAF19;
	float:left;
	margin-right:7px;
	margin-top:3px;}

.status_box_yellow {
	height:15px;
	width:15px;
	background-color:#FFEA33;
	border:1px solid #A39200;
	float:left;
	margin-right:7px;
	margin-top:3px;}
	
#keys {
	cursor:pointer;}
	
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
<cfset date_now = now()>

<cfquery name="get_session_user_profile" datasource="#APPLICATION.asd#">
    SELECT id, cac_edipi, first_name,  last_name,  middle_initial,  symbol,  phone_number
    FROM user_info
    WHERE 
        <cfif isdefined("variables.impersonate_id")>
            id=<cfqueryparam value="#variables.impersonate_id#">
        <cfelse>
            user_info.cac_edipi='#trim(listlast(cgi.cert_subject,"."))#'
        </cfif>
</cfquery>
<cfset session_user_name = "#get_session_user_profile.first_name# #get_session_user_profile.last_name#">

<cfquery name="get_itnss_requirement" datasource="#APPLICATION.asd#">
    SELECT * FROM itnss_requirement
    WHERE itnss_requirement_id = 1
</cfquery>

<cfquery name="get_requestor_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi FROM account_info
    WHERE cac_edipi = '#trim(listlast(cgi.cert_subject,"."))#'
</cfquery>
    <cfset requestor_name   = "#get_requestor_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
    <cfset requestor_title  = "#get_requestor_cacedipi.title#">
    <cfset requestor_symbol = "#get_requestor_cacedipi.symbol#">
    <cfset requestor_phone  = "#get_requestor_cacedipi.phone_number#">

<cfquery name="get_created_by_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi FROM account_info
    WHERE cac_edipi = #get_itnss_requirement.created_by_cacedipi#
</cfquery>
    <cfset created_by_name   = "#get_created_by_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
    <cfset created_by_title  = "#get_created_by_cacedipi.title#">
    <cfset created_by_symbol = "#get_created_by_cacedipi.symbol#">
    <cfset created_by_phone  = "#get_created_by_cacedipi.phone_number#">

<cfquery name="get_description_staff_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi FROM account_info
    WHERE cac_edipi = #get_itnss_requirement.itnss_description_staff_cacedipi#
</cfquery>
    <cfset description_name   = "#get_description_staff_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
    <cfset description_title  = "#get_description_staff_cacedipi.title#">
    <cfset description_symbol = "#get_description_staff_cacedipi.symbol#">
    <cfset description_phone  = "#get_description_staff_cacedipi.phone_number#">

<cfquery name="get_justification_staff_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi FROM account_info
    WHERE cac_edipi = #get_itnss_requirement.itnss_justification_staff_cacedipi#
</cfquery>
    <cfset justification_name   = "#get_justification_staff_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
    <cfset justification_title  = "#get_justification_staff_cacedipi.title#">
    <cfset justification_symbol = "#get_justification_staff_cacedipi.symbol#">
    <cfset justification_phone  = "#get_justification_staff_cacedipi.phone_number#">

<cfquery name="get_solution_staff_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi FROM account_info
    WHERE cac_edipi = #get_itnss_requirement.itnss_solution_staff_cacedipi#
</cfquery>
    <cfset solution_name   = "#get_solution_staff_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
    <cfset solution_title  = "#get_solution_staff_cacedipi.title#">
    <cfset solution_symbol = "#get_solution_staff_cacedipi.symbol#">
    <cfset solution_phone  = "#get_solution_staff_cacedipi.phone_number#">


<cfquery name="get_itnss_network_type" datasource="#APPLICATION.asd#">
    SELECT itnss_network_type_id, network_type_name FROM itnss_network_type
    WHERE itnss_network_type_id = #get_itnss_requirement.fk_network_type_id#
</cfquery>
<cfif #get_itnss_requirement.is_classified# IS 0>
    <cfset is_classified = "Unclassified">
<cfelse>
    <cfset is_classified = "Classified">    
</cfif>
<cfif  #get_itnss_requirement.is_funded# IS 0>
    <cfset is_funded = "Not Funded">
<cfelse>
    <cfset is_funded = "Funded">
</cfif>

<cfoutput>
<div style="margin:25px 0px;">
	<!--- Left Column --->
	<div style="float:left; margin-right:25px;">
    	<ul id="navmenu">
        	<li><a href="new_request.cfm">Generate New ITNSS</a></li>
            <li>My Submissions</li>
            <li>View All Submissions</li>
            <li>Advanced Search</li>
        </ul>
        
        <br style="clear:both;">
	</div>
	
    
	<!--- Right (main) Column --->
	<div id="ticket_tabs" style="float:left; max-width:1350px;  min-width:200px;">
		<ul>
        	<li><a href="##itnss_tab">ITNSS/3215/CSRD</a></li>
        </ul>
        
        <div id="itnss_tab" style="margin:10px;">
        
            <div class="outProcess_desc">
            	<strong>ATTENTION!&nbsp;&nbsp;</strong>Submission requires edits from the requestor and needs to be resubmitted before it continues through the workflow.
            </div>
            
            <div class="outProcess_status">
            	<div class="outProcess_status_bar">Completion Status (62%)</div>
            </div>
            
            <div class="action_bar">
            	<button type="button" class="print_button">Print</button>
                <button type="button" class="edit_button">Edit</button>
                <button type="button" class="cancel_button">Cancel</button>
            </div>
            
            <!--- GENERAL INFORMATION --->            
            <div style="margin-bottom:50px;">
            <div style="float:left; width:50%;">
            	<div  class="app_mod_header"><h3>General Information</h3></div>
                
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Requirement Title</td>
                        <td style="background-color:##CCC;">
                            <div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.title#</div>
                        </td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Date Needed</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#DateFormat(get_itnss_requirement.date_needed, "mmm dd, yyyy")#</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Funded (Y/N)</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#is_funded#</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Type of Request</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.request_type#</div></td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Network Associated with Request</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_network_type.network_type_name#</div></td>
                    </tr>
                    
                     <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Classified/Unclassified/Standalone</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#is_classified#</div></td>
                    </tr>
                </table>
            </div>
            
            <div style="float:left; width:50%;">
            	<div  class="app_mod_header"><h3>Requestor Information</h3></div>
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Requestor</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#requestor_name#</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Phone</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#requestor_phone#</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Organization</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#requestor_symbol#</div></td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Lab Name</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.lab_name#</div></td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Lab Name</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.lab_name#</div></td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Lab Name</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.lab_name#</div></td>
                    </tr>
                                        
                    
                </table>
            </div>
            
            <br style="clear:both;">
   			</div>
            			
            
            <div id="outSteps" style="margin-bottom:50px;">
                <!--- REQUIREMENT --->
                <div style="width:100%; margin-bottom:25px;">
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; width:250px;"><strong>Requirement</strong></td>
                            <td style="background-color:##CCC;">
                            <div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.itnss_description#</div>
                           </td>
                        </tr>      
                    </table>
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                    <tr style="width:50%;">
                       <td align="left" style="border-top:1px solid ##666; width:250px;">AFRL/RQOC Staff Member who assisted with Requirement Description</td>
                       <td style="background-color:##CCC; width:350px">
                            <div style="padding:3px; background-color:##EEE; margin:5px;">#description_name#, #description_phone#</div>
                       </td>
                       <td colspan="2">&nbsp;</td>
                    </tr>   
                    </table>
                </div>
                
                <!--- JUSTIFICATION --->
                <div style="width:100%; margin-bottom:25px;">
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; width:250px;"><strong>Justification</strong></td>
                            <td style="background-color:##CCC;">
                                <div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.itnss_justification#</div>
                           </td>
                        </tr>      
                    </table>
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                    <tr style="width:50%;">
                       <td align="left" style="border-top:1px solid ##666; width:250px;">AFRL/RQOC Staff Member who assisted with Justification?</td>
                       <td style="background-color:##CCC; width:350px">
                            <div style="padding:3px; background-color:##EEE; margin:5px;">#justification_name#, #justification_phone#</div>
                       </td>
                       <td colspan="2">&nbsp;</td>
                    </tr>   
                    </table>
                </div>
          
                <!--- TECHNICAL SOLUTION --->            
                <div style="width:100%; margin-bottom:25px;">
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; width:250px;"><strong>Technical Solution</strong></td>
                            <td style="background-color:##CCC;">
                            <div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.itnss_solution#</div>
                           </td>
                        </tr>      
                    </table>
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                    <tr style="width:50%;">
                       <td align="left" style="border-top:1px solid ##666; width:250px;">AFRL/RQOC Staff Member who assisted with Technical Solution?</td>
                       <td style="background-color:##CCC; width:350px">
                            <div style="padding:3px; background-color:##EEE; margin:5px;">#solution_name#, #solution_phone#</div>
                       </td>
                       <td colspan="2">&nbsp;</td>
                    </tr>     
                    </table>
                </div>
                
                <!--- CSO/CTO/IAO COMMENTS --->                            
                <div style="width:100%; margin-bottom:25px;">
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; width:250px;">CSO/CTO/IAO Required Notes for Processing (RQOC only)</td>
                            <td style="background-color:##CCC;">
                                <div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.notes_cso_cto_iao#</div>
                           </td>
                        </tr>      
                    </table>
                </div>        
			</div>
           
           
            <!--- ATTACHMENTS --->
            <div style="margin-bottom:50px;">
                <div class="app_mod_header"><h3>ATTACHMENTS</h3></div>
                
                <table cellpadding="0" cellspacing="0" style="width:100%; border:1px solid ##EEE;">
                	<tr style="background-color:##ACD0EF; font-weight:bold; color:##444; ">
                    	<td style="padding:5px;">NAME</td>
                        <td style="padding:5px;width:150px;">SIZE</td>
                        <td style="padding:5px;width:150px;">MODIFIED</td>
                        <td style="padding:5px;width:150px;">BY</td>
                    </tr>
                    
                    <tr>
                    	<td colspan="4" style="padding:10px;">No Files Uploaded</td>
                    </tr>
            	</table>
            </div>
            
                 
            <!--- ACQ --->
            <div style="margin-bottom:50px;">
                <div class="app_mod_header"><h3>ACQ</h3></div>
                
                <div style="float:left; width:50%;">
                <table cellpadding="0" cellspacing="0" style=" width:95%;">
                    <tr>
                        <th colspan="2" style="text-align:left;"></th>
                    </tr>
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Purchase Vehicle (Form 9, GPC)</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_purchase_vehicle#</div></td>
                    </tr>
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">GPC Log Cross-Reference</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_gpc_log_cross_reference#</div></td>
                    </tr>
                    
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Funding Source (Org)</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_funding_source#</div></td>
                    </tr>
                    
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Fund Cite</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_fund_cite#</div></td>
                    </tr>
                
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Date Ordered</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(get_itnss_requirement.acq_date_ordered, "mmm dd, yyyy")#</div></td>
                    </tr>                
                </table>
                </div>            
            
            	<div style="float:left; width:50%;">
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<th colspan="2" style="text-align:left;"></th>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">AFWAY Waiver ##</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_afway_waiver_number#</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">AFWAY RFQ ##</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_afway_rfq_number#</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">AFWAY Tracking ##</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_afway_tracking_number#</div></td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">AFWAY Order ##</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_afway_order_number#</div></td>
                    </tr>
                    
					<tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Vendor Awarded</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_vendor_awarded#</div></td>
                    </tr>
                </table>
            	</div>
            	
                <br style="clear:both;">
                
                <div style="width:100%; margin-top:25px;">
                <table cellpadding="0" cellspacing="0" style=" width:100%;">
                	<tr>
                    	<td align="left" style="border-top:1px solid ##666; width:250px; background-color:##FFF;">Comments</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.acq_comments#</div>
                        </td>
                    </tr>                
                </table>
                
                </div>
            </div>
            
            
            <!--- APPROVAL STATUS --->
            <div id="outSteps">
            	<div  class="app_mod_header"><h3>Approval Status</h3></div>
                
            	<table cellpadding="15" cellspacing="0" style="width:100%;">
                	<tr style="background-color:##ACD0EF; font-weight:bold; color:##444; ">
                    	<td style="width:175px;"></td>
                        <td style="width:125px;">STATUS</td>
                        <td style="width:200px;">ROLE</td>
                        <td style="width:200px;">USER</td>
                        <td style="width:150px;">TIMESTAMP</td>
                        <td>COMMENTS</td>
                    </tr>
                    
                    <tr>
                    	<td></td>
                        <td><div style="padding:3px;"><div class="status_box_green"></div><div style="float:left; font-size:1em;">Approved</div><br style="clear:both;"></div></td>
                        <td>Org Approver</td>
                        <td><a href="##">Henry, Grinner</a></td>
                        <td>2018-03-20 14:11:05</td>
                        <td></td>
                    </tr>
                    
                    <tr style="background-color:##EFF6FC">
                    	<td></td>
                        <td><div style="padding:3px;"><div class="status_box_green"></div><div style="float:left; font-size:1em;">Approved</div><br style="clear:both;"></div></td>
                        <td>CSO/CTO</td>
                        <td><a href="##">Rieck, Ryan</a></td>
                        <td>2018-03-22 08:02:59</td>
                        <td></td>
                    </tr>
                  
                    <tr>
                    	<td></td>
                        <td><div style="padding:3px;"><div class="status_box_yellow"></div><div style="float:left; font-size:1em;">Edits Needed</div><br style="clear:both;"></div></td>
                        <td>ISSM</td>
                        <td><a href="##">Altenhaus, Phil</a></td>
                        <td>2018-03-23 15:32:35</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </td>
                    </tr>
                    
                    <tr style="background-color:##EFF6FC">
                    	<td></td>
                        <td><div style="padding:3px;"><div class="status_box"></div><div style="float:left; font-size:1em;">Pending</div><br style="clear:both;"></div></td> 
                        <td>Software Testing</td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    
                    <tr style="background-color:##EFF6FC">
                    	<td></td>
                        <td><div style="padding:3px;"><div class="status_box"></div><div style="float:left; font-size:1em;">Pending</div><br style="clear:both;"></div></td> 
                        <td>Software License</td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    
                    <tr style="background-color:##EFF6FC">
                    	<td></td>
                        <td><div style="padding:3px;"><div class="status_box"></div><div style="float:left; font-size:1em;">Pending</div><br style="clear:both;"></div></td> 
                        <td>ACQ</td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>	
            </div>

            <br style="clear:both;">
            <br style="clear:both;">

            <div style="background-color:##EEE; padding:10px;">
                <div style="float:left; width:50%;">
                    <div  class="app_mod_header"><h3>Status Info</h3></div>
                    <table cellpadding="0" cellspacing="0" style=" width:95%;">
                        
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Status</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.itnss_status#</div></td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Tracking Number</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.tracking_number#</div></td>
                        </tr>
    
                        </tr>
                    </table>
                </div>
                
                <div style="float:left; width:50%;">
                    <div  class="app_mod_header"><h3>Record Info</h3></div>
                    <table cellpadding="0" cellspacing="0" style=" width:95%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Created</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(get_itnss_requirement.date_created, "mmm dd, yyyy")#</div></td><!--- goto  --->
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Created By</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#created_by_name#</div></td>
                        </tr>
    
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Modified</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(Now(), "mmm dd, yyyy")#</div></td>
                        </tr>
    
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Modified By</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">Grinner, Henry</div></td>
                        </tr>
                    </table>
                </div>
                
                <br style="clear:both;">
            </div>


            <div style="background-color:##EEE; padding:10px; padding-bottom:25px;">
                <div style="float:left; width:50%;">
                    <div  class="app_mod_header"><h3>Milestone Dates</h3></div>
                    <table cellpadding="0" cellspacing="0" style=" width:95%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Created</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(get_itnss_requirement.date_created, "mmm dd, yyyy")#</div></td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Submitted for Review</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(Now(), "mmm dd, yyyy")#</div></td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Completion Date</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateTimeFormat(DateAdd("d", 90, date_now),"mmm dd, yyyy")#</div></td>
                        </tr>
                    </table>
                </div>
                
                <div style="float:left; width:50%;">
                    <div  class="app_mod_header"><h3>Milestone Metrics</h3></div>
                    <table cellpadding="0" cellspacing="0" style=" width:95%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Days in Draft</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">0</div></td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days in Review</td>
                            <td style="background-color:##CCC;">
                                <div style="padding:3px; background-color:##F3F3F3; margin:5px;">
                                    #Abs(DateDiff("d", get_itnss_requirement.date_created, DateFormat(Now())))#
                                </div>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days From Review to Completed</td>
                            <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">&nbsp;</div></td>
                        </tr>
                        
                        <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days Overall</td>
                        <td style="background-color:##CCC;">
                            <div style="padding:3px; background-color:##F3F3F3; margin:5px;">
                                #Abs(DateDiff("d", get_itnss_requirement.date_created, DateFormat(Now())))#
                            </div>
                        </td>
                        </tr>
                    </table>
                </div>
                
                <br style="clear:both;">
            </div>
                  
            <br style="clear:both;">
            
            <div class="action_bar">
            	<button type="button" class="print_button">Print</button>
                <button type="button" class="edit_button">Edit</button>
                <button type="button" class="cancel_button">Cancel</button>
            </div>
        </div>
	</div>

	<br style="clear:both;">
	
</div>
<br style="clear:both;">
</cfoutput>

<script type="text/javascript">
$(function() {
	//Initialize tabs
	$("#ticket_tabs").tabs();
	
	
	$(".cancel_button").button({
		icons: {
			primary: "ui-icon-cancel"
		}
	}).click(function() {
		alert("ITNSS Request Canceled");
	});
			
	$(".print_button").button({
		icons: {
			primary: "ui-icon-print"
		}
	}).click(function() {
		alert("ITNSS Request is now printing");
	});
	
	$(".edit_button").button({
		icons: {
			primary: "ui-icon-pencil"
		}
	}).click(function() {
		alert("ITNSS Request can not be edited at this time.");
	});
	
	$("#keys").click(function() {
		//openWindow("steps_keys.cfm","","testme","Keys / Bldg Access");	
	});
});
</script>