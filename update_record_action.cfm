<!--- 
Create, Retrieve, Update, Delete
--->

<cfdump var="#form#" />

<!---Check for form submit--->
<cfif cgi.request_method IS "post"
  AND structKeyExists(form,"record_id")
  AND structKeyExists(form,"req_title")
    <!---  
    
    AND structKeyExists(form,"date_needed")
    AND structKeyExists(form,"rqst_name")
    AND structKeyExists(form,"rqst_phone")
    AND structKeyExists(form,"req_title")
    --->
>

        <cfquery name="update_title" datasource="#APPLICATION.asd#"><!---Update database--->
            UPDATE itnss_requirement
            SET title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.req_title#" />
            WHERE itnss_requirement_id = <cfqueryparam cfsqltype="cf_sql_int" value="#form.record_id#" />
        </cfquery>

<!---<cfabort>--->
  <!--- Success--->
  <cflocation url="update_record.cfm?m=s&a=#form.record_id#"/>
<cfelse>
  <!--- Not submitted --->
  <cflocation url="update_record.cfm.cfm?m=n"/>
</cfif>







