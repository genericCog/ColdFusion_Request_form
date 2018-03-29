<!--- Get submitter info --->
<cfquery name="getSubmitterInfo" datasource="#APPLICATION.asd#">
	SELECT	*
    FROM	account_info
    WHERE	cac_edipi = '#session.intranet.user_eipd#'
    	AND	non_user <> 1 
    	AND status_code = 1
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
</cfquery>

<!--- Get List of Labs --->
<cfquery name="getLabs" datasource="#APPLICATION.asd#">
	SELECT	*
    FROM 	labs_valid
    WHERE	active = 1
    ORDER BY lab_name
</cfquery>

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



<!--- FORM STYLES --->
<style>

/**div {
	border: 1px solid #8A8A8A;
}**/

.form-field-input {
	display: block;
}

.form-block-1 {
	display: inline-block;
}

.form-block-2 {
	display: inline-block;
}

.form-block-4 {
	display: inline-block;
	width: 30%;
}

.form-block-5 {
	width: 50%;
	float: left;
	padding: 10px 20px 10px 0px;
	text-align: center;
}

.form-block-8 {
	width: 50%;
	float: left;
	padding: 10px 0px 10px 20px;
	text-align: center;
}

.form-block-9 {
	float: left;
	text-align: center;
	width: 50%;
	padding: 10px 20px 10px 0px;

}

.form-block-10 {
	text-align: center;
	width: 50%;
	float: left;
	padding: 10px 0px 10px 20px;
}

.fb-6-container {
	border: 4px solid #ccc;
	background-color: #eee;
	padding: 20px;
	margin: 10px;
	padding: 10px;
}

.form-field, 
.form-block-1, 
.form-block-2, 
.form-block-3, 
.form-block-4 {
	padding: 10px;
}

.main-fieldset {
	padding: 10px;
	margin: 10px;
}

.main-legend {
	font-weight: bold;
	font-size: 18px;
	padding:10px;
}

.small-fieldset-2 {
	padding: 10px;
	margin: 10px;
	height: 100px;
	background-color: #F3F3F3;
	border: 4px solid #ccc;
}

.small-fieldset-fb9 {
	padding: 10px;
	margin: 10px;
	height: 143px;
	background-color: #F3F3F3;
	border: 4px solid #ccc;

}

.small-fieldset {
	padding: 10px;
	margin: 10px;
	background-color: #F3F3F3;
	border: 4px solid #ccc;

}

.small-legend {
	padding: 0px -5px 0px 0px;
	text-align: left;
	font-weight: bold;
	font-size: 14px;
	padding: 10px;
}

.ff-label {
	display: block;
	padding: 5px;
}

.ff-label-radio {
	font-weight: normal;
	font-size: 14px;
	padding: 15px;
}

.raa-block-1 {
	float: left;
	padding: 30px;
	margin-right: 30px;
}

.raa-block-2 {
	float: left;
}

.raa-label {
	display: block;
}

textarea {
	min-height:300px;
	min-width:600px;
	padding: 10px;
	width:100%;
}

input[type=text], select {
	width: 300px;
	padding: 10px;
}

input[type=date] {
	width: 150px;
}

input[type=date] {
	font-size: 14px;
	padding: 8px;
}

input[type=submit] {
	float: right;
	font-size: 18px;
	font-weight: bold;
	margin: 10px;
	padding: 10px 50px;
}

input[type=submit]:hover {
	cursor: pointer;
	border: 2px solid #666;
}

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
    	<h2 style="margin:15px 0px;">ITNSS</h2>
                
        <form action="submit.cfc?method=newRequestSubmit" method="post">
        <fieldset class="main-fieldset">
         <legend class="main-legend">AFRL/RQ Requirements</legend>
           <div class="form-block-1">
            <label for="title" class="ff-label" />Requirement Title
            <input type="text" id="title" name="title" class="form-field-input" style="width:600px; display:block;" />
           </div>
           
           <div class="form-block-1">
            <label for="date_needed" class="ff-label" />Date Needed
            <input type="date" id="date_needed" name="date_needed" class="form-field-input" />
           </div>
           
           <br style="clear:both;">
           
           <div class="form-block-2">
            <label for="poc" class="ff-label" />
            Point of Contact
            <input type="hidden" id="poc" name="poc" value="#getSubmitterInfo.cac_edipi#">
            <input type="text" name="poc_name" class="" style="width:600px; display:block;" value="#getSubmitterInfo.gal_displayname#" disabled />
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
           
           <div class="form-block-4">
            <label for="lab_name2" class="ff-label" />Lab Name
             <select name="lab_name2" class="form-field-input">
             	<option value="">Select a Lab</option>
                <cfloop query="getLabs">
                <option	value="#lab_id#">#lab_name#</option>
                </cfloop>
             </select>
           </div>
           
           <div class="form-block-4">
            <label for="lab_name3" class="ff-label" />Lab Name
             <select name="lab_name3" class="form-field-input">
             	<option value="">Select a Lab</option>
                <cfloop query="getLabs">
                <option	value="#lab_id#">#lab_name#</option>
                </cfloop>
             </select>
           </div>
           
           <div class="form-block-5">
           <fieldset class="small-fieldset-2">
            <legend class="small-legend">Type of Request</legend>
            
            <label for="type_request_h" class="ff-label-radio" />Hardware
            <input type="radio" id="request_type" name="request_type" value="hardware" />
           
            <label for="type_request_s" class="ff-label-radio" />Software
            <input type="radio" id="request_type" name="request_type" value="software" />
             
           </fieldset>     
           </div>
           
           <!--- ??? --->
           <div class="form-block-8">
           <fieldset class="small-fieldset-2">
            <legend class="small-legend">Classification</legend>
            
            <label for="class_u" class="ff-label-radio" />Unclassified
            <input type="radio" id="class_u" name="classification" value="unclassified" checked/>
            
            <label for="class_c" class="ff-label-radio" />Classified
            <input type="radio" id="class_c" name="classification" value="classified" />
            
           </fieldset>
           </div>
           
            <div class="form-block-9">
           <fieldset class="small-fieldset-fb9">
            <legend class="small-legend">Associated Network</legend>
            
            <br />
            
            <label for="assoc_network_nipr" class="ff-label-radio" />NIPR
            <input type="radio" id="fk_network_type_id" name="fk_network_type_id" value="1" />
            
            <label for="assoc_network_dren" class="ff-label-radio" />DREN
            <input type="radio" id="fk_network_type_id" name="fk_network_type_id" value="2" />
            
            <label for="assoc_network_sipr" class="ff-label-radio" />SIPR
            <input type="radio" id="fk_network_type_id" name="fk_network_type_id" value="3" />
            
            <label for="assoc_network_enc" class="ff-label-radio" />Enclave
            <input type="radio" id="fk_network_type_id" name="fk_network_type_id" value="4" />
          
            <label for="assoc_network_st" class="ff-label-radio" />Standalone
            <input type="radio" id="fk_network_type_id" name="fk_network_type_id" value="5" />
            
           </fieldset>
           </div>
           
           <!--- These two divs below go together --->
           <div class="form-block-10">
           <fieldset class="small-fieldset">
            <legend class="small-legend">Funded</legend>
            
            <div class="raa-block-1">
            <label for="is_funded_yes" class="ff-label-radio" />Yes
            <input type="radio" id="is_funded" name="is_funded" value="yes" />

            
            <label for="is_funded_no" class="ff-label-radio" />No
            <input type="radio" id="is_funded" name="is_funded" value="no" />
            </div>
                      
			<!--- This will need a loop --->
            <div class="raa-block-2">
            <label for="req_appr_auth" class="raa-label" />Org Approval Authority
             <select name="req_appr_auth" class="form-field-input">
             	<option value="">Select Org Approver</option>
                <cfloop query="getOrgApprovers">
                	<option value="#cac_edipi#">#gal_displayname#</option>
                </cfloop>
             </select>    
            </div>
            </fieldset>
           </div>
           
           <br style="clear: both;" />

           
           <!--- The divs below go together --->
           <div class="fb-6-container">
           <div class="form-block-6">
            <label for="requirement" class="ff-label" />Requirement
            <textarea type="text" rows="6" cols="100" id="itnss_description" name="itnss_description" class="form-field-input" placeholder="Enter Description of Request"></textarea>
           </div>
           
           <!--- NOT NEEDED (3/23/2018 cm) 
           <div class="form-block-6">
            <label for="comp_supp_assist" class="ff-label-radio" />AFRL/RQOC Computer Support Personnel assisted with Requirement
            <input type="radio" name="comp_supp_assist" value="yes">Yes
            <input type="radio" name="comp_supp_assist" value="no">No
           </div>
		   --->
           
           <div class="form-block-6">
            <label for="staff_mem" class="ff-label" />Requirement assistance provided by 
             <select id="itnss_description_staff_cacedipi" name="itnss_description_staff_cacedipi">
				<option value="">Select AFRL/RQOC Staff Member</option>
                <cfloop query="getRQOC">                
                <option value="#getRQOC.cac_edipi#">#getRQOC.fullname#</option>
                </cfloop>
             </select>   
           </div>
           </div>
           <!--- --->

           
           <!--- The divs below go together --->
           <div class="fb-6-container">
           <div class="form-block-6">
            <label for="justification" class="ff-label" />Justification
            <textarea type="text" rows="6" cols="100" id="itnss_justification" name="itnss_justification" class="form-field-input" placeholder="Enter Justification for Request"></textarea>
           </div>
           
           <!--- NOT NEEDED (3/23/2018 cm) 
           <div class="form-block-6">
            <label for="comp_supp_assist" class="ff-label-radio" />AFRL/RQOC Computer Support Personnel assisted with Justification
            <input type="radio" name="comp_supp_assist" value="yes">Yes
            <input type="radio" name="comp_supp_assist" value="no">No
           </div>
		   --->
           
           <div class="form-block-6"><!--- This will need a loop --->
            <label for="staff_mem" class="ff-label" />Justification assistance provided by 
             <select id="itnss_justification_staff_cacedipi" name="itnss_justification_staff_cacedipi">
              	<option value="">Select AFRL/RQOC Personnel</option>
                <cfloop query="getRQOC">                
                <option value="#getRQOC.cac_edipi#">#getRQOC.fullname#</option>
                </cfloop>
             </select>   
           </div>
           </div>
           
           
           <!--- The divs below go together --->
           <div class="fb-6-container">
               <div class="form-block-6">
                <label for="tech_sol" class="ff-label form-field-input" />Technical Solution
                <textarea type="text" rows="6" cols="100" id="itnss_solution" name="itnss_solution"  class="form-field-input" placeholder="Enter Technical Solution for Request"></textarea>
               </div>
               
               <div class="form-block-7">
                <!--- NOT NEEDED (3/23/2018 cm) 
                <label for="comp_supp_assist" class="ff-label-radio" />AFRL/RQOC Computer Support Personnel assisted with Technical Solution
                <input type="radio" name="comp_supp_assist" value="yes">Yes
                <input type="radio" name="comp_supp_assist" value="no">No
				--->
                
				<!--- This will need a loop --->
                <label for="staff_mem" class="ff-label" />Technical Solution assistance provided by 
                 <select id="itnss_solution_staff_cacedipi" name="itnss_solution_staff_cacedipi">
                  	<option value="">Select AFRL/RQOC Personnel</option>
                    <cfloop query="getRQOC">                
                    <option value="#getRQOC.cac_edipi#">#getRQOC.fullname#</option>
                    </cfloop>
                 </select>
               </div>
           </div>
           
           <input type="submit" value="Submit">
           <!---  --->
          
          </fieldset> 
        </form>
    </div>
    
	<br style="clear:both;">
	
</div>
<br style="clear:both;">


</div>
</cfoutput>


        
        
        
	



