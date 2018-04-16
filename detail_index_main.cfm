<cfparam name="URL.requestID" default="0">
<cfparam name="description_staff" default="">
<cfparam name="justification_staff" default="">
<cfparam name="solution_staff" default="">


<style type="text/css">
.app_mod_header {margin-top:10px;margin-bottom:5px;}
.outProcess_desc {background-color:#D4FEFF;/*#FFF9CF;*//*#F9F8E3;*/padding:5px;margin-bottom:5px;}
.outProcess_status {background-color:#EEE;padding:5px;margin-bottom:5px;border:1px solid #DDD;}
.outProcess_status_bar {background-color:#63E1E4;/*#FFEE5A;*/border:1px solid #168082;/*#EBD200;*/width:20%;padding:5px;text-align:center;font-size:1.25em;}
.outProcess_status_text {width:80%;padding:5px;text-align:center;font-size:1.25em;}
.outProcess_actions {text-align:right;margin-bottom:25px;}
.action_bar {background-color:#bbb;margin-bottom:25px;padding:5px;text-align:left;}
td {border-top:1px solid #666;}
#outSteps td {border-top:1px solid #666;padding:5px;}
.status_box {height:15px;width:15px;background-color:#CCC;border:1px solid #999;float:left;margin-right:7px;margin-top:3px;}
.status_box_green {height:15px;width:15px;background-color:#5FE85E;border:1px solid #1AAF19;float:left;margin-right:7px;margin-top:3px;}
.status_box_yellow {height:15px;width:15px;background-color:#FFEA33;border:1px solid #A39200;float:left;margin-right:7px;margin-top:3px;}
#keys {cursor:pointer;}
#navmenu {list-style:none;margin-right:25px;padding:10px;}
#navmenu li {cursor:pointer;padding:10px;}
#navmenu li:hover {background-color:#C1EBFF;}
.modern_button {letter-spacing: 0.1px;color: #F2F5FC;text-align: center;text-decoration: none;background-color: #00308F;transition: background-color 0.5s ease, border 0.5s ease;border: 0px solid #BDCEEF;padding: 5px 8px;}
.modern_button:hover {background-color: #0049D1;border: 0px solid #D7E3F8;color: #ffffff;cursor: pointer;}
#div_attachments tbody td{padding:10px;}
#div_attachments tbody:empty:after{content:"No Files Uploaded";display:block;padding:10px;}
</style>

<cftry>

<!---
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
--->

<!--- Get ITNSS Request details --->
<cfquery name="get_itnss_requirement" datasource="#APPLICATION.asd#">
    SELECT * 
    FROM itnss_requirement
    WHERE itnss_requirement_id = #URL.requestID#
</cfquery>

<!--- Get Request Labs --->
<cfquery name="getITNSSLabs" datasource="#APPLICATION.asd#">
	SELECT	itnss_labs.itnss_requirement_id, itnss_labs.lab_id, labs_valid.lab_name
	FROM	itnss_labs 
    	INNER JOIN labs_valid ON itnss_labs.lab_id = labs_valid.lab_id	
        
    WHERE	 itnss_requirement_id = #URL.requestID#
</cfquery>

<!--- Get Requestor Info --->
<cfquery name="get_requestor_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi FROM account_info
    WHERE cac_edipi = '#trim(listlast(cgi.cert_subject,"."))#'
</cfquery>
    <cfset requestor_name   = "#get_requestor_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
    <cfset requestor_title  = "#get_requestor_cacedipi.title#">
    <cfset requestor_symbol = "#get_requestor_cacedipi.symbol#">
    <cfset requestor_phone  = "#get_requestor_cacedipi.phone_number#">

<!--- Get Created By Info --->
<cfquery name="get_created_by_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi FROM account_info
    WHERE cac_edipi = #get_itnss_requirement.created_by#
</cfquery>
    <cfset created_by_name   = "#get_created_by_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
    <cfset created_by_title  = "#get_created_by_cacedipi.title#">
    <cfset created_by_symbol = "#get_created_by_cacedipi.symbol#">
    <cfset created_by_phone  = "#get_created_by_cacedipi.phone_number#">


<!---Get Attachments Info--->
<cfset ATTACHMENTS=createObject("component","attachments")>
<cfset get_attachments=ATTACHMENTS.query_attachments(url.requestID)>

<!--- Get Description Info --->
<cfif LEN(get_itnss_requirement.itnss_description_staff_cacedipi) EQ 10>
<cfquery name="get_description_staff_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname
    FROM account_info
    WHERE cac_edipi = #get_itnss_requirement.itnss_description_staff_cacedipi#
</cfquery>
    
    <cfset description_staff = "#get_description_staff_cacedipi.gal_displayname# #get_description_staff_cacedipi.phone_number#">
	<!---
	<cfset description_name   = "#get_description_staff_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
	<cfset description_title  = "#get_description_staff_cacedipi.title#">
    <cfset description_symbol = "#get_description_staff_cacedipi.symbol#">
    <cfset description_phone  = "#get_description_staff_cacedipi.phone_number#">
	--->
</cfif>
	
<!--- Get Justification Info --->
<cfif LEN(get_itnss_requirement.itnss_justification_staff_cacedipi) EQ 10>
<cfquery name="get_justification_staff_cacedipi" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname 
    FROM account_info
    WHERE cac_edipi = #get_itnss_requirement.itnss_justification_staff_cacedipi#
</cfquery>
    <cfset justification_staff = "#get_justification_staff_cacedipi.gal_displayname#, &nbsp;&nbsp; #get_justification_staff_cacedipi.phone_number#">
    <!---
	<cfset justification_name   = "#get_justification_staff_cacedipi.first_name# #get_requestor_cacedipi.last_name#">
    <cfset justification_title  = "#get_justification_staff_cacedipi.title#">
    <cfset justification_symbol = "#get_justification_staff_cacedipi.symbol#">
    <cfset justification_phone  = "#get_justification_staff_cacedipi.phone_number#">
	--->
</cfif>

<!--- Get Solution Info --->
<cfif LEN(get_itnss_requirement.itnss_solution_staff_cacedipi) EQ 10>
<cfquery name="get_solution_staff" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname
    FROM account_info
    WHERE cac_edipi = #get_itnss_requirement.itnss_solution_staff_cacedipi#
</cfquery>
	<cfset solution_staff = "#get_solution_staff.gal_displayname# #get_solution_staff.phone_number#">
    <!---
	<cfset solution_name   = "#get_solution_staff.gal_displayname#">
    <cfset solution_title  = "#get_solution_staff.title#">
    <cfset solution_symbol = "#get_solution_staff.symbol#">
    <cfset solution_phone  = "#get_solution_staff.phone_number#">
	--->
</cfif>

<!--- Get Network Type --->
<cfquery name="get_itnss_network_type" datasource="#APPLICATION.asd#">
    SELECT itnss_network_type_id, network_type_name FROM itnss_network_type
    WHERE itnss_network_type_id = #get_itnss_requirement.fk_network_type_id#
</cfquery>

<!--- Field name changed (8/26/2018 cm)
<cfif #get_itnss_requirement.is_classified# IS 0>
    <cfset is_classified = "Unclassified">
<cfelse>
    <cfset is_classified = "Classified">    
</cfif>
--->

<cfif  #get_itnss_requirement.is_funded# IS 0>
    <cfset is_funded = "Not Funded">
<cfelse>
    <cfset is_funded = "Funded">
</cfif>

<cfcatch>
	<cfdump var="#cfcatch#"><cfabort>
</cfcatch>
</cftry>

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
	
    
	<!--- Right (main) Column --->
	<div id="ticket_tabs" style="float:left; max-width:1350px;  min-width:200px;">
		<ul>
        	<li><a href="##itnss_tab">ITNSS/3215/CSRD</a></li>
        </ul>
        
        <div id="itnss_tab" style="margin:10px;">
        	<div class="outProcess_desc">
            	<strong>*&nbsp;</strong>Submission currently in draft and has not been submitted for review.
            </div>
            
            
            <!--- EDITS REQUIRED MESSAGE --->
            <!---
            <div class="outProcess_desc">
            	<strong>ATTENTION!&nbsp;&nbsp;</strong>Submission requires edits from the requestor and needs to be resubmitted before it continues through the workflow.
            </div>
            --->
            
            <div class="outProcess_status">
            	<div class="outProcess_status_bar" style="float:left;">&nbsp;</div>
                <div class="outProcess_status_text" style="float:left;">Completion Status (20%)</div>
                <br style="clear:both;">
            </div>
            <!---Instead of using a div for the above status bar, could use svg rectangle/path element--->
<!---
         	<div>
            	<svg width="100%" height="[desired height]" viewBox="0 0 100 100" preserveAspectRatio="none meet">
					<rect x="0" y="0" height="100" width="[percentage completion expressed as integer]" fill="[whatever color you are using]" stroke="[whatever border color you are using]"></rect>
				</svg>
                <div style="[styles to position in center of parent]">
                	Completion Status (<span>20</span>%)
                </div>
            </div>
--->
            <div class="action_bar">
            	<button type="button" class="print_button">Print</button>
                <button type="button" class="edit_button" value="#URL.requestID#">Edit</button><!---TODO: add value to bottom button as well --->

                
                <!--- FUTURE ENHANCEMENT:  Cancels Request --->
                <!---<button type="button" class="cancel_button">Cancel</button>--->
            </div>
            
            <!--- GENERAL INFORMATION --->            
            <div style="margin-bottom:50px;">
            <div style="float:left; width:50%;">
            	<div  class="app_mod_header"><h3>General Information</h3></div>
                
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Requirement Title</td>
                        <td style="background-color:##CCC;">
                            <div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.title#&nbsp;</div>
                        </td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Date Needed</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#DateFormat(get_itnss_requirement.date_needed, "mmmm dd, yyyy")#</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Funded (Y/N)</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#UCASE(get_itnss_requirement.is_funded)#</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Type of Request</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#UCASE(get_itnss_requirement.request_type)#</div></td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Network Associated with Request</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#UCASE(get_itnss_network_type.network_type_name)#</div></td>
                    </tr>
                    
                     <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Classified/Unclassified/Standalone</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#UCASE(get_itnss_requirement.classification)#</div></td>
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
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#requestor_phone#&nbsp;</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Organization</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#requestor_symbol#</div></td>
                    </tr>
                    
                    <cfloop query="getITNSSLabs">
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Lab Name</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">#lab_name#</div></td>
                    </tr>
                    </cfloop>
                                        
                    
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
                            	<div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.itnss_description#&nbsp;</div>
                        	</td>
                        </tr>      
                    </table>
                    
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                           <td align="left" style="border-top:1px solid ##666; width:250px;">AFRL/RQOC Staff Member who assisted with the Requirement?</td>
                           <td style="background-color:##CCC; ">
                                <div style="padding:3px; background-color:##EEE; margin:5px;">#description_staff#&nbsp;</div>
                           </td>
                        </tr>   
                    </table>
                </div>
                
                <!--- JUSTIFICATION --->
                <div style="width:100%; margin-bottom:25px;">
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; width:250px;"><strong>Justification</strong></td>
                            <td style="background-color:##CCC;">
                                <div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.itnss_justification#&nbsp;</div>
                           </td>
                        </tr>      
                    </table>
                    
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                           <td align="left" style="border-top:1px solid ##666; width:250px;">AFRL/RQOC Staff Member who assisted with the Justification?</td>
                           <td style="background-color:##CCC; ">
                                <div style="padding:3px; background-color:##EEE; margin:5px;">#justification_staff#&nbsp;</div>
                           </td>
                        </tr>   
                    </table>
                </div>
          
                <!--- TECHNICAL SOLUTION --->            
                <div style="width:100%; margin-bottom:25px;">
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; width:250px;"><strong>Technical Solution</strong></td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.itnss_solution#&nbsp;</div>
                           </td>
                        </tr>      
                    </table>
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                           <td align="left" style="border-top:1px solid ##666; width:250px;">AFRL/RQOC Staff Member who assisted with the Technical Solution?</td>
                           <td style="background-color:##CCC; ">
                                <div style="padding:3px; background-color:##EEE; margin:5px;">#solution_staff#&nbsp;</div>
                           </td>
                        </tr>   
                    </table>
                </div>
                
                <!--- CSO/CTO/IAO COMMENTS --->                            
                <div style="width:100%; margin-bottom:25px;">
                    <table cellpadding="0" cellspacing="0" style=" width:100%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; width:250px;">CSO/CTO/IAO Required Notes for Processing (RQOC only)</td>
                            <td style="background-color:##CCC;">
                                <div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.notes_cso_cto_iao#&nbsp;</div>
                           </td>
                        </tr>      
                    </table>
                </div>        
			</div>
         
            <!--- ATTACHMENTS --->
            <div style="margin-bottom:50px;" id="div_attachments">
            	<input id="hidden_itnssid" type="hidden" value="#URL.requestID#"/>
                <div class="app_mod_header"><h3>ATTACHMENTS</h3></div>
                
                <table cellpadding="0" cellspacing="0" style="width:100%; border:1px solid ##EEE;">
                	<thead>
                        <tr style="background-color:##ACD0EF; font-weight:bold; color:##444; ">
                            <td style="padding:5px;">NAME</td>
                            <td style="padding:5px;width:150px;">SIZE</td>
                            <td style="padding:5px;width:150px;">MODIFIED</td>
                            <td style="padding:5px;width:150px;">BY</td>
                        </tr>
                    </thead>
                    <!---For CSS :empty:after rule to function (which places the text "No Files Uploaded" into the table if there are no table rows e.g. no uploaded files), it is imperative that NO whitespaces/linebreaks are used within table body--->
                    <tbody><cfloop query="get_attachments"><tr><td><a href="attachments.cfc?method=download_attachment&attachment_id=#id#">#name#</a></td><td>#size#</td><td>#mod_date#</td><td>#mod_user#</td></tr></cfloop></tbody>
            	</table>
            </div>
            
                 
            <!--- ACQ --->
            <div style="margin-bottom:50px;">
                <div class="app_mod_header"><h3>ACQUISITION</h3></div>
                
                <div style="float:left; width:50%;">
                <table cellpadding="0" cellspacing="0" style=" width:95%;">
                    <tr>
                        <th colspan="2" style="text-align:left;"></th>
                    </tr>
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Purchase Vehicle (Form 9, GPC)</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_purchase_vehicle#&nbsp;</div>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">GPC Log Cross-Reference</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_gpc_log_cross_reference#&nbsp;</div>
                       	</td>
                    </tr>
                    
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Funding Source (Org)</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_funding_source#&nbsp;</div>
                        </td>
                    </tr>
                    
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Fund Cite</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_fund_cite#&nbsp;</div>
                        </td>
                    </tr>
                
                    <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Date Ordered</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(get_itnss_requirement.acq_date_ordered, "mmm dd, yyyy")#&nbsp;</div>
                        </td>
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
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_afway_waiver_number#&nbsp;</div>
                        </td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">AFWAY RFQ ##</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_afway_rfq_number#&nbsp;</div>
                        </td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">AFWAY Tracking ##</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_afway_tracking_number#&nbsp;</div>
                        </td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">AFWAY Order ##</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_afway_order_number#&nbsp; </div>
                        </td>
                    </tr>
                    
					<tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Vendor Awarded</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.acq_vendor_awarded#&nbsp;</div>
                        </td>
                    </tr>
                </table>
            	</div>
            	
                <br style="clear:both;">
                
                <div style="width:100%; margin-top:25px;">
                <table cellpadding="0" cellspacing="0" style=" width:100%;">
                	<tr>
                    	<td align="left" style="border-top:1px solid ##666; width:250px; background-color:##FFF;">Comments</td>
                        <td style="background-color:##CCC;">
                        	<div style="padding:3px; background-color:##EEE; margin:5px;">#get_itnss_requirement.acq_comments#&nbsp;</div>
                        </td>
                    </tr>                
                </table>
                
                </div>
            </div>
            
            
            <!--- APPROVAL STATUS --->
            <div id="outSteps">
            	<div  class="app_mod_header"><h3>Approval Status</h3></div>
                <cfquery name="getApprovers" datasource="#APPLICATION.asd#">
                    SELECT	itnss_approvers.approver_id, itnss_approvers.process_participant_id, process_participants.role_id, 
                    	ARUser.roles_valid.role_name, itnss_approvers.sequence, itnss_approvers.approved_by, 
                        itnss_approvers.approved_date, itnss_approvers.status_id, itnss_approvers.itnss_requirement_id, 
                        itnss_approvers.comments, process_participants.participant_displayname, 
                        itnss_status.status_name
                        
                    FROM	itnss_approvers 
                    	INNER JOIN process_participants ON itnss_approvers.process_participant_id = process_participants.process_participant_id 
                        INNER JOIN ARUser.roles_valid ON process_participants.role_id = ARUser.roles_valid.role_id 
                        INNER JOIN itnss_status ON itnss_approvers.status_id = itnss_status.status_id
                        
                    WHERE     (itnss_approvers.itnss_requirement_id = 17)
                    ORDER BY itnss_approvers.sequence
                </cfquery>
                
            	<table cellpadding="15" cellspacing="0" style="width:100%;">
                	
                	<tr style="background-color:##ACD0EF; font-weight:bold; color:##444; ">
                    	<td style="width:175px;"></td>
                        <td style="width:125px;">STATUS</td>
                        <td style="width:200px;">ROLE</td>
                        <td style="width:200px;">USER</td>
                        <td style="width:150px;">TIMESTAMP</td>
                        <td>COMMENTS</td>
                    </tr>
                    
                    <cftry>
                    <cfloop query="getApprovers">
                    <tr>
                    	<td></td>
                        <td><div style="padding:3px;"><div class="status_box"></div><div style="float:left; font-size:1em;">#status_name#</div><br style="clear:both;"></div></td>
                        <td>#participant_displayname#</td>
                        <td>#approved_by#</td>
                        <td>#approved_date#</td>
                        <td>#comments#</td>
                    </tr>
                	</cfloop>
                	
                    <cfcatch><cfdump var="#cfcatch#"></cfcatch>
                    </cftry>                    
                </table>	
            </div>

            <br style="clear:both;">
            <br style="clear:both;">
            
            <!--- REQUEST METRICS --->
            <div style="background-color:##EEE; padding:10px;">
                <div style="float:left; width:50%;">
                    <div  class="app_mod_header"><h3>Status Info</h3></div>
                    <table cellpadding="0" cellspacing="0" style=" width:95%;">
                        
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Status</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.itnss_status#</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Tracking Number</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.tracking_number#&nbsp;</div>
                            </td>
                        </tr>
    
                        </tr>
                    </table>
                </div>
                
                <div style="float:left; width:50%;">
                    <div  class="app_mod_header"><h3>Record Info</h3></div>
                    <table cellpadding="0" cellspacing="0" style=" width:95%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Created</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(get_itnss_requirement.created_date, "mmm dd, yyyy")#</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Created By</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.created_by#</div>
                            </td>
                        </tr>
    
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Modified</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(get_itnss_requirement.last_modified_date, "mmm dd, yyyy")#</div>
                            </td>
                        </tr>
    
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Modified By</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#get_itnss_requirement.last_modified_by#</div>
                            </td>
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
                            <td style="background-color:##CCC;">
                           		<div style="padding:3px; background-color:##F3F3F3; margin:5px;">#DateFormat(get_itnss_requirement.date_created, "mmm dd, yyyy")#</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Submitted for Review</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">TBD</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Completion Date</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">TBD</div>
                            </td>
                        </tr>
                    </table>
                </div>
                
                <div style="float:left; width:50%;">
                    <div  class="app_mod_header"><h3>Milestone Metrics</h3></div>
                    <table cellpadding="0" cellspacing="0" style=" width:95%;">
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Days in Draft</td>
                            <td style="background-color:##CCC;">
                            	<div style="padding:3px; background-color:##F3F3F3; margin:5px;">0</div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days in Review</td>
                            <td style="background-color:##CCC;">
                                <div style="padding:3px; background-color:##F3F3F3; margin:5px;">
                                    TBD
                                </div>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days From Review to Completed</td>
                            <td style="background-color:##CCC;">
                           		<div style="padding:3px; background-color:##F3F3F3; margin:5px;">TBD</div>
                            </td>
                        </tr>
                        
                        <tr>
                        <td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days Overall</td>
                        <td style="background-color:##CCC;">
                            <div style="padding:3px; background-color:##F3F3F3; margin:5px;">
                                TBD
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
                
				<!--- FUTURE ENHANCEMENT:  Cancels Request --->
                <!---<button type="button" class="cancel_button">Cancel</button>--->
            </div>
        </div>
	</div>

	<br style="clear:both;">
	
</div>
<br style="clear:both;">
</cfoutput>

<script type="text/javascript">
function addAttachmentRow(o){
	if(o.error){
		alert(o.error+"\n"+o.detail);
		}else{
		var newRow=document.createElement("tr");
		var td_name=document.createElement("td");
		var anc=document.createElement("a");
		anc.setAttribute("href","attachments.cfc?method=download_attachment&attachment_id="+o.id);
		anc.appendChild(document.createTextNode(o.name));
		td_name.appendChild(anc);
		var td_size=document.createElement("td");
		td_size.appendChild(document.createTextNode(o.size));
		var td_date=document.createElement("td");
		td_date.appendChild(document.createTextNode(o.on));
		var td_user=document.createElement("td");
		td_user.appendChild(document.createTextNode(o.by));
		newRow.appendChild(td_name);
		newRow.appendChild(td_size);
		newRow.appendChild(td_date);
		newRow.appendChild(td_user);
		$("#div_attachments tbody").append(newRow);
		}
	}
$(function() {
	//Get Request ID
	<cfoutput></cfoutput>
	
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
		window.print();
	});
	
	$(".edit_button").button({
		icons: {
			primary: "ui-icon-pencil"
		}
	}).click(function() {
		window.location='update_record.cfm?requestID='+this.value;
	});
	
	$("#keys").click(function() {
		//openWindow("steps_keys.cfm","","testme","Keys / Bldg Access");	
	});
	document.addEventListener("dragover",function(event){
		event.preventDefault();
		});
	document.addEventListener("drop",function(event){
		event.preventDefault();
		});
	
	document.getElementById("div_attachments").addEventListener("drop",function(event){
		event.preventDefault();
		var aFiles=event.dataTransfer.files;
		var url="attachments.cfc?method=upload_attachment";
		for(var i=0;i<aFiles.length;i++){
			var data=new FormData();
			data.append("requirement_id",document.getElementById("hidden_itnssid").value);
			data.append("file",aFiles[i]);
			data.append("fileName",aFiles[i].name);
			$.ajax({
				url:url,
				method:"POST",
				async:true,
				dataFilter:function(r,t){
					while(r.charAt(0)=="/"){
						r=r.slice(1);
						}
					return r;
					},
				dataType:"json",
				processData:false,
				contentType:false,
				data:data,
				success:function(o,s,xhr){
					addAttachmentRow(o);
					}
				})
			}
		});
		
});
</script>