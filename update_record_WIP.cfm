<cfsetting showdebugoutput="true">
<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EDGE" />
<title>Update ITNSS Record</title>
	
	<script src="jqueryui/external/jquery/jquery.js"></script>
	<script src="jqueryui/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="jqueryui/jquery-ui.min.css">
	 
	<cfinclude template="style/itnss_style.cfm">
	<cfinclude template="style/jqueryOverride_style.cfm">	
    
</head>

<body>

<style>
body{background-color:rgba(40,70,127, 1.00);}

.form-block-1, .form-block-2, .form-block-3, .form-block-4 {display: inline-block;}
.form-block-2 {display: inline-block;}
.form-block-3 {display: inline-block;}
.form-block-4 {display: inline-block;width: 33%;}
.form-field, .form-block-1, .form-block-2, .form-block-3, .form-block-4 {padding:2px;}
form {}
.main-fieldset {padding:1px;margin: 10px;}
.main-legend {font-weight: bold;font-size: 18px;}
.small-fieldset {padding: 10px;margin: 10px;width: 200px;}
.small-legend {font-weight: bold;font-size: 14px;}
.ff-label {padding: 5px;display: block;}
.ff-label-radio {font-weight: normal;font-size: 14px;display: inline-block;}
.ff-label-radio {padding: 5px;display: block;}
textarea {width: 75%;padding: 10px;}
input[type=text], select {width:250px;padding: 10px;}
input[type=date] {width: 150px;}
input[type=date] {font-size:14px;padding:8px;}
input[type=radio] {}
input[type=submit] {}
input[type=submit]:hover {}

[data-itnss="created_by"]{border:1px solid grey;font-size:12px;padding:4px;height:37px;min-width:250px;}
[data-itnss="created_by"]::-webkit-calendar-picker-indicator{ display: none;}
[data-itnss="created_by"]{margin-top:-10px;}

.modern_button{width:200px;color:#F2F5FC;text-align:center;text-decoration:none;background-color:#00308F;transition:background-color 0.5s ease, border 0.5s ease;border:0px solid #BDCEEF;padding:5px 8px;}
.modern_button:hover{background-color:#0049D1;border:0px solid #D7E3F8;color:#ffffff;cursor:pointer;}
</style>
       
	<!--- REQUIRED: FRAMEWORK HEADER *** --->
    <cfinclude template="/framework/rqweb_header.cfm">  


<cfquery name="get_record" datasource="#APPLICATION.asd#">
    SELECT * 
    FROM itnss_requirement
    WHERE itnss_requirement_id = 1
</cfquery>
    <cfset record_id       = 1>
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

<cfquery name="get_created_by" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi 
    FROM account_info
    WHERE cac_edipi = <cfqueryparam cfsqltype="cf_sql_int" value="#created_by#" />
</cfquery>
    <cfset cb_id   = "#get_created_by.id#">
    <cfset cb_cacedipi = "#get_created_by.cac_edipi#">
    <cfset cb_name   = "#get_created_by.first_name# #get_created_by.last_name#">
    <cfset cb_title  = "#get_created_by.title#">
    <cfset cb_symbol = "#get_created_by.symbol#">
    <cfset cb_phone  = "#get_created_by.phone_number#">
    
<cfquery name="get_user_list" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi 
    FROM account_info
</cfquery>

<cfquery name="get_description_staff" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi 
    FROM account_info
    WHERE cac_edipi = #get_record.itnss_description_staff_cacedipi#
</cfquery>

<cfquery name="get_justification_staff" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi 
    FROM account_info
    WHERE cac_edipi = #get_record.itnss_justification_staff_cacedipi#
</cfquery>

<cfquery name="get_solution_staff" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi 
    FROM account_info
    WHERE cac_edipi = #get_record.itnss_solution_staff_cacedipi#
</cfquery>

<cfquery name="get_is_funded_authority" datasource="#APPLICATION.asd#">
    SELECT id, last_name, first_name, title, symbol, phone_number, email_address, cac_edipi 
    FROM account_info
    WHERE cac_edipi = #get_record.is_funded_authority#
</cfquery>

<cfquery name="get_requirement_lab" datasource="#APPLICATION.asd#">
    SELECT itnss_requirement_id, lab_id 
    FROM itnss_labs 
    WHERE itnss_requirement_id = #get_record.itnss_requirement_id#
</cfquery>

<cfquery name="get_valid_labs" datasource="#APPLICATION.asd#">
    SELECT lab_id, lab_abbr, lab_name, lab_desc, lab_location, active
    FROM labs_valid    
</cfquery>


 
 	<!--- Application Navigation
    <cfinclude template="/toast/navigation.cfm">  --->
          
	<!--- APPLICATION CONTENT *** --->
    <div style="width:100%; min-height:700px;">
		<cfinclude template="index_main.cfm">
<cfoutput>
        
        <form id="form_edit_record" data-itnss="form_edit_record" method="post"> 
            <input data-itnss="record_id" type="hidden" name="record_id" class="form-field-input" value="#record_id#"> 
                   
            <!---<fieldset class="main-fieldset"><legend class="main-legend">AFRL/RQ Requirements</legend>--->
                <div id="form_row_01" data-itnss="form_row_01" class="" style="border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;">
                    <div class="form-block-1">
                        <label for="title" class="ff-label">Requirement Title
                            <input data-itnss="title" type="text" name="title" class="form-field-input" value="#title#">
                        </label>
                    </div>
                    
                    <div class="form-block-1">
                        <label for="date_needed" class="ff-label">Date Needed
                            <input data-itnss="date_needed" type="date" name="date_needed" class="form-field-input">
                        </label>
                    </div>
                </div><!--- END form_row_01 --->
                
                <div id="form_row_02" data-itnss="form_row_02" class="" style="border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;">
                    <div class="form-block-2">
                    <label for="created_by" class="ff-label">Point of Contact <span style="font-size:12px;">(Created By)</span>
                        <select data-itnss="created_by" id="created_by" name="created_by">
                            <option value="#get_record.created_by#">#cb_name# | #cb_symbol# | #cb_phone#</option>
                            <cfloop query = "get_user_list"> 
                                <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol# | #get_user_list.phone_number#</option> 
                            </cfloop>
                        </select>
                    </label>
                    </div>
                </div><!--- END form_row_02 --->

            <div id="form_row_03" data-itnss="form_row_03" class="" style="border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;">
                <div class="form-block-4">
                    <label for="lab_name1" class="ff-label">Lab Name
                        <select name="lab_name1">
                            <option value="#get_requirement_lab.lab_id#">requirement id: #get_requirement_lab.itnss_requirement_id# | lab id: #get_requirement_lab.lab_id#</option>
                            <cfloop query = "get_valid_labs"> 
                                <option value="#get_valid_labs.lab_id#">#get_valid_labs.lab_name#</option> 
                            </cfloop>
                        </select>
                    </label>
                </div>
            </div><!---END form_row_03--->
                        
            <div id="form_row_04" data-itnss="form_row_04" class="" style="display:flex;justify-content:center;border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;">
                <div class="form-field">
                    <fieldset class="small-fieldset">
                    <cfset is_checked="false">
                    <cfif #get_record.request_type# is 1>
                        <cfset is_checked = "true">
                    <cfelse>
                        <cfset is_checked = "false">
                    </cfif>
                    <legend class="small-legend">Type of Request</legend>
                        <label for="type_request_s" class="ff-label-radio">Software
                            <input data-itnss="request_type" type="radio" name="request_type" value="2" checked="#is_checked#">
                        </label>             
                        <label for="type_request_h" class="ff-label-radio">Hardware
                            <input data-itnss="request_type" type="radio" name="request_type" value="1" checked="#is_checked#">
                        </label>                              
                    </fieldset>     
                </div> 
                
                <div class="form-field">
                    <fieldset class="small-fieldset">
                        <cfset is_checked="false">
                        <cfif #get_record.fk_network_type_id# is 1>
                            <cfset is_checked = "true">
                        <cfelse>
                            <cfset is_checked = "false">
                        </cfif>
                        <legend class="small-legend">Associated Network</legend>
                        <label for="fk_network_type_id" class="ff-label-radio">SIPR
                            <input data-itnss="fk_network_type_id" type="radio" name="fk_network_type_id" value="2" checked="#is_checked#">
                        </label>
                        <label for="fk_network_type_id" class="ff-label-radio">NIPR
                            <input data-itnss="fk_network_type_id" type="radio" name="fk_network_type_id" value="1" checked="#is_checked#">
                        </label>
                        <label for="fk_network_type_id" class="ff-label-radio">DREN
                            <input data-itnss="fk_network_type_id" type="radio" name="fk_network_type_id" value="3" checked="#is_checked#">
                        </label>
                        <label for="fk_network_type_id" class="ff-label-radio">Enclave
                            <input data-itnss="fk_network_type_id" type="radio" name="fk_network_type_id" value="5" checked="#is_checked#">
                        </label>
                        <label for="fk_network_type_id" class="ff-label-radio">Standalone
                            <input data-itnss="fk_network_type_id" type="radio" name="fk_network_type_id" value="6" checked="#is_checked#">
                        </label>
                    </fieldset> 
                </div>
                
                <div class="form-field">
                    <fieldset class="small-fieldset">
                        <cfset is_checked="false">
                        <cfif #get_record.classification# is 1>
                            <cfset is_checked = "true">
                        <cfelse>
                            <cfset is_checked = "false">
                        </cfif>
                    <legend class="small-legend">Classification</legend>
                    <label for="classification" class="ff-label-radio">Classified
                        <input data-itnss="classification" type="radio" name="classification" value="classified" checked="#is_checked#">
                    </label>
                    <label for="classification" class="ff-label-radio">Unclassified
                        <input data-itnss="classification" type="radio" name="classification" value="unclassified" checked="#is_checked#">
                    </label>
                    </fieldset> 
                </div>
                
                <div class="form-field">
                    <fieldset class="medium-fieldset">
                        <cfset is_checked="false">
                        <cfif #get_record.is_funded# is 1>
                            <cfset is_checked = "true">
                        <cfelse>
                            <cfset is_checked = "false">
                        </cfif>
                    <legend class="small-legend">Funded</legend>
                    <label for="is_funded" class="ff-label-radio">No
                        <input data-itnss="is_funded" type="radio" name="is_funded" value="0" checked="#is_checked#">
                    </label>
                    <label for="is_funded" class="ff-label-radio">Yes
                        <input data-itnss="is_funded" type="radio" name="is_funded" value="1" checked="#is_checked#">
                    </label>
                    <label for="is_funded_authority" class="ff-label">Requestor Approval Authority
                        <select data-itnss="is_funded_authority" name="is_funded_authority">
                            <option value="#get_record.is_funded_authority#">#get_is_funded_authority.last_name# | #get_is_funded_authority.symbol# | #get_is_funded_authority.phone_number#</option>
                            <cfloop query = "get_user_list"> 
                                <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol# | #get_user_list.phone_number#</option> 
                            </cfloop>
                        </select>
                    </label>
                    </fieldset> 
                    
                </div>
            </div><!---END form_row_04 ---> 
            
<div id="btn_submit_test" data-itnss="btn_submit_test" class="modern_button"><span id="lbl_undo_image">JavaScript Submit</span></div>
<label data-itnss="status_label" style="font-size:12px;color:white;display:inline;"></label> 


    <div id="form_row_05" data-itnss="form_row_05" class="" style="display:flex;justify-content:space-between;border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;">
        <div style="display:flex;flex-direction:column;">
            <div class="form-field">
            <h4>AFRL/RQOC Computer Support Personnel assisted with Description</h4>
                        <cfset is_checked="false">
                        <cfif #get_record.itnss_description_help# is 1>
                            <cfset is_checked = "true">
                        <cfelse>
                            <cfset is_checked = "false">
                        </cfif>
            <label for="itnss_description_help" class="ff-label-radio">Yes
                <input data-itnss="itnss_description_help" type="radio" name="itnss_description_help" value="1" checked="#is_checked#">
            </label>
            <label for="itnss_description_help" class="ff-label-radio">No
                <input data-itnss="itnss_description_help" type="radio" name="itnss_description_help" value="0" checked="#is_checked#">
            </label>
            </div>
            <div class="form-field">
            <label for="itnss_description_staff_cacedipi" class="ff-label">AFRL/RQOC Staff Member
                <select data-itnss="itnss_description_staff_cacedipi" name="itnss_description_staff_cacedipi">
                    <option value="#get_record.itnss_description_staff_cacedipi#">#get_description_staff.last_name# | #get_description_staff.symbol# | #get_description_staff.phone_number#</option>
                    <cfloop query = "get_user_list"> 
                        <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol# | #get_user_list.phone_number#</option> 
                    </cfloop>
                </select>
            </label>
            </div>
            <div class="form-field">
                <label for="itnss_description" class="ff-label">Requirement
                    <textarea data-itnss="itnss_description" name="itnss_description" type="text" rows="6" cols="100"  class="form-field-input">
                        #get_record.itnss_description#
                    </textarea>
                </label>
            </div>
        </div>
    </div><!---END Requirement Description w/ computer support --->

    
<div id="form_row_05" data-itnss="form_row_05" class="" style="display:flex;justify-content:space-between;border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;">
    <div style="display:flex;flex-direction:column;">  
        <div class="form-field">
            <h4>AFRL/RQOC Computer Support Personnel assisted with Justification</h4>
                        <cfset is_checked="false">
                        <cfif #get_record.itnss_justification_help# is 1>
                            <cfset is_checked = "true">
                        <cfelse>
                            <cfset is_checked = "false">
                        </cfif>
            <label for="itnss_justification_help" class="ff-label-radio">Yes
            <input data-itnss="itnss_justification_help" type="radio" name="itnss_justification_help" value="1" checked="#is_checked#">
            </label>
            <label for="itnss_justification_help" class="ff-label-radio">No
            <input data-itnss="itnss_justification_help" type="radio" name="itnss_justification_help" value="0" checked="#is_checked#">
            </label>
        </div>
        <div class="form-field">
            <label for="itnss_justification_staff_cacedipi" class="ff-label">AFRL/RQOC Staff Member
            <select data-itnss="itnss_justification_staff_cacedipi" name="itnss_justification_staff_cacedipi">
            <option value="#get_record.itnss_justification_staff_cacedipi#">#get_justification_staff.last_name# | #get_justification_staff.symbol# | #get_justification_staff.phone_number#</option>
            <cfloop query = "get_user_list"> 
            <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol# | #get_user_list.phone_number#</option> 
            </cfloop>
            </select>
            </label>
        </div>        
        <div class="form-field">
            <label for="itnss_justification" class="ff-label">Justification
            <textarea data-itnss="itnss_justification" type="text" rows="6" cols="100" name="itnss_justification" class="form-field-input">
            #get_record.itnss_justification#
            </textarea>
            </label>
        </div>
    </div>
</div><!---END Justification Description w/ computer support ---> 
   
<div id="form_row_06" data-itnss="form_row_06" class="" style="display:flex;justify-content:space-between;border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;">
    <div style="display:flex;flex-direction:column;">  
        <div class="form-field">
            <h4>AFRL/RQOC Computer Support Personnel assisted with Technical Solution</h4>
                        <cfset is_checked="false">
                        <cfif #get_record.itnss_solution_help# is 1>
                            <cfset is_checked = "true">
                        <cfelse>
                            <cfset is_checked = "false">
                        </cfif>
            <label for="itnss_solution_help" class="ff-label-radio">Yes
                <input data-itnss="itnss_solution_help" type="radio" name="itnss_solution_help" value="1" checked="#is_checked#">
            </label>
            <label for="itnss_solution_help" class="ff-label-radio">No
                <input data-itnss="itnss_solution_help" type="radio" name="itnss_solution_help" value="0" checked="#is_checked#">
            </label>
        </div>
        <div class="form-field">
            <label for="itnss_solution_staff_cacedipi" class="ff-label">AFRL/RQOC Staff Member
                <select data-itnss="itnss_solution_staff_cacedipi" name="itnss_solution_staff_cacedipi">
                    <option value="#get_record.itnss_solution_staff_cacedipi#">#get_solution_staff.last_name# | #get_solution_staff.symbol# | #get_solution_staff.phone_number#</option>
                    <cfloop query = "get_user_list"> 
                        <option value="#get_user_list.cac_edipi#">#get_user_list.last_name#,#get_user_list.first_name# | #get_user_list.symbol# | #get_user_list.phone_number#</option> 
                    </cfloop>
                </select>
            </label>
        </div>        
        <div class="form-field">
            <label for="itnss_solution" class="ff-label">Technical Solution
                <textarea data-itnss="itnss_solution" type="text" rows="6" cols="100" name="itnss_solution" class="form-field-input">
                    #get_record.itnss_solution#
                </textarea>
            </label>
        </div>
    </div>
</div><!---END Tech Solution Description w/ computer support --->

    <div id="form_row_07" data-itnss="form_row_07" class="" style="display:flex;justify-content:space-between;border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;">
       <div style="display:flex;flex-direction:column;"> 
            <div class="form-field">
                <label for="notes_cso_cto_iao" class="ff-label">CSO/CTO/IAO Required notes for processing (RQOC Only)
                    <textarea data-itnss="notes_cso_cto_iao" type="text" rows="6" cols="100" name="notes_cso_cto_iao" class="form-field-input">
                        #get_record.notes_cso_cto_iao#
                    </textarea>
                </label>
            </div>
        </div>
    </div><!---END form_row_05--->

<div id="form_row_06" data-itnss="form_row_06" class="" style="display:flex;justify-content:space-between;background-color:rgba(227,179,147,0.74);border:1px solid rgba(216,225,244,1.00);width:100%;min-height:150px;clear:both;margin:2px 2px;padding:2px 2px;">
</div> <!---END form_row_06 --->          
          </fieldset> 
		</form>

	</div>
</cfoutput>
 <!--- REQUIRED: FRAMEWORK FOOTER *** --->    	
	<cfinclude template="/framework/rqweb_footer.cfm">

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
        $('[data-itnss="date_needed"]').datepicker("option","dateFormat","mm-dd-yy");
        var db_date = '<cfoutput>#DateFormat(get_record.date_needed, "mm-dd-yyyy")#</cfoutput>';
        $('[data-itnss="date_needed"]').datepicker("setDate", db_date);
                
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
            var itnss_description_help             = $('[data-itnss="itnss_description_help"]:checked').val();
            var itnss_description_staff_cacedipi   = $('[data-itnss="itnss_description_staff_cacedipi"]').val();
            var itnss_description                  = $('[data-itnss="itnss_description"]').val();            
            var itnss_justification_help           = $('[data-itnss="itnss_justification_help"]:checked').val();
            var itnss_justification_staff_cacedipi = $('[data-itnss="itnss_justification_staff_cacedipi"]').val();
            var itnss_justification                = $('[data-itnss="itnss_justification"]').val();            
            var itnss_solution_help                = $('[data-itnss="itnss_solution_help"]:checked').val();
            var itnss_solution_staff_cacedipi      = $('[data-itnss="itnss_solution_staff_cacedipi"]').val();
            var itnss_solution                     = $('[data-itnss="itnss_solution"]').val();            
            var notes_cso_cto_iao                  = $('[data-itnss="notes_cso_cto_iao"]').val();

            var local_data = {record_id: record_id
                , title: title
                , date_needed: date_needed
                , created_by: created_by
                , request_type: request_type
                , classification: classification
                , fk_network_type_id: fk_network_type_id 
                , is_funded: is_funded
                , is_funded_authority: is_funded_authority
                , itnss_description_help: itnss_description_help
                , itnss_description_staff_cacedipi: itnss_description_staff_cacedipi
                , itnss_description: itnss_description
                , itnss_justification_help: itnss_justification_help
                , itnss_justification_staff_cacedipi: itnss_justification_staff_cacedipi
                , itnss_justification: itnss_justification
                , itnss_solution_help: itnss_solution_help
                , itnss_solution_staff_cacedipi: itnss_solution_staff_cacedipi
                , itnss_solution: itnss_solution
                , notes_cso_cto_iao: notes_cso_cto_iao/**/
            };
            
            db_Update_Record(local_data);            
        });//END on-click

        /**AJAX Magic - thank you Jeff Rowe and Chris Scupski */
        function db_Update_Record(local_data){
            console.log('Outgoing data request:\n'+JSON.stringify(local_data));
            Label_Fadein('[data-itnss="status_label"]');
            $('[data-itnss="status_label"]').html('Please wait... Processing Record ID: ' + update_record_id);
            Label_Fadeout('[data-itnss="status_label"]');
            
            var dbRequest = $.ajax({
                  url: "submit_Adam_v2.0.cfc?method=update_record&returnformat=json"
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


</body>
</html>
