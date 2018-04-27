<cfcomponent>
<cfparam name="process_id" default="1">

<cffunction name="newRequestSubmit" access="remote">
    <cfargument name="title" type="string" required="yes">
    <cfargument name="date_needed" type="date" required="yes">
    <cfargument name="fk_network_type_id" type="string" required="no" default="">
    <!--- --->
    <cfdump var="#form#">
    
    <cfif IsDefined("FORM.title")>
        
        <cftry>  
            <!--- ::: New ITNSS Request ::: --->
            <cfquery name="createRequest" datasource="#APPLICATION.asd#" result="qResult">
                INSERT INTO itnss_requirement (
                title
                , date_needed
                , poc
                , is_funded
                , request_type
                , classification            
                , itnss_description
                , itnss_description_staff_cacedipi
                , itnss_justification
                , itnss_justification_staff_cacedipi
                , itnss_solution
                , itnss_solution_staff_cacedipi			
                , itnss_status            
                , created_by
                , last_modified_by
                , last_modified_date 
                )
                
                VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.title#">
                , <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.date_needed#">
                , <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.poc#">
                , <cfqueryparam value="#form.is_funded#" cfsqltype="cf_sql_bit" null="#not len(form.is_funded)#">
                , <cfqueryparam value="#form.request_type#" cfsqltype="cf_sql_varchar" null="#not len(form.is_funded)#">
                , <cfqueryparam value="#form.classification#" cfsqltype="cf_sql_varchar" null="#not len(form.classification)#">
                , <cfqueryparam value="#form.itnss_description#" cfsqltype="cf_sql_varchar" null="#not len(form.itnss_description)#">
                , <cfqueryparam value="#form.itnss_description_staff_cacedipi#" cfsqltype="cf_sql_varchar" null="#not len(form.itnss_description_staff_cacedipi)#">
                , <cfqueryparam value="#form.itnss_justification#" cfsqltype="cf_sql_varchar" null="#not len(form.itnss_justification)#">
                , <cfqueryparam value="#form.itnss_justification_staff_cacedipi#" cfsqltype="cf_sql_varchar" null="#not len(form.itnss_justification_staff_cacedipi)#">
                , <cfqueryparam value="#form.itnss_solution#" cfsqltype="cf_sql_varchar" null="#not len(form.itnss_solution)#">
                , <cfqueryparam value="#form.itnss_solution_staff_cacedipi#" cfsqltype="cf_sql_varchar" null="#not len(form.itnss_solution_staff_cacedipi)#">			
                , <cfqueryparam cfsqltype="cf_sql_varchar" value="Draft">            
                , <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.intranet.user_eipd#">
                , <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.intranet.user_eipd#">
                , getDate()
                )
            </cfquery>
            <!--- ::: END New ITNSS Request ::: --->
            
            <cfset newRequestID = qResult.GENERATEDKEY>
    
            <cfif LEN("#newRequestID#")>
                <!--- ::: Insert Network Type(s) ::: --->
                <cftry>
                    <cfif StructKeyExists(form, "fk_network_type_id")>
                        <cfloop list="#fk_network_type_id#" index="i">
                            <cfquery name="insert_network_list" datasource="#APPLICATION.asd#">
                                INSERT INTO itnss_network_type_link (itnss_requirement_id, itnss_network_type_id)
                                VALUES (<cfqueryparam cfsqltype="cf_sql_int" value="#newRequestID#" >, <cfqueryparam cfsqltype="cf_sql_varchar" value="#i#" >)
                            </cfquery>
                        </cfloop>
                    </cfif>
                    <cfcatch type="Any"><!--- Diagnostic message from the ColdFusion server --->
                        <cfoutput>
                            <h3>Error</h3>
                            <p>#cfcatch.message#</p>
                            <p>Caught an exception, type = #cfcatch.type# </p>
                            <p>The contents of the tag stack are:</p>
                            <cfloop index = i from = 1 to = #ArrayLen(cfcatch.tagContext)#>
                                <cfset sCurrent = #cfcatch.tagContext[i]#>
                                <br>#i# #sCurrent["ID"]# 
                                (#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) 
                                #sCurrent["TEMPLATE"]#
                            </cfloop>
                        </cfoutput>
                        <cfdump var="#form#">
                    </cfcatch> 
                </cftry>
                <!--- ::: END Insert Network Type(s) ::: --->
    
                <!--- ::: Update Lab Name ::: --->
                <cftry>
                    <cfif StructKeyExists(form, "lab_name1")>
                        <cfset lab = evaluate("FORM.lab_name1")>
                        <cfquery name="insertLab" datasource="#APPLICATION.asd#">
                            INSERT INTO itnss_labs (itnss_requirement_id, lab_id)
                            VALUES (#newRequestID#, #lab#)
                        </cfquery>
                    </cfif>
                    <cfcatch type="Any"><!--- Diagnostic message from the ColdFusion server --->
                        <cfoutput>
                            <h3>Error</h3>
                            <p>#cfcatch.message#</p>
                            <p>Caught an exception, type = #cfcatch.type# </p>
                            <p>The contents of the tag stack are:</p>
                            <cfloop index = i from = 1 to = #ArrayLen(cfcatch.tagContext)#>
                                <cfset sCurrent = #cfcatch.tagContext[i]#>
                                <br>#i# #sCurrent["ID"]# 
                                (#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) 
                                #sCurrent["TEMPLATE"]#
                            </cfloop>
                        </cfoutput>
                        <cfdump var="#form#">
                    </cfcatch> 
                </cftry>
                <!--- ::: END Update Lab Name ::: --->
                
                <!--- Redirect to READ ONLY page. --->
                <cflocation url="detail.cfm?msg=success&requestID=#newRequestID#" addtoken="no">
            <cfelse>
                WARNING! Record ID is not defined or is missing.
                <cfdump var="#form#">
            </cfif>
            
            <cfcatch type = "Database">
                <!--- Display Database Error --->
                <H3>You've Thrown a Database <B>Error</B></H3>
                <cfoutput>
                    <!--- Diagnostic message from the ColdFusion server --->
                    <P>#cfcatch.message#</P>
                    <P>Caught an exception, type = #cfcatch.type# </P>
                    <P>The contents of the tag stack are:</P>
                    <cfloop index = i from = 1 to = #ArrayLen(cfcatch.tagContext)#>
                        <cfset sCurrent = #cfcatch.tagContext[i]#>
                        <BR>#i# #sCurrent["ID"]# 
                        (#sCurrent["LINE"]#,#sCurrent["COLUMN"]#) 
                        #sCurrent["TEMPLATE"]#
                    </cfloop>
                </cfoutput>
                <cfdump var="#form#">
            </cfcatch>       
    
            <cfcatch type="Any">
                <cfset oResponse={}>
                <cfset oResponse.error="#cfcatch.message#, #cfcatch.Detail#">
                <div id="" data-itnss="" style="">
                    <cfoutput>
                        <p>ERROR: #oResponse.error#</p>
                        <cfset message_content = "WARNING! newRequestSubmit() Catch Error">
                        <cfthrow message="#message_content#">
                    </cfoutput>
                    <cfdump var="#form#">
                </div>
                <!---<cfdump var="#cfcatch#"><cfabort>--->
            </cfcatch>
            
        </cftry>
        
    <cfelse>
        <h3>WARNING! The 'Title' field is required. </h3>
        <cfdump var="#form#">
    </cfif>
    
    
            
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
        
</cffunction>
<!--- ::: END New ITNSS Request ::: --->



<!--- ::: Edit/Update Record ::: --->
<cffunction name="update_record" access="remote" returntype="struct" returnformat="json">
    <cfargument name="record_id" type="numeric" required="yes">
    <cfargument name="title" type="string"  required="yes">
    <cfargument name="date_needed" type="date" required="yes">
    <cfargument name="created_by" type="numeric" required="no" default="">
    <cfargument name="request_type" type="string" required="no" default="">
    <cfargument name="classification" type="string" required="no" default="">
    <cfargument name="is_funded" type="numeric" required="no" default="0">
    <cfargument name="is_funded_authority" type="numeric" required="no" default="">
    <cfargument name="itnss_description_staff_cacedipi" type="any" required="no" null="#not len(trim(arguments.itnss_description_staff_cacedipi))#">
    <cfargument name="itnss_description" type="string" required="no" default="Nothing Entered">
    <cfargument name="itnss_justification_staff_cacedipi" type="any" required="no" null="#not len(trim(arguments.itnss_justification_staff_cacedipi))#">
    <cfargument name="itnss_justification" type="string" required="no" default="Nothing Entered">               
    <cfargument name="itnss_solution_staff_cacedipi" type="any" required="no" null="#not len(trim(arguments.itnss_solution_staff_cacedipi))#">
    <cfargument name="itnss_solution" type="string" required="no" default="Nothing Entered">
    <cfargument name="notes_cso_cto_iao" type="string" required="no" default="Nothing Entered"> 
    <cfargument name="acq_purchase_vehicle" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_gpc_log_cross_reference" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_funding_source" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_fund_cite" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_afway_waiver_number" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_afway_rfq_number" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_afway_tracking_number" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_afway_order_number" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_vendor_awarded" type="string" required="no" default="Nothing Entered">
    <cfargument name="acq_date_ordered" type="any" required="no" null="#not len(trim(arguments.acq_date_ordered))#">
    <cfargument name="acq_comments" type="string" required="no" default="Nothing Entered">
    <cfargument name="network_type_list" type="string" required="no" default="">
    <cfargument name="lab_name" type="any" required="no" null="#not len(trim(arguments.lab_name))#">
    <cfset oResponse={}>
    <cfset date_today = Now()>
    <cftry> 
        <cfif cgi.request_method IS "post" 
            AND structKeyExists(form,"record_id")
            AND structKeyExists(form,"title")>
            <cfquery name="update_title" datasource="#APPLICATION.asd#"><!---Update database--->
                UPDATE itnss_requirement
                SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.title#" />
                    , date_needed = <cfqueryparam cfsqltype="cf_sql_date" value="#trim(form.date_needed)#" />
                    , created_by = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.created_by)#" />
                    , request_type = <cfqueryparam cfsqltype="cf_sql_int" value="#trim(form.request_type)#" />
                    , classification = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.classification)#" />
                    , is_funded = <cfqueryparam cfsqltype="cf_sql_int" value="#trim(form.is_funded)#" />
                    , is_funded_authority = <cfqueryparam cfsqltype="cf_sql_int" value="#trim(form.is_funded_authority)#" null="#NOT len(trim(form.is_funded_authority))#" />
                    , itnss_description_staff_cacedipi = <cfqueryparam cfsqltype="cf_sql_int" value="#trim(form.itnss_description_staff_cacedipi)#" null="#NOT len(trim(form.itnss_description_staff_cacedipi))#" />
                    , itnss_description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.itnss_description)#" null="#NOT len(trim(form.itnss_description))#" />
                    , itnss_justification_staff_cacedipi = <cfqueryparam cfsqltype="cf_sql_int" value="#trim(form.itnss_justification_staff_cacedipi)#" null="#NOT len(trim(form.itnss_justification_staff_cacedipi))#" />
                    , itnss_justification = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.itnss_justification)#" null="#NOT len(trim(form.itnss_justification))#" />
                    , itnss_solution_staff_cacedipi = <cfqueryparam cfsqltype="cf_sql_int" value="#trim(form.itnss_solution_staff_cacedipi)#" null="#NOT len(trim(form.itnss_solution_staff_cacedipi))#" />
                    , itnss_solution = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.itnss_solution)#" null="#NOT len(trim(form.itnss_solution))#" />
                    , notes_cso_cto_iao = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.notes_cso_cto_iao)#" null="#NOT len(trim(form.notes_cso_cto_iao))#" />
                    , acq_purchase_vehicle = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_purchase_vehicle)#" null="#NOT len(trim(form.acq_purchase_vehicle))#" />
                    , acq_gpc_log_cross_reference = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_gpc_log_cross_reference)#" null="#NOT len(trim(form.acq_gpc_log_cross_reference))#" />
                    , acq_funding_source = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_funding_source)#" null="#NOT len(trim(form.acq_funding_source))#" />
                    , acq_fund_cite = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_fund_cite)#" null="#NOT len(trim(form.acq_fund_cite))#" />
                    , acq_afway_waiver_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_afway_waiver_number)#" null="#NOT len(trim(form.acq_afway_waiver_number))#" />
                    , acq_afway_rfq_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_afway_rfq_number)#" null="#NOT len(trim(form.acq_afway_rfq_number))#" />
                    , acq_afway_tracking_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_afway_tracking_number)#" null="#NOT len(trim(form.acq_afway_tracking_number))#" />
                    , acq_afway_order_number = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_afway_order_number)#" null="#NOT len(trim(form.acq_afway_order_number))#" />
                    , acq_vendor_awarded = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_vendor_awarded)#" null="#NOT len(trim(form.acq_vendor_awarded))#" />
                    , acq_date_ordered = <cfqueryparam cfsqltype="cf_sql_date" value="#trim(form.acq_date_ordered)#" null="#NOT len(trim(form.acq_date_ordered))#" />
                    , acq_comments = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.acq_comments)#" null="#NOT len(trim(form.acq_comments))#" />
                    WHERE itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_int" value="#form.record_id#" />
            </cfquery>

            <!--- ::: Update Lab Name ::: --->
            <cfquery name="if_exists_lab_name" datasource="#APPLICATION.asd#">
                SELECT *
                FROM itnss_labs 
                WHERE itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.record_id#" >
            </cfquery>
            <cfif if_exists_lab_name.recordCount gt 0>
                <cfquery name="insert_lab_name" datasource="#APPLICATION.asd#">
                    DELETE FROM itnss_labs 
                    WHERE itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.record_id#" >
                </cfquery>
            </cfif>
            <cfquery name="insert_lab_name" datasource="#APPLICATION.asd#">
                INSERT INTO itnss_labs (itnss_requirement_id, lab_id)
                VALUES (<cfqueryparam cfsqltype="cf_sql_int" value="#form.record_id#" >, <cfqueryparam cfsqltype="cf_sql_int" value="#form.lab_name#" >)
            </cfquery>
            <!--- ::: END Update Lab Name ::: --->

            <!--- ::: Update Network Type ::: --->
            <cfquery name="if_exists_network_type_link" datasource="#APPLICATION.asd#">
                SELECT *
                FROM itnss_network_type_link 
                WHERE itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.record_id#" >
            </cfquery>
            <cfif if_exists_network_type_link.recordCount gt 0>
                <cfquery name="delete_network_list" datasource="#APPLICATION.asd#">
                    DELETE FROM itnss_network_type_link 
                    WHERE itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.record_id#" >
                </cfquery>
            </cfif>
            <cfloop list="#network_type_list#" index="i">
                <cfquery name="insert_network_list" datasource="#APPLICATION.asd#">
                    INSERT INTO itnss_network_type_link (itnss_requirement_id, itnss_network_type_id)
                    VALUES (<cfqueryparam cfsqltype="cf_sql_int" value="#form.record_id#" >, <cfqueryparam cfsqltype="cf_sql_int" value="#i#" >)
                </cfquery>
            </cfloop>
            <!--- ::: END Update Network Type ::: --->
            
            <cfset oResponse.message="success">
    <cfelse>
    
    <cfset message_content = "Data Packet: record_id:: #record_id# _|_ title:: #title# _|_ date_needed:: #date_needed# _|_ created_by:: #created_by# _|_ request_type:: #request_type# _|_ network_type_list:: #network_type_list# _|_ classification:: #classification# _|_ is_funded:: #is_funded# _|_ is_funded_authority:: #is_funded_authority# _|_ itnss_description_staff_cacedipi:: #itnss_description_staff_cacedipi# _|_ itnss_description:: #itnss_description# _|_ itnss_justification_staff_cacedipi:: #itnss_justification_staff_cacedipi# _|_ itnss_justification:: #itnss_justification#, itnss_solution_staff_cacedipi:: #itnss_solution_staff_cacedipi# _|_ itnss_solution:: #itnss_solution# _|_ notes_cso_cto_iao:: #notes_cso_cto_iao# _|_ acq_purchase_vehicle:: #acq_purchase_vehicle# _|_ acq_gpc_log_cross_reference:: #acq_gpc_log_cross_reference# _|_ acq_funding_source:: #acq_funding_source# _|_ acq_fund_cite:: #acq_fund_cite# _|_ acq_afway_waiver_number:: #acq_afway_waiver_number# _|_ acq_afway_rfq_number:: #acq_afway_rfq_number# _|_ acq_afway_tracking_number:: #acq_afway_tracking_number# _|_ acq_afway_order_number:: #acq_afway_order_number# _|_ acq_vendor_awarded:: #acq_vendor_awarded# _|_ acq_date_ordered:: #acq_date_ordered# _|_ acq_comments:: #acq_comments#">
        
        <cfthrow message="#message_content#">
        
    </cfif>
    <cfcatch type="Any">
        <cfset oResponse.error="#cfcatch.Message#, #cfcatch.Detail#">
    </cfcatch>
        </cftry>
    <cfreturn oResponse>
</cffunction>
<!--- ::: END Edit/Update Record ::: --->



</cfcomponent>