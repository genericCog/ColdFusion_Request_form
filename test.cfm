
<cfparam name="process_id" default="1">
<cfparam name="FORM.lab_name1" default="1">
<cfparam name="FORM.lab_name2" default="2">
<cfparam name="FORM.lab_name3" default="3">

<cfset newRequestID = 16>


<cfloop from="1" to="3" index="i">
        <cfset lab = evaluate("FORM.lab_name#i#")>
    <cfoutput>#lab#</cfoutput>
        </cfloop>
        
        <cfabort>
        
<!--- Check for existence of request approvers --->
<cfquery name="verifyParticipanst" datasource="#APPLICATION.asd#">
	SELECT	*
    FROM	itnss_approvers
    WHERE	itnss_requirement_id = #newRequestID#
</cfquery>

<!--- If approvers don't exist, continue... --->
<cfif verifyParticipanst.recordCount EQ 0>

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
        VALUES (#process_participants_id#, #newRequestID#, #sequence#)
    </cfquery>
    </cfloop>
</cfif>
<!--- Otherwise, do nothing --->

<cfquery name="getApprovers" datasource="#APPLICATION.asd#">
	SELECT *
    FROM itnss_approvers
    ORDER BY sequence
</cfquery>

<cfdump var="#getApprovers#">
