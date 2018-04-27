 <!--- load form_styles.css ---> 
<link rel="stylesheet" type="text/css" href="css/form_styles.css">
<style>
[data-itnss="itnss_description"]{min-height:35px;width:100%;padding:3px;}
[data-itnss="itnss_justification"]{min-height:35px;width:100%;padding:3px;}
[data-itnss="itnss_solution"]{min-height:35px;width:100%;padding:3px;}
[data-itnss="notes_cso_cto_iao"]{min-height:35px;width:100%;padding:3px;}
[data-itnss="acq_comments"]{min-height:35px;width:100%;padding:3px;}
.dz_container_normal {border:2px dashed #dee3e7;border-radius: 3px;}
.dz_container_over {border:2px dashed #939393;border-radius: 3px;}
.dz_normal {color:#a6b6c2;background-color:#ECEDEE;transition:background-color 0.5s ease, border 0.5s ease;}
.dz_over {color:#939393;background-color:rgba(117, 117, 117, 0.2);transition:background-color 0.5s ease, border 0.5s ease;}
</style>

<cfparam name="URL.requestID" default="0">
<cfquery name="get_record" datasource="#APPLICATION.asd#">
    SELECT * 
    FROM itnss_requirement
    WHERE itnss_requirement_id = #URL.requestID#
</cfquery>


    <cfset record_id       = "#URL.requestID#">
    <cfset title           = "#get_record.title#">
    <cfset date_created    = "#get_record.date_created#">
    <cfset created_by      = "#get_record.created_by#">
    <cfset date_needed     = "#get_record.date_needed#">
    <cfset requestor       = "#get_record.created_by#">
    <cfset is_funded       = "#get_record.is_funded#">
    <cfset lab_name        = "#get_record.lab_name#">
    <cfset request_type    = "#get_record.request_type#">
    <!---<cfset network_type_id = "#get_record.fk_network_type_id#">--->
    <cfset classification  = "#get_record.classification   #">
    <cfset desc            = "#get_record.itnss_description#">
    <cfset d_staff         = "#get_record.itnss_description_staff_cacedipi#">
    <cfset just            = "#get_record.itnss_justification#">
    <cfset j_staff         = "#get_record.itnss_justification_staff_cacedipi#">
    <cfset solu            = "#get_record.itnss_solution#">
    <cfset s_staff         = "#get_record.itnss_solution_staff_cacedipi#">
    <cfset notes           = "#get_record.notes_cso_cto_iao    #">
    <cfset acq_pv          = "#get_record.acq_purchase_vehicle#">
    <cfset acq_xref        = "#get_record.acq_gpc_log_cross_reference#">
    <cfset acq_fsrc        = "#get_record.acq_funding_source#">
    <cfset acq_fcite       = "#get_record.acq_fund_cite#">
    <cfset acq_wvrno       = "#get_record.acq_afway_waiver_number#">
    <cfset acq_rfqno       = "#get_record.acq_afway_rfq_number#">
    <cfset acq_trkno       = "#get_record.acq_afway_tracking_number#">
    <cfset acq_ordno       = "#get_record.acq_afway_order_number#">
    <cfset acq_vendor      = "#get_record.acq_vendor_awarded#">
    <cfset acq_dte_ordered = "#get_record.acq_date_ordered#">
    <cfset acq_comments    = "#get_record.acq_comments#">


<cfif IsDefined("get_record.lab_name") AND LEN(get_record.lab_name)>
    <cfquery name="get_itnss_lab_1" datasource="#APPLICATION.asd#">
        SELECT i.itnss_requirement_id, i.lab_id
              , v.lab_id AS v_labId, v.lab_name AS v_labName
              , r.itnss_requirement_id
        FROM labs_valid v
        LEFT OUTER JOIN itnss_labs i ON v.lab_id = i.lab_id
        LEFT OUTER JOIN itnss_requirement r ON i.itnss_requirement_id = r.itnss_requirement_id
        WHERE r.itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_int" value="#URL.requestID#">
        ORDER BY i.itnss_requirement_id
    </cfquery>
<cfelse>
    <cfset #get_itnss_lab_1.v_labId# = "0">
    <cfset #get_itnss_lab_1.v_labName# = 'Please Make A Selection'>
</cfif>

<cfquery name="get_labs_valid" datasource="#APPLICATION.asd#">
    SELECT lab_id, lab_abbr, lab_name, lab_desc, lab_location, active
    FROM labs_valid
</cfquery>
    
<cfquery name="get_created_by" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname 
    FROM account_info
    WHERE cac_edipi = <cfqueryparam cfsqltype="cf_sql_int" value="#created_by#" />
</cfquery>
    <cfset cb_name   = "#get_created_by.first_name# #get_created_by.last_name#">
    <cfset cb_title  = "#get_created_by.title#">
    <cfset cb_symbol = "#get_created_by.symbol#">
    <cfset cb_phone  = "#get_created_by.phone_number#">
    
<cfquery name="get_user_list" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname
    FROM account_info
</cfquery>


<!--- Get AFRL/RQOC staff for drop-downs. --->
<cfquery name="getRQOC" datasource="#APPLICATION.asd#">
	SELECT	*, UPPER(last_name + ', ' + first_name) as fullname
    FROM	account_info
    WHERE	symbol LIKE '%RQOC%'
    	AND	non_user <> 1 
    	AND status_code = 1
        
    ORDER BY last_name, first_name
</cfquery>

<!--- Removed for one query pulling RQOC Staff (4/23/2018-cm) --->
<!---
<cfquery name="get_description_staff" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname
    FROM account_info
    WHERE cac_edipi = #get_record.itnss_description_staff_cacedipi#
</cfquery>

<cfquery name="get_justification_staff" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname
    FROM account_info
    WHERE cac_edipi = #get_record.itnss_justification_staff_cacedipi#
</cfquery>

<cfquery name="get_solution_staff" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname
    FROM account_info
    WHERE cac_edipi = #get_record.itnss_solution_staff_cacedipi#
</cfquery>
--->

<cfif IsDefined("get_record.is_funded_authority") AND LEN(get_record.is_funded_authority)>
    <cfquery name="get_is_funded_authority" datasource="#APPLICATION.asd#">
        SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname
        FROM account_info
        WHERE cac_edipi = #get_record.is_funded_authority#
    </cfquery>
    <cfelse>
        <cfquery name="get_is_funded_authority" datasource="#APPLICATION.asd#">
        SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi, gal_displayname
        FROM account_info
    </cfquery>
</cfif>

<cfquery name="get_requirement_lab" datasource="#APPLICATION.asd#">
    SELECT itnss_requirement_id, lab_id 
    FROM itnss_labs 
    WHERE itnss_requirement_id = #get_record.itnss_requirement_id#
</cfquery>

<cfquery name="get_valid_labs" datasource="#APPLICATION.asd#">
    SELECT lab_id, lab_abbr, lab_name, lab_desc, lab_location, active
    FROM labs_valid    
</cfquery>

 <!--- FORM STYLES ---> 
<link rel="stylesheet" type="text/css" href="css/form_styles.css">

<cfoutput>


<div class="wrapper-all">
	<!--- Navigation --->
	<cfinclude template="navigation.cfm">

    <div id="ticket_tabs" class="ticket-tabs">   
        <ul>
          <li><a href="##itnss_tab">EDIT RQ-2018-#get_record.itnss_requirement_id# | #get_record.title#</a></li>
        </ul>

<div class="save-button" style="">
    <label data-itnss="status_label" style="font-size:12px;color:white;margin-top:12px;"></label>
    <div id="btn_submit_test_0" data-itnss="btn_submit_test" class="modern_button" style="width:100px;padding-left:15px;">
        <!--- http://cssicon.space/old/ --->
                <svg id="svg_cloud_icon_1" class="svg_cloud_icon" width="15" height="25" viewBox="13 0 60 75" 
                    version="1.1" xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink"
                    xmlns:ev="http://www.w3.org/2001/xml-events" >
                    <g id="svg_icon_container" xmlns="http://www.w3.org/2000/svg">
                        <ellipse id="cloud_icon_shadow" fill="rgb(222, 227, 231)" cx="43.3" cy="73.9" rx="37.6" ry="4.1"/>
                        <g id="svg_inner_container">
                            <path id="cloud_icon" fill="rgb(166, 182, 194)"
                            d="M69.4,21.5C66.9,9.2,56,0,43,0C32.6,0,23.7,5.8,19.2,14.4C8.4,15.5,0,24.6,0,35.6C0,47.5,9.6,57,21.5,57
                            h46.6C78,57,86,49,86,39.2C86,29.8,78.6,22.2,69.4,21.5z"/>
                            <polygon id="up_arrow_icon" fill="rgb(240, 242, 244)" 
                            points="50.2,32.1 50.2,46.3 35.8,46.3 35.8,32.1 25.1,32.1 43,14.3 60.9,32.1 "/>
                        </g>
                    </g>
                </svg>
        <span id="lbl_undo_image" style="margin-right:20px;float:right;display:block;">Save</span>
    </div>
</div>
    <form id="form_edit_record" data-itnss="form_edit_record" method="post"> 
        <input data-itnss="record_id" type="hidden" name="record_id" class="form-field-input" value="#record_id#">
        
        <div class="form-block-1">
            <label for="title" class="ff-label">Requirement Title
            <input data-itnss="title" type="text" name="title" class="form-field-input req-input" value="#title#">
            </label>
        </div>        
        
        <div class="form-block-1">
            <label for="date_needed" class="ff-label">Date Needed
            <input data-itnss="date_needed" type="text" name="date_needed" class="form-field-input ff-input-date"> 
            </label>
        </div>
                  
		<br style="clear:both;">
        
        <div class="form-block-2">
            <label for="created_by" class="ff-label">Point of Contact
            <select data-itnss="poc" id="poc" name="poc" class="form-field-input">
                <option value="">Select Point of Contact</option>
                <cfloop query="get_user_list"> 
                    <option value="#get_user_list.cac_edipi#" <cfif get_record.created_by EQ get_user_list.cac_edipi>selected</cfif>>
                    #get_user_list.gal_displayname#</option> 
                </cfloop>
            </select>
            </label>
        </div>
        
        <div class="form-block-2">
            <label for="is_funded_authority" class="raa-label">Org Approval Authority
                <select data-itnss="is_funded_authority" name="is_funded_authority" class="form-field-input">
                    <cfloop query="get_user_list"> 
                        <option value="#get_user_list.cac_edipi#" <cfif get_record.is_funded_authority EQ get_user_list.cac_edipi>selected</cfif>>
                        #get_user_list.gal_displayname#
                        </option> 
                    </cfloop>
                </select>
            </label>
            </div>
        
		<br style="clear:both;">
        
        <div class="form-block-4">
            <label for="lab_name1" class="ff-label">Lab Name
                <select data-itnss="lab_name1" name="lab_name1">
                    <option value="#get_itnss_lab_1.v_labId#">#get_itnss_lab_1.v_labName#</option>
                    <cfloop query="get_valid_labs"> 
                        <option value="#get_valid_labs.lab_id#">#get_valid_labs.lab_name#</option> 
                    </cfloop>
                </select>
            </label>
        </div>

		<br style="clear:both;">
           
        <div class="form-block-5">
            <fieldset class="small-fieldset-2">
                <legend class="small-legend">Type of Request</legend>
                <cfset software_is_checked="">
                <cfset hardware_is_checked="">
                <cfset network_is_checked="">
                <cfset other_is_checked="">
                <cfif #get_record.request_type# is "software"> 
                    <cfset software_is_checked = "checked">
                <cfelse>
                    <cfset software_is_checked = "">
                </cfif>
                <cfif #get_record.request_type# is "hardware"> 
                    <cfset hardware_is_checked = "checked">
                <cfelse>
                    <cfset hardware_is_checked = "">
                </cfif>
                <cfif #get_record.request_type# is "network"> 
                    <cfset network_is_checked = "checked">
                <cfelse>
                    <cfset network_is_checked = "">
                </cfif>                
                <cfif #get_record.request_type# is "other"> 
                    <cfset other_is_checked = "checked">
                <cfelse>
                    <cfset other_is_checked = "">
                </cfif>
                <label for="type_request_s" class="ff-label-radio">Software
                    <input data-itnss="request_type" type="radio" name="request_type" value="software" #software_is_checked#>
                </label>             
                <label for="type_request_h" class="ff-label-radio">Hardware
                    <input data-itnss="request_type" type="radio" name="request_type" value="hardware" #hardware_is_checked#>
                </label>             
                <label for="type_request_h" class="ff-label-radio">Network
                    <input data-itnss="request_type" type="radio" name="request_type" value="network" #network_is_checked#>
                </label>       
                <label for="type_request_h" class="ff-label-radio">Other
                    <input data-itnss="request_type" type="radio" name="request_type" value="other" #other_is_checked#>
                </label>                              
            </fieldset>     
        </div> 
                
        <div class="form-block-8">
            <fieldset class="small-fieldset-2">
                <legend class="small-legend">Classification</legend>
                <cfset classified_is_checked="">
                <cfset unclassified_is_checked="">
                <cfif #get_record.classification# is "unclassified">
                <cfset classified_is_checked = "checked">
                <cfelse>
                <cfset classified_is_checked = "">
                </cfif>
                <cfif #get_record.classification# is "classified">
                <cfset unclassified_is_checked = "checked">
                <cfelse>
                <cfset unclassified_is_checked = "">
                </cfif>
                <label for="classification" class="ff-label-radio">Classified
                    <input data-itnss="classification" type="radio" name="classification" value="classified" #classified_is_checked#>
                </label>
                <label for="classification" class="ff-label-radio">Unclassified
                    <input data-itnss="classification" type="radio" name="classification" value="unclassified" #unclassified_is_checked#>
                </label>
            </fieldset> 
        </div>
                
        <div class="form-block-9">
            <fieldset class="small-fieldset-fb9">
            <!--- TODO: create CF loop here to check the boxes as defined in the database --->

                <cfquery name="get_network_type" datasource="#APPLICATION.asd#">
                    SELECT n.itnss_requirement_id, n.itnss_network_type_id
                        , t.itnss_network_type_id, t.network_type_name AS network_name
                        , r.itnss_requirement_id
                    FROM itnss_network_type_link n
                    LEFT OUTER JOIN itnss_network_type t ON n.itnss_network_type_id = t.itnss_network_type_id
                    LEFT OUTER JOIN itnss_requirement r ON n.itnss_requirement_id = r.itnss_requirement_id
                    WHERE r.itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_int" value="#URL.requestID#">
                    ORDER BY n.itnss_requirement_id
                </cfquery>
                <cfset array_network_type = ArrayNew(1)>

                <cfloop query="get_network_type">
                    <cfset ArrayAppend(array_network_type, get_network_type.network_name)>                        
                </cfloop>
            
                <cfif ArrayContains(array_network_type, "NIPRnet")>
                    <cfset nipr_is_checked = "checked">
                <cfelse>
                    <cfset nipr_is_checked = "">
                </cfif>
                <cfif ArrayContains(array_network_type, "SIPRnet")>
                    <cfset sipr_is_checked = "checked">
                <cfelse>
                    <cfset sipr_is_checked = "">
                </cfif>
                <cfif ArrayContains(array_network_type, "DREN")>
                    <cfset dren_is_checked = "checked">
                <cfelse>
                    <cfset dren_is_checked = "">
                </cfif>
                <cfif ArrayContains(array_network_type, "RQ Enclave")>
                    <cfset rq_enclave_is_checked = "checked">
                <cfelse>
                    <cfset rq_enclave_is_checked = "">
                </cfif>
                <cfif ArrayContains(array_network_type, "ENCLAVE")>
                    <cfset enclave_is_checked = "checked">
                <cfelse>
                    <cfset enclave_is_checked = "">
                </cfif>
                <cfif ArrayContains(array_network_type, "Standalone")>
                    <cfset standalone_is_checked = "checked">
                <cfelse>
                    <cfset standalone_is_checked = "">
                </cfif>

                <legend class="small-legend">Associated Network</legend>
                <input id="label_serialized" data-itnss="serialize_network_list" type="hidden">
                
                <br />
                
                <label for="fk_network_type_id" class="ff-label-radio">NIPR
                    <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="1" #nipr_is_checked#>
                </label>                      
                <label for="fk_network_type_id" class="ff-label-radio">DREN
                    <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="3" #dren_is_checked#>
                </label>
                <label for="fk_network_type_id" class="ff-label-radio">SIPR
                    <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="2" #sipr_is_checked#>
                </label>                     
                <label for="fk_network_type_id" class="ff-label-radio">Enclave
                    <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="5" #enclave_is_checked#>
                </label>
                <label for="fk_network_type_id" class="ff-label-radio">RQ Enclave
                    <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="7" #rq_enclave_is_checked#>
                </label>                        
                <label for="fk_network_type_id" class="ff-label-radio">Standalone
                    <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="6" #standalone_is_checked#>
                </label>
            </fieldset> 
        </div>
            
        <div class="form-block-10">        
        <fieldset class="small-fieldset">
			<cfset is_checked="false">
            <cfif #get_record.is_funded# is 1>
                <cfset is_checked = "true">
            <cfelse>
                <cfset is_checked = "false">
            </cfif>
        	
            <legend class="small-legend">Funding</legend>
        
            <div class="raa-block-1">
            <label for="is_funded" class="ff-label-radio">Yes
                <input data-itnss="is_funded" type="radio" name="is_funded" value="1" checked="#is_checked#">
            </label>
            
            <label for="is_funded" class="ff-label-radio">No
                <input data-itnss="is_funded" type="radio" name="is_funded" value="0" checked="#is_checked#">
            </label>
            </div>
            
        </fieldset>   
        </div>
            
            
		<br style="clear: both">
		
        <!--- DESCRIPTION --->
    	<div class="fb-6-container">                        
            <div class="form-field">
            <label for="itnss_description" class="ff-label">Requirement
                <textarea data-itnss="itnss_description" name="itnss_description" type="text" class="form-field-input">#get_record.itnss_description#</textarea>
            </label>
            </div>     
            
            <div class="form-field">
            <label for="itnss_description_staff_cacedipi" class="ff-label">Requirement assistance provided by 
                <select data-itnss="itnss_description_staff_cacedipi" name="itnss_description_staff_cacedipi">
                    <option value="">Select AFRL/RQOC Personnel</option>
                    <cfloop query = "getRQOC"> 
                        <option value="#getRQOC.cac_edipi#" <cfif getRQOC.cac_edipi EQ get_record.itnss_description_staff_cacedipi>selected</cfif>>
                        #getRQOC.fullname#</option> 
                    </cfloop>
                </select>
            </label>
           </div>    
		</div>
		
        <!--- JUSTIFICATION --->	  
        <div class="fb-6-container">              
             <div class="form-field">
                <label for="itnss_justification" class="ff-label">Justification
                    <textarea data-itnss="itnss_justification" type="text" name="itnss_justification" class="form-field-input">#get_record.itnss_justification#</textarea>
                </label>
             </div>
            
             <div class="form-field">
                <label for="itnss_justification_staff_cacedipi" class="ff-label">Justification assistance provided by 
                <select data-itnss="itnss_justification_staff_cacedipi" name="itnss_justification_staff_cacedipi">
                <option value="">Select AFRL/RQOC Personnel</option>
                <cfloop query = "getRQOC"> 
                <option value="#getRQOC.cac_edipi#" <cfif getRQOC.cac_edipi EQ get_record.itnss_justification_staff_cacedipi>selected</cfif>>#getRQOC.fullname#</option> 
                </cfloop>
                </select>
                </label>
             </div>       
        </div>
        
        <!--- SOLUTION --->
        <div class="fb-6-container">         
            <div class="form-field">
                <label for="itnss_solution" class="ff-label">Technical Solution
                    <textarea data-itnss="itnss_solution" type="text" name="itnss_solution" class="form-field-input">#get_record.itnss_solution#</textarea>
                </label>
            </div>
            
            <div class="form-field">
                <label for="itnss_solution_staff_cacedipi" class="ff-label">Technical Solution assistance provided by 
                    <select data-itnss="itnss_solution_staff_cacedipi" name="itnss_solution_staff_cacedipi">
                        <option value="">Select AFRL/RQOC Personnel</option>
                        <cfloop query = "getRQOC"> 
                            <option value="#getRQOC.cac_edipi#" <cfif getRQOC.cac_edipi EQ get_record.itnss_solution_staff_cacedipi>selected</cfif>>#getRQOC.fullname#</option> 
                        </cfloop>
                    </select>
                </label>
            </div>   
        </div>

        <div class="fb-6-container">
            <div class="form-field">
                <label for="notes_cso_cto_iao" class="ff-label">CSO/CTO/IAO Required notes for processing (RQOC Only)
                    <textarea data-itnss="notes_cso_cto_iao" type="text" name="notes_cso_cto_iao" class="form-field-input">#get_record.notes_cso_cto_iao#</textarea>
                </label>
            </div>
        </div>
		
        
        <!--- ATTACHMENTS --->
        <!---Get Attachments Info--->
		<cfset ATTACHMENTS=createObject("component","attachments")>
        <cfset get_attachments=ATTACHMENTS.query_attachments(url.requestID)>
        <div id="attachments_container" data-itnss="attachments_container">
            <div style="margin:25px 12px;" id="div_attachments">
                <input id="hidden_itnssid" type="hidden" value="#URL.requestID#"/>
                <div class="app_mod_header"><label class="ff-label">ATTACHMENTS<span style="margin-left:10px;font-size:10px;color:rgba(170,170,170,1.00);font-weight:400;" data-itnss="attachments_drop_label">Drop files here to upload</span></label></div>
                
                <table cellpadding="0" cellspacing="5" style="width:100%; border:1px solid ##EEE;">
                    <thead>
                        <tr style="background-color:##ACD0EF; font-weight:bold; color:##444; ">
                            <td style="padding:5px;">NAME</td>
                            <td style="padding:5px;width:150px;">SIZE</td>
                            <td style="padding:5px;width:150px;">MODIFIED</td>
                            <td style="padding:5px;width:150px;">BY</td>
                        </tr>
                    </thead>
                    
                    <!---
                    For CSS :empty:after rule to function (which places the text "No Files Uploaded" into the table if there are no table rows e.g. no uploaded files), it is imperative that NO whitespaces/linebreaks are used within table body
                    --->
                    
                    <tbody><cfloop query="get_attachments"><tr><td><a href="attachments.cfc?method=download_attachment&attachment_id=#id#">#name#</a></td><td>#size#</td><td>#mod_date#</td><td>#mod_user#</td></tr></cfloop></tbody>
                </table>
            </div>
        </div>	
            
		<!---ACQUISITION --->
        <fieldset class="small-fieldset">
        <legend class="small-legend">Acquisition</legend>
        
        <div class="form-block-acq">
        <label for="acq_purchase_vehicle" class="ff-label">Purchase Vehicle (Form 9, GPC, etc...)
            <input data-itnss="acq_purchase_vehicle" name="acq_purchase_vehicle" class="ff-input-acq" type="text" value="#get_record.acq_purchase_vehicle#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_gpc_log_cross_reference" class="ff-label">GPC Log Cross Reference
            <input data-itnss="acq_gpc_log_cross_reference" name="acq_gpc_log_cross_reference" type="text" class="ff-input-acq" value="#get_record.acq_gpc_log_cross_reference#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_funding_source" class="ff-label">Funding Source
            <input data-itnss="acq_funding_source" name="acq_funding_source" type="text" class="ff-input-acq" value="#get_record.acq_funding_source#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_fund_cite" class="ff-label">Fund Cite
            <input data-itnss="acq_fund_cite" name="acq_fund_cite" type="text" class="ff-input-acq" value="#get_record.acq_fund_cite#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_afway_waiver_number" class="ff-label">AFWAY Waiver Number
            <input data-itnss="acq_afway_waiver_number" name="acq_afway_waiver_number" type="text" class="ff-input-acq" value="#get_record.acq_afway_waiver_number#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_afway_rfq_number" class="ff-label">AFWAY RFQ Number
            <input data-itnss="acq_afway_rfq_number" name="acq_afway_rfq_number" type="text" class="ff-input-acq" value="#get_record.acq_afway_rfq_number#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_afway_tracking_number" class="ff-label">AFWAY Tracking Number
            <input data-itnss="acq_afway_tracking_number" name="acq_afway_tracking_number" type="text" class="ff-input-acq" value="#get_record.acq_afway_tracking_number#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_afway_order_number" class="ff-label">AFWAY Order Number
            <input data-itnss="acq_afway_order_number" name="acq_afway_order_number" type="text" class="ff-input-acq" value="#get_record.acq_afway_order_number#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_vendor_awarded" class="ff-label">Vendor Awarded
            <input data-itnss="acq_vendor_awarded" name="acq_vendor_awarded" type="text" class="ff-input-acq" value="#get_record.acq_vendor_awarded#">
        </label>
        </div>
        
        <div class="form-block-acq">
        <label for="acq_date_ordered" class="ff-label">Date Ordered
            <input data-itnss="acq_date_ordered" name="acq_date_ordered" type="text" class="form-field-input ff-input-date"> 
        </label>
        </div>
        
        <span class="clear-float"></span>
        
        <div class="form-block-acq-comments">
        <label for="acq_comments" class="ff-label">Comments
            <textarea data-itnss="acq_comments" type="text" name="acq_comments" class="ff-input-acq">#get_record.acq_comments#</textarea>
        </label>
        </div>
        </fieldset>
                
        <div class="save-button" style="">


            <label data-itnss="status_label" style="font-size:12px;color:white;margin-top:12px;"></label>
            <div id="btn_submit_test" data-itnss="btn_submit_test" class="modern_button" style="width:100px;padding-left:15px;">
                <svg id="svg_cloud_icon_1" class="svg_cloud_icon" width="15" height="25" viewBox="13 0 60 75" 
                    version="1.1" xmlns="http://www.w3.org/2000/svg"
                    xmlns:xlink="http://www.w3.org/1999/xlink"
                    xmlns:ev="http://www.w3.org/2001/xml-events" >
                    <g id="svg_icon_container" xmlns="http://www.w3.org/2000/svg">
                        <ellipse id="cloud_icon_shadow" fill="rgb(222, 227, 231)" cx="43.3" cy="73.9" rx="37.6" ry="4.1"/>
                        <g id="svg_inner_container">
                            <path id="cloud_icon" fill="rgb(166, 182, 194)"
                            d="M69.4,21.5C66.9,9.2,56,0,43,0C32.6,0,23.7,5.8,19.2,14.4C8.4,15.5,0,24.6,0,35.6C0,47.5,9.6,57,21.5,57
                            h46.6C78,57,86,49,86,39.2C86,29.8,78.6,22.2,69.4,21.5z"/>
                            <polygon id="up_arrow_icon" fill="rgb(240, 242, 244)" 
                            points="50.2,32.1 50.2,46.3 35.8,46.3 35.8,32.1 25.1,32.1 43,14.3 60.9,32.1 "/>
                        </g>
                    </g>
                </svg>
                <span id="lbl_undo_image" style="border:0px solid red;margin-right:20px; float: right; display: block;">Save</span>
            </div>
             
            <cfset flag_inPage_edit_cf = "edit_OFF">
            <!---
            <div id="btn_edit_test" class="modern_button" data-itnss="btn_inPage_edit"><span data-itnss="span_flag_text">#flag_inPage_edit_cf#</span></div>
            <input type="hidden" data-itnss="h-input_flag_text" class="toggleEdit" value="#flag_inPage_edit_cf#">
            --->
        </div>
	</form>
	</div>

 </div>  

<br style="clear:both;">
</cfoutput>
            

<script>
    /* ::: Drop Zone Hover ::: */
    $(function() {
        Drop_Zone_Normal();
        function Prevent_Default(e){
            e.preventDefault(); e.stopPropagation(); 
            console.log('*_*_*EVENT: Prevent_Default(e) function called | e.type: ' + e.type+'\n_____');
        }
        function Drop_Zone_Hover(){
            $('[data-itnss="attachments_container"]').css('cursor','pointer');
            $('[data-itnss="attachments_container"]').removeClass('dz_container_normal');
            $('[data-itnss="attachments_container"]').addClass('dz_container_over');
            $('[data-itnss="attachments_drop_label"]').animate({'font-size':'14px'}, 500, function(){});
        }
        function Drop_Zone_Normal(){
            $('[data-itnss="attachments_container"]').addClass('dz_container_normal');
            $('[data-itnss="attachments_container"]').removeClass('dz_container_over');
            $('[data-itnss="attachments_drop_label"]').animate({'font-size':'12.33px'}, 500, function(){});
        }
        $('[data-itnss="attachments_container"]').on({
            'mouseenter':function(e){try{Prevent_Default(e);Drop_Zone_Hover();} catch(error_info){console.log('ERROR mouseenter\n'+e+'\n'+error_info);}},
            'mouseleave':function(e){try{Prevent_Default(e);Drop_Zone_Normal();}catch(error_info){console.log('ERROR mouseleave\n'+e+'\n'+error_info);}},
        });
        
    });
    /* ::: END Drop Zone Hover ::: */

	$(function() {                
        //Initialize tabs
        $("#ticket_tabs").tabs();
    });
	
    $(function(){        
        /*::: ::: Responsive Textarea ::: :::*/
        $('textarea[data-itnss^="itnss_"], [data-itnss="notes_cso_cto_iao"], [data-itnss="acq_comments"]').focus(function(){
            $(this).animate({"min-height":'200px', width:'100%'}, 500);
        });
        $('textarea[data-itnss^="itnss_"], [data-itnss="notes_cso_cto_iao"], [data-itnss="acq_comments"]').blur(function(){
            $(this).animate({"min-height":'50px', width:'100%'}, 500);
        });
        /*::: ::: END Responsive Textarea ::: :::*/
        
        /*::: ::: Attachment Upload ::: :::*/
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
        }//END addAttachmentRow(o)
        
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
            /*::: ::: END Attachment Upload ::: :::*/

            /*::: ::: Enable content edit ::: :::*/
            <cfoutput>var #toScript(flag_inPage_edit_cf, "flag_inPage_edit_js")#;</cfoutput>            
                        
            /*::: Loop through document, get list of all data-itnss attributes, push editable elements to an array */
            var array_do_not_disable = ['btn_inPage_edit', 'span_flag_text', 'h-input_flag_text', 'form_edit_record', 'record_id', 'form_row_adam'/*, 'btn_submit_test', 'status_label'*/];
            var array_allow_editable = [];
            function Get_Data_Attribute_List(){
            }//END Get_Data_Attribute_List()
            
            $("[data-itnss]").each(function(){//loop through all data-itnss attributes, if value in array, then do not disable
                var attribute_value = $(this).data('itnss');
                if(jQuery.inArray(attribute_value, array_do_not_disable) != -1){
                    //if is in the keep enebled list, then do nothing it here
                }else{
                    array_allow_editable.push(attribute_value); //if not in the keep enebled list, then disable it here
                }//END jQuery.inArray test
            });//END .each loop 

            /*::: Toggle editable fields on click event */
            $('[data-itnss="btn_inPage_edit"]').on('click', function(){
                Toggle_EditContent();
            });//END on click event

            /*::: Toggle function notifies user, sets editable flag, and sets a value to turn on/off edit feature */
            function Toggle_EditContent(){
                if( $('[data-itnss="h-input_flag_text"]').attr('value') == 'edit_OFF' ){
                    flag_inPage_edit_js = 'edit_ON';
                    $('[data-itnss="h-input_flag_text"]').attr('value','edit_ON');
                    $('[data-itnss="span_flag_text"]').text('edit_ON');
                    $.each(array_allow_editable, function(index, attribute_value){
                        $('[data-itnss="'+attribute_value+'"]').disable(true);
                    });
                    console.log('flag_inPage_edit_js: '+flag_inPage_edit_js + '\n___________');
                }else{
                    flag_inPage_edit_js = 'edit_OFF';
                    $('[data-itnss="h-input_flag_text"]').attr('value','edit_OFF');
                    $('[data-itnss="span_flag_text"]').text('edit_OFF');
                    $.each(array_allow_editable, function(index, attribute_value){
                        $('[data-itnss="'+attribute_value+'"]').disable(false);
                    });
                    console.log('flag_inPage_edit_js: '+flag_inPage_edit_js + '\n___________');
                }
            }//END Toggle_EditContent()
            
            /*::: this extend function will toggle disabled attribute on an element */
            $.fn.disable = function (isDisabled) {
                if (isDisabled){
                    this.attr('disabled', 'disabled');
                }else{
                    this.removeAttr('disabled');
                }
            };//END isDisabled()

        });//END DOM ready
        /*::: ::: END content edit ::: :::*/

    /*::: ::: AJAX & Magic Update the Database ::: :::*/
    $(function() {
        var update_record_id = <cfoutput>#record_id#</cfoutput>;
        var status_flag='';
        var do_submit=false;
        var info_required = '';
        var error_message='';
        $('[data-itnss="status_label"]').html('').css({'color':'white'});
/*        $('[data-itnss="poc"]').on('change', function(){
            var poc = $('[data-itnss="poc"]').val();
            console.log('Requestor CAC EDIPI: '+ poc);
            if (poc == '' | poc.length==0) {
                $('[data-itnss="btn_submit_test"]').css({'pointer-events':'none'});
                alert('A valid selection is required.');
                $('[data-itnss="poc"]').focus();
            }else{
                $('[data-itnss="btn_submit_test"]').css({'pointer-events':'auto'});
            }
                
        });
        $('[data-itnss="is_funded_authority"]').on('change', function(){
            var is_funded_authority = $('[data-itnss="is_funded_authority"]').val();
            console.log('Requestor CAC EDIPI: '+ is_funded_authority);
            if (is_funded_authority == '' | is_funded_authority.length==0) {
                $('[data-itnss="btn_submit_test"]').css({'pointer-events':'none'});
                alert('A valid selection is required.');
                $('[data-itnss="is_funded_authority"]').focus();
            }else{
                $('[data-itnss="btn_submit_test"]').css({'pointer-events':'auto'});
            }
                
        });*/
        
        // Initialize and set a jQuery UI datepicker
        $('[data-itnss="date_needed"]').datepicker();
        $('[data-itnss="date_needed"]').datepicker("option","dateFormat","mm/dd/yy");
        var db_date = '<cfoutput>#DateFormat(get_record.date_needed, "mm/dd/yyyy")#</cfoutput>';
        $('[data-itnss="date_needed"]').datepicker("setDate", db_date);
        
        $('[data-itnss="acq_date_ordered"]').datepicker();
        $('[data-itnss="acq_date_ordered"]').datepicker("option","dateFormat","mm/dd/yy");
        var db_date_acq = '<cfoutput>#DateFormat(get_record.acq_date_ordered, "mm/dd/yyyy")#</cfoutput>';
        $('[data-itnss="acq_date_ordered"]').datepicker("setDate", db_date_acq);


        function Manage_Empty_Fields(){
            $('[data-itnss="title"], [data-itnss="date_needed"], [data-itnss="poc"], [data-itnss="is_funded_authority"]').each(function() {
                if ($(this).val() == '' | $(this).val().length==0) {
                    $info_required=$(this).attr("data-itnss");
                    $(this).focus();
                    $(this).parent().effect('shake', {times: 3}, 800); //textarea[data-itnss^="itnss_"]
                    do_submit=false;
                    $('[data-itnss="btn_submit_test"]').css({'pointer-events':'none'});
                    console.log('in the 1st FALSE condition: '+ do_submit + ' :: ' + $info_required);
                    return false;
                }else{
                    do_submit=true;
                    $('[data-itnss="btn_submit_test"]').css({'pointer-events':'auto'});
                }
            });

            if(do_submit==false){
                Label_Fadein('[data-itnss="status_label"]');
                $('[data-itnss="status_label"]').css({'color':'rgb(119, 19, 30)'}).html('Missing Info: '+$info_required.toUpperCase());
                Label_Fadeout('[data-itnss="status_label"]');
            }else{console.log('in the TRUE condition: '+do_submit);
                do_submit=true;
            }
            return do_submit;
        }        
        
        $('[data-itnss="title"], [data-itnss="date_needed"], [data-itnss="poc"], [data-itnss="is_funded_authority"]').each(function() {                
            $(this).change(function(){
                do_submit = Manage_Empty_Fields();
            });//END this.change
        });


        // On-click event will submit the form (TODO: on any input change submit event)
        $('[data-itnss="btn_submit_test"]').on('click', function(){
            
            do_submit = Manage_Empty_Fields();
            
            if(do_submit==true){
                var ntl = [].filter.call(document.getElementsByName('fk_network_type_id'), function(c) {
                    return c.checked;
                }).map(function(c) {
                    return c.value;
                });
                //document.getElementById('label_serialized').innerText = ntl;//JSON.stringify(network_type_list);
                $('[data-itnss="serialize_network_list"]').attr('value', ntl);
                console.log('Get the serialize_network_list: '+String(ntl));
                
                var record_id          = $('[data-itnss="record_id"]').val();
                var title              = $('[data-itnss="title"]').val();
                var date_needed        = $('[data-itnss="date_needed"]').val(); 
                var created_by         = $('[data-itnss="poc"]').val(); 
                var lab_name           = $('[data-itnss="lab_name1"]').val();
                var request_type       = $('[data-itnss="request_type"]:checked').val(); 
                var classification     = $('[data-itnss="classification"]:checked').val(); 
                var fk_network_type_id = $('[data-itnss="fk_network_type_id"]:checked').val(); 
                var is_funded          = $('[data-itnss="is_funded"]:checked').val();            
                var is_funded_authority= $('[data-itnss="is_funded_authority"]').val();            
                var itnss_description_staff_cacedipi   = $('[data-itnss="itnss_description_staff_cacedipi"]').val();
                var itnss_description                  = $('[data-itnss="itnss_description"]').val();            
                var itnss_justification_staff_cacedipi = $('[data-itnss="itnss_justification_staff_cacedipi"]').val();
                var itnss_justification                = $('[data-itnss="itnss_justification"]').val();          
                var itnss_solution_staff_cacedipi      = $('[data-itnss="itnss_solution_staff_cacedipi"]').val();
                var itnss_solution                     = $('[data-itnss="itnss_solution"]').val();            
                var notes_cso_cto_iao                  = $('[data-itnss="notes_cso_cto_iao"]').val();
                var acq_purchase_vehicle        = $('[data-itnss="acq_purchase_vehicle"]').val();
                var acq_gpc_log_cross_reference = $('[data-itnss="acq_gpc_log_cross_reference"]').val();
                var acq_funding_source          = $('[data-itnss="acq_funding_source"]').val();
                var acq_fund_cite               = $('[data-itnss="acq_fund_cite"]').val();
                var acq_afway_waiver_number     = $('[data-itnss="acq_afway_waiver_number"]').val();
                var acq_afway_rfq_number        = $('[data-itnss="acq_afway_rfq_number"]').val();
                var acq_afway_tracking_number   = $('[data-itnss="acq_afway_tracking_number"]').val();
                var acq_afway_order_number      = $('[data-itnss="acq_afway_order_number"]').val();
                var acq_vendor_awarded          = $('[data-itnss="acq_vendor_awarded"]').val();
                var acq_date_ordered            = $('[data-itnss="acq_date_ordered"]').val();
                var acq_comments                = $('[data-itnss="acq_comments"]').val();
                var network_type_list           = String(ntl);
                
                var local_data = {record_id: record_id
                                , title: title
                                , date_needed: date_needed
                                , created_by: created_by
                                , lab_name: lab_name
                                , request_type: request_type
                                , classification: classification
                                , is_funded: is_funded
                                , is_funded_authority: is_funded_authority
                                , itnss_description_staff_cacedipi: itnss_description_staff_cacedipi
                                , itnss_description: itnss_description
                                , itnss_justification_staff_cacedipi: itnss_justification_staff_cacedipi
                                , itnss_justification: itnss_justification
                                , itnss_solution_staff_cacedipi: itnss_solution_staff_cacedipi
                                , itnss_solution: itnss_solution
                                , notes_cso_cto_iao: notes_cso_cto_iao
                                , acq_purchase_vehicle: acq_purchase_vehicle
                                , acq_gpc_log_cross_reference: acq_gpc_log_cross_reference
                                , acq_funding_source: acq_funding_source
                                , acq_fund_cite: acq_fund_cite
                                , acq_afway_waiver_number: acq_afway_waiver_number
                                , acq_afway_rfq_number: acq_afway_rfq_number
                                , acq_afway_tracking_number: acq_afway_tracking_number
                                , acq_afway_order_number: acq_afway_order_number
                                , acq_vendor_awarded: acq_vendor_awarded
                                , acq_date_ordered: acq_date_ordered
                                , acq_comments: acq_comments
                                , network_type_list: network_type_list
                };//END local_data object            
                db_Update_Record(local_data);
            }//END Check of Manage_Empty_Fields
        });//END on-click

        /* ::: AJAX Magic - thank you Jeff Rowe and Chris Scupski ::: */
        function db_Update_Record(local_data){
            console.log('Outgoing data request:\n'+JSON.stringify(local_data));
            Label_Fadein('[data-itnss="status_label"]');
            $('[data-itnss="status_label"]').css({'color':'rgb(19, 29, 119)'}).html('Please wait... Processing Record ID: ' + update_record_id);
            Label_Fadeout('[data-itnss="status_label"]');
            
            var dbRequest = $.ajax({
                  url: "submit.cfc?method=update_record&returnformat=json"
                , type: "POST"
                , data: local_data
                , dataType: "html"
            });
            
            dbRequest.success(function(response){
                if(response.status == 200){
                    db_Received_Success('Server Response: 200');
                }
            });
            
            dbRequest.done(function(response){
                var myMsg = response.replace(/\//g,'');
                
                if (myMsg.charAt(0) != '{'){// if the first char is not a '{', it's not JSON so do something with it
                    error_message = 'ERROR. Failed to update record ID: '+update_record_id +'\n'+ 'Malformed Server Response: missing a begining curly bracket: {' +'\n'+ myMsg.substring(1500);
                    db_Received_Error(error_message);
                }else{
                    var myJ = JSON.parse(myMsg);
                    if(myJ.ERROR){
                        db_Received_Error(myJ.ERROR);
                    }else{
                        db_Received_Success(myJ.MESSAGE);
                    }
                }
            });
                
            dbRequest.fail(function(jqXHR, textStatus, errorThrown) {
                error_message = textStatus + '  '+errorThrown;
                db_Received_Error(error_message);
            });

        }//END db_Update_Record
        function db_Received_Error(message){
            Label_Fadein('[data-itnss="status_label"]');
            //$('[data-itnss="status_label"]').css({'color':'color:rgba(255,42,42,1.00)'});
            $('[data-itnss="status_label"]').css({'color':'rgb(119, 19, 30)'}).html('ERROR. Failed to update record ID: ' + update_record_id);
            console.log('ERROR. Failed to update record ID: ' + update_record_id + '\n' + message);
            Label_Fadeout('[data-itnss="status_label"]');
        }
        function db_Received_Success(myJ){
            Label_Fadein('[data-itnss="status_label"]');
            //$('[data-itnss="status_label"]').css({'color':'rgba(26,240,150,1.00)'});
            $('[data-itnss="status_label"]').css({'color':'rgb(19, 119, 37)'}).html('Success! Updated Record ID: ' + update_record_id);
            console.log('SUCCESS. Updated record ID: ' + update_record_id + '\n' + myJ);
            Label_Fadeout('[data-itnss="status_label"]');
        }
        
        function Display_Message(){//TODO: finish this function 
            var message = arguments[0] || 'No message text';
            var arg_options = arguments[1] || 'false';
            var lbl_red = {'color':'color:rgba(255,42,42,1.00)'};//corral or salmon
            var lbl_green =  {'color':'color:rgba(26,240,150,1.00)'};//pastel green
            var lbl_blue =  {'color':'color:rgba(26,86,239,1.00)'};//pastel green            
        }
        
        function Label_Fadeout(a_label){
            setTimeout(function() {
                $(a_label).fadeOut(1600, "linear", Label_Fadeout);
                $(a_label).val('');
            }, 2000 );
        }
        function Label_Fadein(a_label){
            setTimeout(function() {
                $(a_label).fadeIn(60, "linear", Label_Fadeout);
                $(a_label).val('');
            }, 60 );
        }
        /* ::: END AJAX magic ::: */
        
        /* ::: Get selected checkboxs ::: */
        $('[data-itnss="btn_serialize_test"]').on('click', function(){        
            var network_type_list = [].filter.call(document.getElementsByName('fk_network_type_id'), function(c) {
                return c.checked;
            }).map(function(c) {
                return c.value;
            });
            document.getElementById('label_serialized').innerText = network_type_list;//JSON.stringify(network_type_list);
        });
        /* ::: END Get selected checkboxs ::: */
        
    });
    /*::: ::: END AJAX & Magic Update the Database ::: :::*/
    

</script>        
	


