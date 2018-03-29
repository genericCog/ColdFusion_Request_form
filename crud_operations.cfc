<!--- 
Create, Retrieve, Update, Delete
--->
<cfset app_db = "#APPLICATION.asd#">
<cfcomponent>

    <cffunction name="edit_itnss_record" access="public" returntype="query">
    <cfargument name="record_id" type="numeric" required="yes">
        <cfquery name="get_itnss_record" datasource="#app_db#">
            SELECT * FROM itnss_requirement
            WHERE itnss_requirement_id = #ARGUMENTS.record_id#
        </cfquery>
        <cfreturn get_itnss_record>
    </cffunction>



<!---Check for form submit--->
<cfif cgi.request_method IS "post"
  AND structKeyExists(form,"nomenclature")
  AND structKeyExists(form,"costperui")>

  <!---Update database--->
  <CFQUERY datasource="#application.ldets#" name="update_nomenclature">
    UPDATE ldets_nomen
    SET costPerUi = <cfqueryparam cfsqltype="cf_sql_float" value="#form.costPerUi#" />
    WHERE nomenId = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.nomenclature#" />;
  </CFQUERY>

  <!--- Success--->
  <cflocation url="ldets_change_nomen.cfm?m=s&a=#form.nomenclature#"/>
<cfelse>
  <!--- Not submitted --->
  <cflocation url="ldets_change_nomen.cfm?m=n"/>
</cfif>



</cfcomponent>




