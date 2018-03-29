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

<style>

.form-block-1 {
	display: inline-block;
}

.form-block-2 {
	display: inline-block;
}

.form-block-4 {
	display: inline-block;
	width: 33%;
}

.form-field, 
.form-block-1, 
.form-block-2, 
.form-block-3, 
.form-block-4 {
	padding: 10px;
}

form {
}

.main-fieldset {
	padding: 10px;
	margin: 10px;
}

.main-legend {
	font-weight: bold;
	font-size: 18px;
}

.small-fieldset {
	padding: 10px;
	margin: 10px;
	width: 200px;
}

.small-legend {
	font-weight: bold;
	font-size: 14px;
}

.ff-label {
	padding: 5px;
	display: block;
}

.ff-label-radio {
	font-weight: normal;
	font-size: 14px;
	display: inline-block;
}

.ff-label-radio {
	padding: 5px;
	display: block;
}

textarea {
	width: 75%;
	padding: 10px;
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

input[type=radio] {
}

input[type=submit] {
}

input[type=submit]:hover {
}


</style>
       
	<!--- REQUIRED: FRAMEWORK HEADER *** --->
    <cfinclude template="/framework/rqweb_header.cfm">    
 
 	<!--- Application Navigation--->
    <cfinclude template="/toast/navigation.cfm">  
          
	<!--- APPLICATION CONTENT *** 
    <div style="width:100%; min-height:700px;">
		<cfinclude template="index_main.cfm">--->
        
        <form action="/apagethatprocessesthisform" method="post">
        <fieldset class="main-fieldset">
         <legend class="main-legend">AFRL/RQ Requirements</legend>
           <div class="form-block-1">
        	<label for="req_title" class="ff-label">Requirement Title</label>
        	<input type="text" name="req_title" class="form-field-input">
   		   </div>
           
           <div class="form-block-1">
        	<label for="date_needed" class="ff-label">Date Needed</label>
        	<input type="date" name="date_needed" class="form-field-input">
   		   </div>
           
           <div class="form-block-2">
        	<label for="poc" class="ff-label">Point of Contact</label>
        	<input type="text" name="poc" class="form-field-input">
   		   </div>           
           
           <div class="form-block-2">
            <label for="poc_phone" class="ff-label">Phone Number</label>
            <input type="text" name="poc_phone" class="form-field-input">
           </div>
           
           <div class="form-block-3"><!--- This will need a loop --->
            <label for="org_office" class="ff-label">Organization/Office</label>
             <select name="org_office">
              <option value="org_office">Org/Office</option>
             </select>
           </div>
           
           <div class="form-block-4">
            <label for="lab_name1" class="ff-label">Lab Name</label>
             <select name="lab_name1">
              <option value="lab_name1">Lab Name</option>
             </select>
           </div>
           
           <div class="form-block-4">
            <label for="lab_name2" class="ff-label">Lab Name</label>
             <select name="lab_name2">
              <option value="lab_name2">Lab Name</option>
             </select>
           </div>
           
           <div class="form-block-4">
            <label for="lab_name3" class="ff-label">Lab Name</label>
             <select name="lab_name3">
              <option value="lab_name3">Lab Name</option>
             </select>
           </div>
           
           <div class="form-field">
           <fieldset class="small-fieldset">
            <legend class="small-legend">Type of Request</legend>
            
            <label for="type_request_h" class="ff-label-radio"><span>Hardware</span>
             <input type="radio" id="type_request_h" name="type_request" value="hardware">
            </label>
           
            <label for="type_request_s" class="ff-label-radio"><span>Software</span>
            <input type="radio" id="type_request_s" name="type_request" value="software">
            </label>    
             
           </fieldset>     
           </div>
           
           <div class="form-field">
           <fieldset class="small-fieldset">
            <legend class="small-legend">Associated Network</legend>
            <label for="assoc_network" class="ff-label-radio">
            <input type="radio" id="assoc_network" name="assoc_network" value="nipr"><span>NIPR</span>
            <input type="radio" id="assoc_network" name="assoc_network" value="dren"><span>DREN</span>
            <input type="radio" id="assoc_network" name="assoc_network" value="sipr"><span>SIPR</span>
            <input type="radio" id="assoc_network" name="assoc_network" value="enclave"><span>Enclave</span>
            <input type="radio" id="assoc_network" name="assoc_network" value="standalone"><span>Standalone</span>
            </label>
           </div>
           
           <div class="form-field">
            <label for="classification" class="ff-label">Classification</label>
            <input type="radio" name="classification" value="unclassified">Unclassified
            <input type="radio" name="classification" value="classified">Classified
           </div>
           
           <!--- These two divs below go together --->
           <div class="form-field">
            <label for="is_funded" class="ff-label">Funded</label>
            <input type="radio" name="is_funded" value="yes">Yes
            <input type="radio" name="is_funded" value="no">No
           </div>
           
           <div class="form-field"><!--- This will need a loop --->
            <label for="req_appr_auth" class="ff-label">Request Approval Authority</label>
             <select name="req_appr_auth">
              <option value="req_appr_auth">NAME, PERSONS</option>
             </select>
           </div>
           <!--- These two divs above go together --->
           
                      <!--- The divs below go together --->
           <div class="form-field">
            <label for="requirement" class="ff-label">Requirement</label>
            <textarea type="text" rows="6" cols="100" name="requirement" class="form-field-input">Enter Text</textarea>
           </div>
           
           <div class="form-field">
            <label for="comp_supp_assist" class="ff-label-radio">AFRL/RQOC Computer Support Personnel assisted with Requirement</label>
            <input type="radio" name="comp_supp_assist" value="yes">Yes
            <input type="radio" name="comp_supp_assist" value="no">No
           </div>
           
           <div class="form-field"><!--- This will need a loop --->
            <label for="staff_mem" class="ff-label">AFRL/RQOC Staff Member</label>
             <select name="staff_mem">
              <option value="org_office">NAME, PERSONS</option>
             </select>
            
           </div>
           <!--- The divs above go together --->
           
           
           <!--- The divs below go together --->
           <div class="form-field">
            <label for="justification" class="ff-label">Justification</label>
            <textarea type="text" rows="6" cols="100" name="justification"class="form-field-input">Enter Text</textarea>
           </div>
           
           <div class="form-field">
            <label for="comp_supp_assist" class="ff-label-radio">AFRL/RQOC Computer Support Personnel assisted with Justification</label>
            <input type="radio" name="comp_supp_assist" value="yes">Yes
            <input type="radio" name="comp_supp_assist" value="no">No
           </div>
           
           <div class="form-field"><!--- This will need a loop --->
            <label for="staff_mem" class="ff-label">AFRL/RQOC Staff Member</label>
             <select name="staff_mem">
              <option value="org_office">NAME, PERSONS</option>
             </select>
            
           </div>
           <!--- The divs above go together --->
           
           <!--- The divs below go together --->
           <div class="form-field">
            <label for="tech_sol" class="ff-label" class="form-field-input">Technical Solution</label>
            <textarea type="text" rows="6" cols="100" name="tech_sol"  class="form-field-input">Enter Text</textarea>
           </div>
           
           <div class="form-field">
            <label for="comp_supp_assist" class="ff-label-radio">AFRL/RQOC Computer Support Personnel assisted with Technical Solution</label>
            <input type="radio" name="comp_supp_assist" value="yes">Yes
            <input type="radio" name="comp_supp_assist" value="no">No
           </div>
           
           <div class="form-field"><!--- This will need a loop --->
            <label for="staff_mem" class="ff-label">AFRL/RQOC Staff Member</label>
             <select name="staff_mem">
              <option value="org_office">NAME, PERSONS</option>
             </select>
            
           </div>
           
           <input type="submit" value="Submit">
           <!--- The divs above go together --->
          
          </fieldset> 
		</form>
        
	</div>
    	
    <!--- REQUIRED: FRAMEWORK FOOTER *** --->    	
	<cfinclude template="/framework/rqweb_footer.cfm">

</body>
</html>
