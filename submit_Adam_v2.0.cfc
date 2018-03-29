<cfcomponent>
<cfparam name="process_id" default="1">

<cffunction name="newRequestSubmit" access="remote">
	<cftry>
    
    <!---<cfdump var="#FORM#"><cfabort>--->
    
    
    <!--- Test Data --->
    <cfparam name="FORM.process_id" default="1">
    <cfparam name="FORM.title" default="80inch Microsoft Hub">   
    <cfparam name="FORM.date_needed" default="5/31/2018">
    <cfparam name="FORM.poc" default="1363026911"> <!--- *RENAME --->
    <cfparam name="FORM.is_funded" default="1">
    <cfparam name="FORM.lab_name" default="1">	<!--- * --->
    <cfparam name="FORM.request_type" default="hardware">
    <cfparam name="FORM.fk_network_type_id" default="1">
    <cfparam name="FORM.classification" default="unclassified"> <!--- * --->
    <cfparam name="FORM.itnss_description" default="Description">
    <cfparam name="FORM.itnss_description_staff_cacedipi" default="1363026911">
    <cfparam name="FORM.itnss_justification" default="Justification">
    <cfparam name="FORM.itnss_justification_staff_cacedipi" default="1363026911">
    <cfparam name="FORM.itnss_solution" default="Technical Solution">
    <cfparam name="FORM.itnss_solution_staff_cacedipi" default="1363026911">
    <cfparam name="FORM.itnss_status" default="2">
    <cfparam name="FORM.tracking_number" default="">
    <cfparam name="FORM.request_number" default="">
    <cfparam name="FORM.created_by" default="#session.intranet.user_eipd#"> 
    <cfparam name="FORM.created_date" default="1363026911"> 
    <cfparam name="FORM.last_modified_by" default="#session.intranet.user_eipd#"> <!--- * --->
    <cfparam name="FORM.last_modified_date" default="1363026911"> <!--- * --->
    
    <!--- DOES NOT GET GENERATED AT THIS POINT (3/27/2018 cm) --->
    <!---
    <!--- Generate ITNSS Tracking Number ({org}-{year}-{request number}) --->
    	<!--- Get Process Org --->
        <cfquery name="getProcessOrg" datasource="#APPLICATION.asd#">
            SELECT 	process_org as org
            FROM	process
            WHERE	process_id = #FORM.process_id#
        </cfquery>    
        
        <cfset tnOrg = getProcessOrg.org>
        <cfset tnOrgLen = LEN(tnOrg)>
    	
        <!--- Get Current Year --->
		<cfset tnYear = dateFormat(now(), 'YYYY')>
        
        <!--- Get length of beginning of tracking number (org, -'s and year) --->
        <cfset begTNLen = tnOrgLen + 6> <!--- 6 = year + -'s --->
        
        <!--- Get Request Number --->
        <cfquery name="getTNs" datasource="#APPLICATION.asd#">
            SELECT TOP(1) CAST(SUBSTRING(tracking_number, #begTNLen+1#, (LEN(tracking_number)-#begTNLen#)) AS INT) AS tracking_number
            FROM 	itnss_requirement
            WHERE 	tracking_number LIKE '#tnOrg#-#tnYear#%'
            GROUP BY tracking_number
            ORDER BY tracking_number DESC
        </cfquery>
                        
        <cfset tnNum = getTNs.tracking_number+1>
        <cfset tracking_Number = tnOrg & '-' & tnYear & '-' & tnNum>
    <!--- END Tracking Number --->
	--->
	
    
	<!--- Generates record for new ITNSS Request --->
    <cfquery name="createRequest" datasource="#APPLICATION.asd#" result="qResult">
		INSERT INTO itnss_requirement (
        	title,
            date_needed,
            poc,
            is_funded,
            request_type, 
            fk_network_type_id,
            classification,
            
            itnss_description,
            itnss_description_staff_cacedipi,
            itnss_justification,
            itnss_justification_staff_cacedipi,
            itnss_solution,
            itnss_solution_staff_cacedipi,
			
            itnss_status,
            
            created_by,
            last_modified_by,
            last_modified_date 
        )
    	
        VALUES (
        	<cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.title#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.date_needed#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.poc#">,
            <cfqueryparam cfsqltype="cf_sql_bit" value="#FORM.is_funded#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.request_type#">, 
            <cfqueryparam cfsqltype="cf_sql_integer" value="#FORM.fk_network_type_id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.classification#">,
            
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.itnss_description#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.itnss_description_staff_cacedipi#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.itnss_justification#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.itnss_justification_staff_cacedipi#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.itnss_solution#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.itnss_solution_staff_cacedipi#">,
			
            <cfqueryparam cfsqltype="cf_sql_varchar" value="Draft">,
            
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.intranet.user_eipd#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.intranet.user_eipd#">,
            getDate()
        )
	</cfquery>
	
    <cfset newRequestID = qResult.GENERATEDKEY>
    
    
    
    <!--- Insert Lab Records --->
    <cfloop from="1" to="3" index="i">
        <cfset lab = evaluate("FORM.lab_name#i#")>
     	
        <cfif len(lab) GT 0>
        <cfquery name="insertLab" datasource="#APPLICATION.asd#">
            INSERT INTO itnss_labs (itnss_requirement_id, lab_id)
            VALUES (#newRequestID#, #lab#)
        </cfquery>
        </cfif>
    </cfloop>
    
    
    <!--- DOES NOT GET GENERATED AT THIS POINT (3/27/2018 cm) --->
    <!---
    <!--- Check for existence of request approvers --->
    <cfquery name="verifyParticipants" datasource="#APPLICATION.asd#">
        SELECT	*
        FROM	itnss_approvers
        WHERE	itnss_requirement_id = #newRequestID#
    </cfquery>
    
    <!--- If approvers don't exist, continue... --->
    <cfif verifyParticipants.recordCount EQ 0>
    
        <!--- Insert Approval Records --->
        <cfquery name="getProcessParticipants" datasource="#APPLICATION.asd#">
            SELECT *
            FROM	process_participants
            WHERE	process_id = #process_id#
            ORDER BY sequence
        </cfquery>
        
        <!--- Create record for each participant --->
        <cfloop query="getProcessParticipants">
        <cfquery name="addApprovers" datasource="#APPLICATION.asd#">
            INSERT INTO itnss_approvers (process_participant_id, itnss_requirement_id, sequence)
            VALUES (#process_participant_id#, #newRequestID#, #sequence#)
        </cfquery>
        </cfloop>
    </cfif>
    <!--- Otherwise, do nothing --->
    --->
    
    
    <!--- Redirect to READ ONLY page. --->
	<cflocation url="detail.cfm?msg=success&requestID=#newRequestID#" addtoken="no">

	
    <cfcatch><cfdump var="#cfcatch#"><cfabort></cfcatch>
    
    </cftry>	
</cffunction>
<!--- END NEW REQUEST --->
    
    
<!--- ADAM'S FUNCTION FOR UPDATING RECORDS --->
<cffunction name="update_record" access="remote" returntype="struct" returnformat="json">
<cfset oResponse={}>
<cftry>
    <cfif cgi.request_method IS "post" 
            AND structKeyExists(form,"record_id")
            AND structKeyExists(form,"title")
            AND structKeyExists(form,"date_needed")      
            AND structKeyExists(form,"created_by")                      
            AND structKeyExists(form,"request_type")    
            AND structKeyExists(form,"classification")      
            AND structKeyExists(form,"fk_network_type_id")    
            AND structKeyExists(form,"is_funded")            
            AND structKeyExists(form,"is_funded_authority")
            AND structKeyExists(form,"itnss_description_help")
            AND structKeyExists(form,"itnss_description_staff_cacedipi")
            AND structKeyExists(form,"itnss_description")
            AND structKeyExists(form,"itnss_justification_help")
            AND structKeyExists(form,"itnss_justification_staff_cacedipi")
            AND structKeyExists(form,"itnss_justification")
            AND structKeyExists(form,"itnss_solution_help")
            AND structKeyExists(form,"itnss_solution_staff_cacedipi")
            AND structKeyExists(form,"itnss_solution")
            AND structKeyExists(form,"notes_cso_cto_iao") 
    >           
    
            <cfquery name="update_title" datasource="#APPLICATION.asd#"><!---Update database--->
                UPDATE itnss_requirement
                SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title#" />
                  , date_needed = <cfqueryparam cfsqltype="cf_sql_date" value="#form.date_needed#" />
                  , created_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.created_by#" />
                  , request_type = <cfqueryparam cfsqltype="cf_sql_int" value="#form.request_type#" />
                  , classification = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.classification#" />
                  , fk_network_type_id = <cfqueryparam cfsqltype="cf_sql_int" value="#form.fk_network_type_id#" />
                  , is_funded = <cfqueryparam cfsqltype="cf_sql_int" value="#form.is_funded#" />
                  , is_funded_authority = <cfqueryparam cfsqltype="cf_sql_int" value="#form.is_funded_authority#" />
                  , itnss_description_help = <cfqueryparam cfsqltype="cf_sql_int" value="#form.itnss_description_help#" />
                  , itnss_description_staff_cacedipi = <cfqueryparam cfsqltype="cf_sql_int" value="#form.itnss_description_staff_cacedipi#" />
                  , itnss_description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itnss_description#" />
                  , itnss_justification_help = <cfqueryparam cfsqltype="cf_sql_int" value="#form.itnss_justification_help#" />
                  , itnss_justification_staff_cacedipi = <cfqueryparam cfsqltype="cf_sql_int" value="#form.itnss_justification_staff_cacedipi#" />
                  , itnss_justification = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itnss_justification#" />
                  , itnss_solution_help = <cfqueryparam cfsqltype="cf_sql_int" value="#form.itnss_solution_help#" />
                  , itnss_solution_staff_cacedipi = <cfqueryparam cfsqltype="cf_sql_int" value="#form.itnss_solution_staff_cacedipi#" />
                  , itnss_solution = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.itnss_solution#" />
                  , notes_cso_cto_iao = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.notes_cso_cto_iao#" />
                WHERE itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_int" value="#form.record_id#" />
                
            </cfquery>
            <cfset oResponse.message="success">
    <cfelse>
        <cfthrow message="Missing Information: #record_id#, #title#, #date_needed#, #date_needed#, #created_by#, #request_type#, #classification#, #fk_network_type_id#, #is_funded#, #is_funded_authority#, #itnss_description_help#, #itnss_description_staff_cacedipi#, #itnss_description#, #itnss_justification_help#, #itnss_justification_staff_cacedipi#, #itnss_justification#, #itnss_solution_help#, #itnss_solution_staff_cacedipi#, #itnss_solution#, #notes_cso_cto_iao#
">
    </cfif>
    <cfcatch>
        <cfset oResponse.error="#cfcatch.Message#">
    </cfcatch>
        </cftry>
    <cfreturn oResponse>
</cffunction>




</cfcomponent>