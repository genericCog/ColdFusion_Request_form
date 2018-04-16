<cfcomponent>
	<!---establish the root directory on the server where itnss attachments will be stored--->
	<!---if in development environment, save attachments in itnss folder, will need to update production value when final decision made on where to save documents--->
	<cfif application.config.application.environment EQ "Development">
    	<cfset this.dir=expandPath("./")&"attachments_upload_DEV\">
	<cfelse>
		<cfset this.dir="\\52zhtv-as-720v\AFRL.RQ-Working\itnss\">
    </cfif>
<!---for Testing
    <cffunction name="showDIR" access="remote">
    	<cfif application.config.application.environment EQ "Development">
			<cfset tempDir="">
        <cfelse>
            <cfset tempDir="\\">
        </cfif>
		<cfloop list="#this.dir#" delimiters="\" index="i">
        	<cfset tempDir=tempDir&i&"\">
            <p><cfoutput>#tempDir#</cfoutput></p>
        </cfloop>
    </cffunction>--->
    
    <cffunction name="createDIR" access="private" returntype="boolean">
    	<cftry>
        	<cfif application.config.application.environment EQ "Development">
				<cfset tempDir="">
            <cfelse>
                <cfset tempDir="\\">
            </cfif>
        	<cfloop list="#this.dir#" delimiters="\" index="i">
            	<cfset tempDir=tempDir&i&"\">
                <cfif !directoryExists(tempDir)>
                	<cfdirectory action="create" directory="#tempDir#">
                </cfif>
            </cfloop>
        	<cfreturn true>
            <cfcatch>
                <cfreturn false>
            </cfcatch>
        </cftry>
    </cffunction>
    
	<cffunction name="upload_attachment" access="remote" returntype="struct" returnformat="json">
    	<cfargument name="requestID" type="numeric" required="no" default="0">
        <cfargument name="requirement_id" type="numeric" required="yes">
        <cfargument name="fileName" type="string" required="yes">
        <cfargument name="file" required="yes">
        <cftry>
        	<cfif !structKeyExists(cgi,"cert_subject")>
            	<cfthrow message="Invalid User" detail="Invalid user credentials supplied">
            <cfelse>
            	<cfset edipi=trim(listLast(cgi.cert_subject,"."))>
            	<cfquery name="user_id" datasource="#APPLICATION.asd#">
                    SELECT	id
                    FROM	account_info
                    WHERE 	cac_edipi=<cfqueryparam cfsqltype="cf_sql_varchar" value="#edipi#">
                </cfquery>
                <cfif user_id.recordCount NEQ 1>
                	<cfthrow message="Invalid User" detail="Unable to locate uploader user information">
                <cfelse>
                	<!---upload file, commented until directory value is set--->
                    	<cfif !directoryExists(this.dir)>
                        	<cfinvoke method="createDIR" returnvariable="dirCreated"></cfinvoke>
                        </cfif>
                        <cfset fileDir=this.dir&arguments.requirement_id&"\">
                        <cfif !directoryExists(fileDir)>
                        	<cfdirectory action="create" directory="#fileDir#">
                        </cfif>
                        <cffile	action="upload"
                        		destination="#fileDir##arguments.fileName#"
                            	filefield="file"
                            	nameconflict="makeunique"
                            	result="local.upload">
                    <cfquery name="insert_attachment" datasource="#application.asd#">
                    	DECLARE	@new_attachment TABLE (
							id int,
							name varchar(1000),
							size int,
							m_on datetime,
							m_by int
							)
                        INSERT	itnss_attachments (
                        	itnss_requirement_id,
                            name,
                            directory,
                            size,
                            uploaded_by
                            )
                        OUTPUT	inserted.id,
                        		inserted.name,
                                inserted.size,
                                inserted.uploaded_on,
                                inserted.uploaded_by 
                        INTO	@new_attachment
                        VALUES	(
                        	<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.requirement_id#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#local.upload.serverFile#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#local.upload.serverDirectory#\">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#local.upload.fileSize#">,
                            <cfqueryparam cfsqltype="cf_sql_integer" value="#user_id.id[1]#">
                        	)
                           
                       	SELECT	*
                       	FROM	@new_attachment
                    </cfquery>
                    <cfset oReturn={
						"requestID":arguments.requestID,
						"id":insert_attachment.id[1],
						"name":insert_attachment.name[1],
						"size":string_formatSize(insert_attachment.size[1]),
						"by":string_formatName(insert_attachment.m_by[1]),
						"on":"#dateformat(insert_attachment.m_on[1],'mm/dd/yyyy')#"
						}>
                </cfif>
            </cfif>
            <cfcatch>
                <cfset oReturn={
					"requestID":arguments.requestID,
                    "error":"#cfcatch.message#",
                    "detail":"#cfcatch.detail#"
                    }>
            </cfcatch>
        </cftry>
        <cfreturn oReturn>
    </cffunction>
    
    <cffunction name="download_attachment" access="remote">
    	<cfargument name="attachment_id" type="numeric" required="yes">
        <!---may need to add a security check here to prevent accessing files remotely--->
		<cfquery name="select_file" datasource="#application.asd#">
        	SELECT	name,
            		directory
            FROM	itnss_attachments
            WHERE	id=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.attachment_id#">
        </cfquery>
        <cfif fileExists(select_file.directory[1]&select_file.name[1])>
        	<cfheader name="Content-Disposition" value="attachment; filename=#select_file.name[1]#">
        	<cfcontent file="#select_file.directory[1]##select_file.name[1]#">
        <cfelse>
        	ERROR RETRIEVING FILE
        </cfif>
    </cffunction>
    
    <cffunction name="string_formatSize" access="public" returntype="string">
    	<cfargument name="n" type="numeric" required="yes">
        <cfset iterationCount=0>
        <cfloop condition="arguments.n GTE 1000">
        	<cfset arguments.n=arguments.n/1000>
            <cfset iterationCount++>
        </cfloop>
        <cfswitch expression="#iterationCount#">
        	<cfcase value="0">
            	<cfset s="b">
            </cfcase>
            <cfcase value="1">
            	<cfset s="Kb">
            </cfcase>
            <cfcase value="2">
            	<cfset s="Mb">
            </cfcase>
            <cfcase value="3">
            	<cfset s="Gb">
            </cfcase>
            <cfcase value="4">
            	<cfset s="Tb">
            </cfcase>
            <cfdefaultcase>
            	<cfset s="x10^"&(iterationCount*3)&" bytes">
            </cfdefaultcase>
        </cfswitch>
        <cfset s=ROUND(arguments.n*100)/100&s>
        <cfreturn s>
    </cffunction>
    
    <cffunction name="string_formatName" access="public" returntype="string">
    	<cfargument name="n" type="numeric" required="yes">
        <cfquery name="select_user" datasource="#application.asd#">
        	SELECT 	last_name+', '+first_name+' '+middle_initial AS 'name'
            FROM	account_info
            WHERE	id=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.n#">
        </cfquery>
        <cfreturn select_user.name[1]>
    </cffunction>
    
    <cffunction name="query_attachments" access="public" returntype="query">
    	<cfargument name="requirement_id" type="numeric" required="no">
        <cfargument name="user_id" type="numeric" required="no">
        <cfquery name="get_attachments" datasource="#application.asd#">
            SELECT	id,
                    name,
                    CAST(size AS varchar) AS 'size',
                    CAST(ISNULL(modified_on,uploaded_on) AS varchar) AS mod_date,
                    CAST(ISNULL(modified_by,uploaded_by) AS varchar) AS mod_user
            FROM	itnss_attachments
            <cfset filterCount=0>
            <cfif structKeyExists(arguments,"requirement_id")>
            	<cfif filterCount EQ 0>WHERE<cfelse>AND</cfif>
            	itnss_requirement_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.requirement_id#">
                <cfset filterCount++>
            </cfif>
           <cfif structKeyExists(arguments,"user_id")>
            	<cfif filterCount EQ 0>WHERE<cfelse>AND</cfif>
            	(uploaded_by=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
                OR modified_by=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">)
                <cfset filterCount++>
            </cfif>
        </cfquery>
        <cfloop query="get_attachments">
        	<cfset querySetCell(get_attachments,"mod_date",dateFormat(get_attachments.mod_date,"mm/dd/yyyy"),currentRow)>
            <cfset querySetCell(get_attachments,"mod_user",string_formatName(get_attachments.mod_user),currentRow)>
			<cfset querySetCell(get_attachments,"size",string_formatSize(get_attachments.size),currentRow)>
            
        </cfloop>
        <cfreturn get_attachments>
    </cffunction>
    
    <cffunction name="json_attachments" access="remote" returntype="struct" returnformat="json">
    	<cfargument name="requestID" type="numeric" required="no" default="0">
    	<cfargument name="requirement_id" type="numeric" required="no">
        <cfargument name="user_id" type="numeric" required="no">
        <cfinvoke method="query_attachments" returnvariable="get_attachments">
        	<cfif structKeyExists(arguments,"requirement_id")>
            	<cfinvokeargument name="requirement_id" value="#arguments.requirement_id#">
            </cfif>
           <cfif structKeyExists(arguments,"user_id")>
            	<cfinvokeargument name="user_id" value="#arguments.user_id#">
            </cfif>
        </cfinvoke>
        <cfset oReturn={
			"requestID":arguments.requestID,
			"attachments":[]
			}>
        <cfloop query="get_attachments">
        	<cfset attachment={
				"id":get_attachments.id,
				"name":"#get_attachments.name#",
				"size":"#get_attachments.size#",
				"mod_date":"#get_attachments.mod_date#",
				"mod_user":"#get_attachments.mod_user#"
				}>
        	<cfset arrayAppend(oReturn.attachments,attachment)>
        </cfloop>
        <cfreturn oReturn>
    </cffunction>
</cfcomponent>