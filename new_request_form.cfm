<!--- load form_styles.css --->
<link rel="stylesheet" type="text/css" href="css/form_styles.css">
<style>
textarea {min-height:35px;width:100%;padding:3px;}
[data-itnss="itnss_description"]{min-height:35px;width:100%;padding:3px;}
[data-itnss="itnss_justification"]{min-height:35px;width:100%;padding:3px;}
[data-itnss="itnss_solution"]{min-height:35px;width:100%;padding:3px;}
</style>

<!--- Get submitter info --->
<cfquery name="getSubmitterInfo" datasource="#APPLICATION.asd#">
	SELECT	*
    FROM	account_info
    WHERE	cac_edipi = '#session.intranet.user_eipd#'<!------>  <!--- 1039599607  --->
    	AND	non_user <> 1 
    	AND status_code = 1
</cfquery>

<!--- Get User list for drop-downs. --->
<cfquery name="getUsers" datasource="#APPLICATION.asd#">
	SELECT	*, UPPER(last_name + ', ' + first_name) as fullname
    FROM	account_info
    WHERE	non_user <> 1 
    	AND status_code = 1
        
    ORDER BY last_name, first_name
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

<!--- List of Org Approvers (Civ and Mil Only) --->
<cfquery name="getOrgApprovers" datasource="#APPLICATION.asd#">
    SELECT	id, cac_edipi, gal_displayname
    FROM	account_info
    WHERE	(NOT (username LIKE '%E%')) 
    	AND (NOT (username LIKE '%v%')) 
        AND (non_user <> 1) 
        AND (status_code = 1) 
        AND (city = 'Wright Patterson AFB')
        
    ORDER BY last_name, first_name
</cfquery>

<!--- Get List of Labs --->
<cfquery name="getLabs" datasource="#APPLICATION.asd#">
	SELECT	*
    FROM 	labs_valid
    WHERE	active = 1
    ORDER BY lab_name
</cfquery>

<cfoutput>
<div style="margin:25px 0px;">
	<!--- Navigation --->
	<cfinclude template="navigation.cfm">
	
    <div style="float:left; width:80%; max-width:1350px; min-width:200px;">
    	
        <div id="ticket_tabs">   
        <ul>
        	<li><a href="##itnss_tab">New Requirement</a></li>
        </ul>

        <form data-itnss="new_request_form" action="submit.cfc?method=newRequestSubmit" method="post" style="margin-top:25px;">
         
           <div class="form-block-1">
            <label for="title" class="ff-label ff-required">* Requirement Title 
            
              <span class="ff-inputDesc">(short description of requirement)</span>
<input data-itnss="requirement_title" type="text" id="title" name="title" class="form-field-input" style="width:600px; display:block;">
            </label>
           </div>
           
           <div class="form-block-1">
            <label for="date_needed" class="ff-label">Date Needed
                <input data-itnss="requirement_date_needed" type="text" id="date_needed" name="date_needed" class="form-field-input ff-input-date" placeholder="MM/DD/YYYY">
            </label>
           </div>
           
           <br style="clear:both;">
           
           <div class="form-block-2">
            <label for="poc" class="ff-label ff-required">* Point of Contact
            	<span class="ff-inputDesc">(requesting org POC)</span>
                <select data-itnss="poc"name="poc" class="form-field-input">
             	<option value=""></option>
                <cfloop query="getUsers">
                	<option value="#cac_edipi#">#gal_displayname#</option>
                </cfloop>
             </select>
            </label>
           </div>           
           
           <div class="form-block-2">
            <label for="req_appr_auth" class="ff-label  ff-required">* Org Approval Authority 
            <span class="ff-inputDesc">(person that will approve this submission)</span>
             <select data-itnss="is_funded_authority" name="req_appr_auth" class="form-field-input">              	
             	<option value="">Select Org Approver</option>
                <cfloop query="getOrgApprovers">
                	<option value="#cac_edipi#">#gal_displayname#</option>
                </cfloop>
             </select>   
             </label>
            </div>
            
           <br style="clear:both;">
           
           <!--- Do we want to pull this from the Account_Info table (3/23/2018 cm) 
           <div class="form-block-2">
            <label for="poc_phone" class="ff-label" />Phone Number
            <input type="text" name="poc_phone" class="form-field-input" value="#getSubmitterInfo.phone_number#" disabled/>
           </div>--->
           
           <!--- Do we want to pull this from the Account_Info table (3/23/2018 cm) 
           <div class="form-block-3"><!--- This will need a loop --->
            <label for="org_office" class="ff-label" />Organization/Office
             <input type="text" id="org_office" name="org_office" class="form-field-input" value="#getSubmitterInfo.symbol#" disabled />
           </div>--->
           
           <div class="form-block-4">
            <label for="lab_name1" class="ff-label" />Lab Name
             <select name="lab_name1" class="form-field-input">
             	<option value="">Select a Lab</option>
                <cfloop query="getLabs">
                <option	value="#lab_id#">#lab_name#</option>
                </cfloop>
             </select>
           </div>
           <br style="clear:both;">
           
           <div class="form-block-5">
           <fieldset class="small-fieldset-2">
            <legend class="small-legend">Type of Request</legend>
            
            <label for="type_request_h" class="ff-label-radio">Hardware
            <input type="radio" id="request_type" name="request_type" value="hardware" required></label>
           
            <label for="type_request_s" class="ff-label-radio">Software
            <input type="radio" id="request_type" name="request_type" value="software" required></label>
            
            <label for="type_request_s" class="ff-label-radio">Network
            <input type="radio" id="request_type" name="request_type" value="network" required></label>
            
            <label for="type_request_s" class="ff-label-radio">Other
            <input type="radio" id="request_type" name="request_type" value="other" checked required></label>
             
           </fieldset>     
           </div>
           
           
           <div class="form-block-8">
           <fieldset class="small-fieldset-2">
            <legend class="small-legend">Classification</legend>
            
            <label for="class_u" class="ff-label-radio">Unclassified
             <input type="radio" id="class_u" name="classification" value="unclassified" checked/>
            </label>
            
            <label for="class_c" class="ff-label-radio">Classified
                <input type="radio" id="class_c" name="classification" value="classified" />
            </label>
            
           </fieldset>
           </div>
           
   <div class="form-block-9">
    <fieldset class="small-fieldset-fb9">
        <legend class="small-legend">Associated Network</legend>        
        	<br>
            <label for="assoc_network_nipr" class="ff-label-radio">NIPR
                <input type="checkbox" id="fk_network_type_id" name="fk_network_type_id" value="1" />
            </label>            
            <label for="assoc_network_dren" class="ff-label-radio">DREN
                <input type="checkbox" id="fk_network_type_id" name="fk_network_type_id" value="3" />
            </label>            
            <label for="assoc_network_sipr" class="ff-label-radio">SIPR
                <input type="checkbox" id="fk_network_type_id" name="fk_network_type_id" value="2" />
            </label>            
            <label for="assoc_network_enc" class="ff-label-radio">Enclave
                <input type="checkbox" id="fk_network_type_id" name="fk_network_type_id" value="5" />
            </label>            
            <label for="assoc_network_st" class="ff-label-radio">RQ Enclave
                <input type="checkbox" id="fk_network_type_id" name="fk_network_type_id" value="4" />
            </label>            
            <label for="assoc_network_st" class="ff-label-radio">Standalone
                <input type="checkbox" id="fk_network_type_id" name="fk_network_type_id" value="6" />
            </label>
    </fieldset>      
   </div>
           
           <div class="form-block-10">
           <fieldset class="small-fieldset">
            <legend class="small-legend">Funded</legend>
            
            <div class="raa-block-1">
            <label for="is_funded_yes" class="ff-label-radio">Yes
                <input type="radio" id="is_funded" name="is_funded" value="1" required>
            </label>

            
            <label for="is_funded_no" class="ff-label-radio">No
                <input type="radio" id="is_funded" name="is_funded" value="0" checked required>
            </label>
            </div>
            </fieldset>
           </div>
           
           <br style="clear: both;" />

           
           <div class="fb-6-container">
           <div class="form-block-6">
            <label for="requirement" class="ff-label">Requirement
            <textarea data-itnss="itnss_description" type="text" id="itnss_description" name="itnss_description" class="form-field-input" placeholder="Enter Description of Requirement"></textarea>
            </label>
           </div>
           
           <div class="form-block-6">
            <label for="staff_mem" class="ff-label" />Requirement assistance provided by 
             <select id="itnss_description_staff_cacedipi" name="itnss_description_staff_cacedipi">
				<option value="">Select AFRL/RQOC Personnel</option>
                <cfloop query="getRQOC">                
                <option value="#getRQOC.cac_edipi#">#getRQOC.fullname#</option>
                </cfloop>
             </select>   
           </div>
           </div>

           <div class="fb-6-container">
           <div class="form-block-6">
            <label for="justification" class="ff-label">Justification
            <textarea data-itnss="itnss_justification" type="text" id="itnss_justification" name="itnss_justification" class="form-field-input" placeholder="Enter Justification for Requirement"></textarea>
            </label>
           </div>
           
           <div class="form-block-6">
            <label for="staff_mem" class="ff-label">Justification assistance provided by 
             <select id="itnss_justification_staff_cacedipi" name="itnss_justification_staff_cacedipi">
              	<option value="">Select AFRL/RQOC Personnel</option>
                <cfloop query="getRQOC">                
                <option value="#getRQOC.cac_edipi#">#getRQOC.fullname#</option>
                </cfloop>
             </select> 
             </label>  
           </div>
           </div>
           
           
           
           <div class="fb-6-container">
               <div class="form-block-6">
                <label for="tech_sol" class="ff-label form-field-input">Technical Solution
                <textarea data-itnss="itnss_solution" type="text" id="itnss_solution" name="itnss_solution"  class="form-field-input" placeholder="Enter Technical Solution for Requirement"></textarea>
                </label>
               </div>
               
               <div class="form-block-7">
                <label for="staff_mem" class="ff-label">Technical Solution assistance provided by 
                 <select id="itnss_solution_staff_cacedipi" name="itnss_solution_staff_cacedipi">
                  	<option value="">Select AFRL/RQOC Personnel</option>
                    <cfloop query="getRQOC">                
                    <option value="#getRQOC.cac_edipi#">#getRQOC.fullname#</option>
                    </cfloop>
                 </select>
                 </label>
               </div>
           </div>

            <div class="save-button" style="">
                <label data-itnss="status_label" style="font-size:12px;color:white;margin-top:12px;"></label>
                <div id="btn_submit_form" data-itnss="btn_submit_form" class="modern_button" style="width:100px;padding-left:15px;">
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
                <!---<input id="btn_submit" type="submit" value="Submit">--->
            </div>

        </form>
        </div>
    </div>

</div>
</cfoutput>



        
<script type="text/javascript">
    $(function() {
        var do_submit = false;

        /*::: ::: Responsive Textarea ::: :::*/
        $('textarea[data-itnss^="itnss_"]').focus(function(){
            $(this).animate({"min-height":'200px', width:'100%'}, 500);
        });
        $('textarea[data-itnss^="itnss_"]').blur(function(){
            $(this).animate({"min-height":'50px', width:'100%'}, 500);
        });
        /*::: ::: END Responsive Textarea ::: :::*/
        var do_submit=false;
        var $input_title = $('[data-itnss="requirement_title"]');
        var $input_date_needed = $('[data-itnss="requirement_date_needed"]');
        $input_title.attr("required", true);
        $input_date_needed.attr("required", true);
        
        /* ::: Manage Empty Fields ::: */        
        function Manage_Empty_Fields(){
            $('[data-itnss="requirement_title"], [data-itnss="requirement_date_needed"], [data-itnss="poc"], [data-itnss="is_funded_authority"]').each(function() {                
                if ($(this).val() == '' | $(this).val().length==0) {
                    $info_required=$(this).attr("data-itnss");
                    $(this).focus();
                    $(this).parent().effect('shake', {times: 3}, 800); //textarea[data-itnss^="itnss_"]
                    do_submit=false;
                    $('[data-itnss="btn_submit_form"]').css({'pointer-events':'none'});
                    console.log('in the 1st FALSE condition: '+ do_submit + ' :: ' + $info_required);
                    return false;
                }else{
                    do_submit=true;
                    $('[data-itnss="btn_submit_form"]').css({'pointer-events':'auto'});
                }
            });

            if(do_submit==false){
                console.log('do_submit is false: ' + do_submit);
                //Label_Fadein('[data-itnss="status_label"]');
                //$('[data-itnss="status_label"]').css({'color':'rgb(119, 19, 30)'}).html('Missing Info: '+$info_required.toUpperCase());
                //Label_Fadeout('[data-itnss="status_label"]');
            }else{console.log('in the TRUE condition: '+do_submit);
                do_submit=true;
            }
            return do_submit;
        }
        
        $('[data-itnss="requirement_title"], [data-itnss="requirement_date_needed"], [data-itnss="poc"], [data-itnss="is_funded_authority"]').each(function() {                
            $(this).change(function(){
                do_submit = Manage_Empty_Fields();
            });//END this.change
        });
        /* ::: END Manage Empty Fields ::: */
        //Submit on click
        $('[data-itnss="btn_submit_form"]').on('click', function(){
            
            do_submit = Manage_Empty_Fields();

            if(do_submit==true){
                $('[data-itnss="new_request_form"]').submit();                
            }
            
        });
        
        //Get Request ID
        <cfoutput> </cfoutput>

        //Initialize tabs
        $("#ticket_tabs").tabs();

        //Date Picker
        $("#date_needed").datepicker();

        $(".cancel_button").button({
            icons: {
                primary: "ui-icon-cancel"
            }
        }).click(function() {
            alert("ITNSS Request Cancelled");
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
            window.location = 'update_record.cfm?requestID=' + this.value;
        });

        $("#keys").click(function() {
            //openWindow("steps_keys.cfm","","testme","Keys / Bldg Access");	
        });
    });
</script>      
	



