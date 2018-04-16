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
    <cfset network_type_id = "#get_record.fk_network_type_id#">
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
    <cfset attachments     = "#get_record.attachments#">
    <cfset itnss_status    = "#get_record.itnss_status#">
    <cfset tracking_number = "#get_record.tracking_number#">


<cfif IsDefined("get_record.lab_name") AND LEN(get_record.lab_name)>
    <cfquery name="get_itnss_lab_1" datasource="#APPLICATION.asd#">
        SELECT i.itnss_requirement_id, i.lab_id, 
               r.itnss_requirement_id, r.lab_name as r_labName,
               v.lab_id as v_labId, v.lab_abbr, v.lab_name as v_labName, v.lab_desc, v.lab_location, v.active
        FROM   itnss_labs i, itnss_requirement r, labs_valid v
        WHERE  r.itnss_requirement_id = #URL.requestID#
        AND    i.itnss_requirement_id = r.itnss_requirement_id
        AND    i.lab_id = r.lab_name
        AND    i.lab_id = v.lab_id
        AND    r.lab_name = v.lab_id
    </cfquery>
<cfelse>
    <cfset #get_itnss_lab_1.v_labId# = "">
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


<style>
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
#navmenu{list-style:none;margin-right:25px;padding:10px;}
#navmenu li{cursor:pointer;padding:10px;}
#navmenu li:hover{background-color:#C1EBFF;}	
</style>

<!--- FORM STYLES --->
<style>
.form-field-input{display:block;}
.ff-input-date{width: 110px !important;}
.form-block-1{display:inline-block;}
.form-block-2{display:inline-block;}
.form-block-4{display:inline-block;width:30%;}
.form-block-5{width:50%;float:left;padding:10px 20px 10px 0px;text-align:center;}
.form-block-8{width:50%;float:left;padding:10px 0px 10px 20px;text-align:center;}
.form-block-9{float:left;text-align:center;width:50%;padding:10px 20px 10px 0px;}
.form-block-10{text-align:center;width:50%;float:left;padding:10px 0px 10px 20px;}
.fb-6-container{border:4px solid #ccc;background-color:#eee;padding:20px;margin:10px;padding:10px;}
.form-field, .form-block-1, .form-block-2, .form-block-3, .form-block-4{padding:10px;}
.main-fieldset{padding:10px;margin:10px;}
.main-legend{font-weight:bold;font-size:18px;padding:10px;}
.small-fieldset-2{padding:10px;margin:10px;height:100px;background-color:#F3F3F3;border:4px solid #ccc;}
.small-fieldset-fb9{padding:10px;margin:10px;height:143px;background-color:#F3F3F3;border:4px solid #ccc;}
.small-fieldset{padding:10px;margin:10px;background-color:#F3F3F3;border:4px solid #ccc;}
.small-legend{padding:0px -5px 0px 0px;text-align:left;font-weight:bold;font-size:14px;padding:10px;}
.ff-label{display:block;padding:5px;}
.ff-label-radio{font-weight:normal;font-size:14px;padding:15px;}
.raa-block-1{float:left;padding:30px;margin-right:30px;}
.raa-block-2{float:left;}
.raa-label{display:block;}
textarea{min-height:300px;min-width:600px;padding:10px;width:100%;}
input[type=text], select{width:300px;padding:10px;}
input[type=date]{width:150px;}
input[type=date]{font-size:14px;padding:8px;}
input[type=submit]{float:right;font-size:18px;font-weight:bold;margin:10px;padding:10px 50px;}
input[type=submit]:hover{cursor:pointer;border:2px solid #666;}
[data-itnss="created_by"]{border:1px solid grey;font-size:12px;padding:4px;height:37px;min-width:250px;}
[data-itnss="created_by"]::-webkit-calendar-picker-indicator{display:none;}
[data-itnss="created_by"]{//margin-top:-10px;}
.modern_button{min-height:35px;min-width:200px;color:#F2F5FC;text-align:center;padding-top:5px;text-decoration:none;background-color:#00308F;transition:background-color 0.5s ease, border 0.5s ease;border:0px solid #BDCEEF;}
.modern_button:hover{background-color:#0049D1;border:0px solid #D7E3F8;color:#ffffff;cursor:pointer;}
.small_btn{min-width:50px;padding:4px 4px;}
</style>

<cfoutput>


<div style="margin:25px 0px;min-height:50px;padding:2px 2px;display:flex;flex-direction:row;flex-wrap:wrap;">
	<!--- Left Column --->
	<div style="width:250px;">
    	<ul id="navmenu">
        	<li><a href="new_request.cfm">Generate New ITNSS</a></li>
            <li>My Submissions<a href="list_user_records.cfm"></a></li>
            <li><a href="list.cfm">View All Submissions</a></li>
            <li>Advanced Search</li>
        </ul>

<!---        <div id="" style="border:1px solid red;height:50px;padding:2px 2px;display:flex;flex-flow:row nowrap;justify-content:center;align-items:center;">
            <div id="btn_submit_test_0" data-itnss="btn_submit_test_0" class="modern_button small_btn" style="margin:0 4px 0 0;"><span id="lbl_undo_image_0">Save</span></div>
            <label data-itnss="status_label_0" style="font-size:12px;color:white;"></label> 
            <cfset flag_inPage_edit_cf_0 = "edit_OFF">
            <div id="btn_edit_test_0" class="modern_button small_btn" data-itnss="btn_inPage_edit_0" style="margin:0 0 0 4px;"><span data-itnss="span_flag_text_0">#flag_inPage_edit_cf_0#</span></div>
            <input type="hidden" data-itnss="h-input_flag_text_0" class="toggleEdit" value="#flag_inPage_edit_cf_0#">
        </div>--->
	</div>
	
    <div id="ticket_tabs" style="float:left; max-width:1350px; width:100%; min-height:700px;">   
        <ul>
          <li><a href="##itnss_tab">IT Requirements (3215/CSRD)</a></li>
        </ul>

    <form id="form_edit_record" data-itnss="form_edit_record" method="post"> 
        <input data-itnss="record_id" type="hidden" name="record_id" class="form-field-input" value="#record_id#">
        <div class="form-block-1">
            <label for="title" class="ff-label">Requirement Title
            <input data-itnss="title" type="text" name="title" class="form-field-input" value="#title#" style="width:600px; display:block;">
            </label>
        </div>        
        <div class="form-block-1">
            <label for="date_needed" class="ff-label">Date Needed
            <input data-itnss="date_needed" type="text" name="date_needed" class="form-field-input ff-input-date"> 
			<!--- why is this one showing up mm-dd-yyyy instead of mm/dd/yyy--->
			<!--- changed type="date" to type="text" since date picker wasn't working properly - jms 4/12/2018--->
            </label>
        </div>
        
<br style="clear:both;">
        
        <div class="form-block-2">
            <label for="created_by" class="ff-label">Point of Contact
            <select data-itnss="created_by" id="created_by" name="created_by" class="form-field-input">
                <option value="#get_record.created_by#">#cb_name# | #cb_symbol# </option>
                <cfloop query = "get_user_list"> 
                    <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol# </option> 
                </cfloop>
            </select>
            </label>
        </div>
        
<br style="clear:both;">
        <div class="form-block-4">
            <label for="lab_name1" class="ff-label">Lab Name: #get_itnss_lab_1.v_labName#
                <select data-itnss="lab_name1" name="lab_name1">
                    <option value="#get_itnss_lab_1.v_labId#">#get_itnss_lab_1.v_labName#</option>
                    <cfloop query = "get_valid_labs"> 
                        <option value="#get_valid_labs.lab_id#">#get_valid_labs.lab_name#</option> 
                    </cfloop>
                </select>
            </label>
        </div>

        <div class="form-block-4"></div>
        <div class="form-block-4"></div>
           
        <div class="form-block-5">
            <fieldset class="small-fieldset-2">
                <legend class="small-legend">Type of Request</legend>
                <cfset software_is_checked="">
                <cfset hardware_is_checked="">
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
                <cfif #get_record.request_type# is "other"> 
                    <cfset other_is_checked = "checked">
                <cfelse>
                    <cfset other_is_checked = "">
                </cfif>
                <label for="type_request_s" class="ff-label-radio">Software:
                    <input data-itnss="request_type" type="radio" name="request_type" value="software" #software_is_checked#>
                </label>             
                <label for="type_request_h" class="ff-label-radio">Hardware:
                    <input data-itnss="request_type" type="radio" name="request_type" value="hardware" #hardware_is_checked#>
                </label>             
                <label for="type_request_h" class="ff-label-radio">Other:
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
                <label for="classification" class="ff-label-radio">Classified: #get_record.classification#
                    <input data-itnss="classification" type="radio" name="classification" value="classified" #classified_is_checked#>
                </label>
                <label for="classification" class="ff-label-radio">Unclassified: #get_record.classification#
                    <input data-itnss="classification" type="radio" name="classification" value="unclassified" #unclassified_is_checked#>
                </label>
            </fieldset> 
        </div>
                
                <div class="form-block-9">
                    <fieldset class="small-fieldset-fb9">
                        <cfif #get_record.fk_network_type_id# is 1>
                            <cfset nipr_is_checked = "checked">
                        <cfelse>
                            <cfset nipr_is_checked = "">
                        </cfif>
                        <cfif #get_record.fk_network_type_id# is 2>
                            <cfset sipr_is_checked = "checked">
                        <cfelse>
                            <cfset sipr_is_checked = "">
                        </cfif>
                        <cfif #get_record.fk_network_type_id# is 3>
                            <cfset dren_is_checked = "checked">
                        <cfelse>
                            <cfset dren_is_checked = "">
                        </cfif>
                        <cfif #get_record.fk_network_type_id# is 5>
                            <cfset enclave_is_checked = "checked">
                        <cfelse>
                            <cfset enclave_is_checked = "">
                        </cfif>
                        <cfif #get_record.fk_network_type_id# is 6>
                            <cfset standalone_is_checked = "checked">
                        <cfelse>
                            <cfset standalone_is_checked = "">
                        </cfif>
                        <legend class="small-legend">Associated Network</legend>
                        
                        <br />
                        
                        <label for="fk_network_type_id" class="ff-label-radio">SIPR
                            <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="2" #sipr_is_checked#>
                        </label>
                        <label for="fk_network_type_id" class="ff-label-radio">NIPR
                            <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="1" #nipr_is_checked#>
                        </label>
                        <label for="fk_network_type_id" class="ff-label-radio">DREN
                            <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="3" #dren_is_checked#>
                        </label>
                        <label for="fk_network_type_id" class="ff-label-radio">Enclave
                            <input data-itnss="fk_network_type_id" type="checkbox" name="fk_network_type_id" value="5" #enclave_is_checked#>
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
                        
                  <div class="raa-block-2">
                        <label for="is_funded_authority" class="raa-label">Org Approval Authority
                            <select data-itnss="is_funded_authority" name="is_funded_authority" class="form-field-input">
                                <option value="#get_record.is_funded_authority#">
                                #get_is_funded_authority.gal_displayname#
                                </option>
                                <cfloop query = "get_user_list"> 
                                    <option value="#get_user_list.cac_edipi#">
                                    #get_user_list.gal_displayname#
                                    </option> 
                                </cfloop>
                            </select>
                    </label>
                   </div>
                        
                  </fieldset>   
                </div>
            
            
		<br style="clear: both">

    
    	<div class="fb-6-container">
                        
            <div class="form-field">
                <label for="itnss_description" class="ff-label">Requirement
                    <textarea data-itnss="itnss_description" name="itnss_description" type="text" rows="6" cols="100"  class="form-field-input">#get_record.itnss_description#</textarea>
                </label>
            </div>     
            
            <div class="form-field">
            <label for="itnss_description_staff_cacedipi" class="ff-label">Requirement assistance provided by 
                <select data-itnss="itnss_description_staff_cacedipi" name="itnss_description_staff_cacedipi">
                    <option value="#get_record.itnss_description_staff_cacedipi#">#get_description_staff.last_name# | #get_description_staff.symbol#</option>
                    <cfloop query = "get_user_list"> 
                        <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol#</option> 
                    </cfloop>
                </select>
            </label>
           </div>    
    </div>
	  
    <div class="fb-6-container">
              
         <div class="form-field">
            <label for="itnss_justification" class="ff-label">Justification
                <textarea data-itnss="itnss_justification" type="text" rows="6" cols="100" name="itnss_justification" class="form-field-input">#get_record.itnss_justification#</textarea>
            </label>
         </div>
        
         <div class="form-field">
            <label for="itnss_justification_staff_cacedipi" class="ff-label">Justification assistance provided by 
            <select data-itnss="itnss_justification_staff_cacedipi" name="itnss_justification_staff_cacedipi">
            <option value="#get_record.itnss_justification_staff_cacedipi#">#get_justification_staff.last_name# | #get_justification_staff.symbol#</option>
            <cfloop query = "get_user_list"> 
            <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol#</option> 
            </cfloop>
            </select>
            </label>
         </div>       
    </div>
        
   
	
    <div class="fb-6-container">
                
        <div class="form-field">
            <label for="itnss_solution" class="ff-label">Technical Solution
                <textarea data-itnss="itnss_solution" type="text" rows="6" cols="100" name="itnss_solution" class="form-field-input">#get_record.itnss_solution#</textarea>
            </label>
        </div>
        
        <div class="form-field">
            <label for="itnss_solution_staff_cacedipi" class="ff-label">Technical Solution assistance provided by 
                <select data-itnss="itnss_solution_staff_cacedipi" name="itnss_solution_staff_cacedipi">
                    <option value="#get_record.itnss_solution_staff_cacedipi#">#get_solution_staff.last_name# | #get_solution_staff.symbol#</option>
                    <cfloop query = "get_user_list"> 
                        <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol#</option> 
                    </cfloop>
                </select>
            </label>
        </div>       
        
    </div>


	
    <div class="fb-6-container">
            <div class="form-field">
                <label for="notes_cso_cto_iao" class="ff-label">CSO/CTO/IAO Required notes for processing (RQOC Only)
                    <textarea data-itnss="notes_cso_cto_iao" type="text" rows="6" cols="100" name="notes_cso_cto_iao" class="form-field-input">#get_record.notes_cso_cto_iao#</textarea>
                </label>
            </div>
            
    </div>
			
            
            <!---ACQUISITION --->
            <div id="form_row_adam" data-itnss="form_row_adam" class="" style="display:flex;justify-content:space-between;background-color:rgba(227,179,147,0.74);border:1px solid rgba(216,225,244,1.00);width:100%;min-height:150px;clear:both;margin:2px 2px;padding:2px 2px;">
        
    <fieldset class="main-fieldset">
            <legend class="main-legend">ACQ</legend>
            
            <div class="form-block-1">
                <label for="acq_purchase_vehicle" class="ff-label">Purchase Vehicle (Form 9, GPC, etc...)
                    <input data-itnss="acq_purchase_vehicle" name="acq_purchase_vehicle" class="form-field-input" type="text" value="#get_record.acq_purchase_vehicle#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_gpc_log_cross_reference" class="ff-label">GPC Log Cross Reference
                    <input data-itnss="acq_gpc_log_cross_reference" name="acq_gpc_log_cross_reference" type="text" class="form-field-input" value="#get_record.acq_gpc_log_cross_reference#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_funding_source" class="ff-label">Funding Source
                    <input data-itnss="acq_funding_source" name="acq_funding_source" type="text" class="form-field-input" value="#get_record.acq_funding_source#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_fund_cite" class="ff-label">Fund Cite
                    <input data-itnss="acq_fund_cite" name="acq_fund_cite" type="text" class="form-field-input" value="#get_record.acq_fund_cite#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_afway_waiver_number" class="ff-label">AFWAY Waiver Number
                    <input data-itnss="acq_afway_waiver_number" name="acq_afway_waiver_number" type="text" class="form-field-input" value="#get_record.acq_afway_waiver_number#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_afway_rfq_number" class="ff-label">AFWAY RFQ Number
                    <input data-itnss="acq_afway_rfq_number" name="acq_afway_rfq_number" type="text" class="form-field-input" value="#get_record.acq_afway_rfq_number#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_afway_tracking_number" class="ff-label">AFWAY Tracking Number
                    <input data-itnss="acq_afway_tracking_number" name="acq_afway_tracking_number" type="text" class="form-field-input" value="#get_record.acq_afway_tracking_number#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_afway_order_number" class="ff-label">AFWAY Order Number
                    <input data-itnss="acq_afway_order_number" name="acq_afway_order_number" type="text" class="form-field-input" value="#get_record.acq_afway_order_number#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_vendor_awarded" class="ff-label">Vendor Awarded
                    <input data-itnss="acq_vendor_awarded" name="acq_vendor_awarded" type="text" class="form-field-input" value="#get_record.acq_vendor_awarded#">
                </label>
            </div>
            
            <div class="form-block-1">
                <label for="acq_date_ordered" class="ff-label">Date Ordered
                    <input data-itnss="acq_date_ordered" name="acq_date_ordered" type="date" class="form-field-input" value="#get_record.acq_date_ordered#">
                </label>
            </div>
      <div class="form-block-1">
                <label for="acq_comments" class="ff-label">Comments
                    <textarea data-itnss="acq_comments" type="text" rows="6" cols="100" name="acq_comments" class="form-field-input">#get_record.acq_comments#</textarea>
                </label>
        </div>
        <div id="" style="border:0px solid red;height:50px;padding:2px 2px;display:flex;flex-flow:row nowrap;justify-content:flex-start;align-items:center;">
            <div id="btn_submit_test" data-itnss="btn_submit_test" class="modern_button" style="margin-right:10px;">
                <span id="lbl_undo_image">Save</span>
            </div>
            <label data-itnss="status_label" style="font-size:12px;color:white;"></label>
             
            <cfset flag_inPage_edit_cf = "edit_OFF">
            <!---<div id="btn_edit_test" class="modern_button" data-itnss="btn_inPage_edit"><span data-itnss="span_flag_text">#flag_inPage_edit_cf#</span></div>
            <input type="hidden" data-itnss="h-input_flag_text" class="toggleEdit" value="#flag_inPage_edit_cf#">--->
        </div>
    </fieldset>  
     </div>
    <!---END form_row_adam --->  
	</form>
	</div>

 </div>
  
     


<br style="clear:both;">


</cfoutput>
            
<!--- Toggle Edit --->
    <script>
        /*::: ::: Enable content edit ::: :::*/
        $(function(){
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
    </script>
<!--- END Toggle Edit --->
<script>
    $( function() {
        var update_record_id = <cfoutput>#record_id#</cfoutput>;
        var status_flag='';
        var error_message='';
        $('[data-itnss="status_label"]').html('').css({'color':'white'});
        $('[data-itnss="created_by"]').on('change', function(){
            var created_by = $('[data-itnss="created_by"]').val();
            console.log('Requestor CAC EDIPI: '+created_by);
        });
        
        // Initialize and set a jQuery UI datepicker
        $('[data-itnss="date_needed"]').datepicker();
        $('[data-itnss="date_needed"]').datepicker("option","dateFormat","mm/dd/yy");
        var db_date = '<cfoutput>#DateFormat(get_record.date_needed, "mm/dd/yyyy")#</cfoutput>';
        $('[data-itnss="date_needed"]').datepicker("setDate", db_date);
        
        $('[data-itnss="acq_date_ordered"]').datepicker();
        $('[data-itnss="acq_date_ordered"]').datepicker("option","dateFormat","mm/dd/yy"); <!--- fixed date format from line 214 --->
        var db_date_acq = '<cfoutput>#DateFormat(get_record.acq_date_ordered, "mm/dd/yyyy")#</cfoutput>';
        $('[data-itnss="acq_date_ordered"]').datepicker("setDate", db_date_acq);
                
        // On-click event will submit the form (TODO: on any input change submit event)
        $('[data-itnss="btn_submit_test"]').on('click', function(){        
            //$('[data-itnss="form_edit_record"]').submit();
            var record_id          = $('[data-itnss="record_id"]').val();
            var title              = $('[data-itnss="title"]').val();
            var date_needed        = $('[data-itnss="date_needed"]').val(); 
            var created_by         = $('[data-itnss="created_by"]').val(); 
            var request_type       = $('[data-itnss="request_type"]:checked').val(); 
            var classification     = $('[data-itnss="classification"]:checked').val(); 
            var fk_network_type_id = $('[data-itnss="fk_network_type_id"]:checked').val(); 
            var is_funded          = $('[data-itnss="is_funded"]:checked').val();            
            var is_funded_authority                = $('[data-itnss="is_funded_authority"]').val();            
            //var itnss_description_help             = $('[data-itnss="itnss_description_help"]:checked').val();
            var itnss_description_staff_cacedipi   = $('[data-itnss="itnss_description_staff_cacedipi"]').val();
            var itnss_description                  = $('[data-itnss="itnss_description"]').val();            
            //var itnss_justification_help           = $('[data-itnss="itnss_justification_help"]:checked').val();
            var itnss_justification_staff_cacedipi = $('[data-itnss="itnss_justification_staff_cacedipi"]').val();
            var itnss_justification                = $('[data-itnss="itnss_justification"]').val();            
            //var itnss_solution_help                = $('[data-itnss="itnss_solution_help"]:checked').val();
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
            
            

            var local_data = {record_id: record_id
                            , title: title
                            , date_needed: date_needed
                            , created_by: created_by
                            , request_type: request_type
                            , classification: classification
                            , fk_network_type_id: fk_network_type_id 
                            , is_funded: is_funded
                            , is_funded_authority: is_funded_authority
                            //, itnss_description_help: itnss_description_help
                            , itnss_description_staff_cacedipi: itnss_description_staff_cacedipi
                            , itnss_description: itnss_description
                            //, itnss_justification_help: itnss_justification_help
                            , itnss_justification_staff_cacedipi: itnss_justification_staff_cacedipi
                            , itnss_justification: itnss_justification
                            //, itnss_solution_help: itnss_solution_help
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
            };//END local_data object            
            db_Update_Record(local_data);            
        });//END on-click

        /**AJAX Magic - thank you Jeff Rowe and Chris Scupski */
        function db_Update_Record(local_data){
            console.log('Outgoing data request:\n'+JSON.stringify(local_data));
            Label_Fadein('[data-itnss="status_label"]');
            $('[data-itnss="status_label"]').html('Please wait... Processing Record ID: ' + update_record_id);
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
            $('[data-itnss="status_label"]').css({'color':'color:rgba(255,42,42,1.00)'});
            $('[data-itnss="status_label"]').html('ERROR. Failed to update record ID: ' + update_record_id);
            console.log('ERROR. Failed to update record ID: ' + update_record_id + '\n' + message);
            Label_Fadeout('[data-itnss="status_label"]');
        }
        function db_Received_Success(myJ){
            Label_Fadein('[data-itnss="status_label"]');
            $('[data-itnss="status_label"]').css({'color':'rgba(26,240,150,1.00)'});
            $('[data-itnss="status_label"]').html('Success! Updated Record ID: ' + update_record_id);
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
        /*END AJAX magic*/
        
        
    });//END DOM Ready
</script>


<script type="text/javascript">
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
});
</script>        
	


