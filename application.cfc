<cfcomponent>
	
    <cfscript>
		local = {};
		
		local.myComponent = createObject("component", "/framework/app_config");
		init = local.myComponent.init();
		
		frameworkRoot = init.frameworkRoot;
		applicationRoot = init.applicationRoot;
		
		configPath = init.configPath;
		
		configKeys = getProfileSections(configPath);
		
		//Load Framework Defaults
		CONFIG = {
			application = {
				name = init.name,
				root = frameworkRoot,
				rootDirectory = applicationRoot,
				environment = init.environment
			},
			datasource = {
				asd = init.asd
			},
			support = {
				orgname = init.orgname,
				logo = init.logo,
				logourl = init.logourl,
				
				name = init.contactName,
				email = init.contactEmail,
				phone = init.contactPhone,
				phoneDSN = init.contactDSN,
				hdrStyle = init.hdrStyle
			},
			mail = {
				enabled = "false"
			},
			orm = {
				enabled = "false",
				orminclude = ""
			}
			
		};
		
		//Read app config file into CONFIG variable;
		for(section in configKeys) {
			if(!structKeyExists(CONFIG, section)) CONFIG[section] = {};
			for(entry in listToArray(configKeys[section])) {
				CONFIG[section][entry] = getProfileString(configPath, section, entry);
			}
		}
		
		this.name = CONFIG.application.name;				
    	this.sessionManagement = true;
    	this.serverSideFormValidation = false;
		this.sessionTimeout = CreateTimeSpan(0,2,0,0);
		
		//Include ORM settings if enabled in config file;
		//*Requires [enabled=true] and [orminclude={file path}];
		if (CONFIG.orm.enabled) {
			include CONFIG.orm.orminclude;
		}
	
	</cfscript>
    
    <cfsetting showdebugoutput="no">
    
    
    <!--- Runs on application start --->
	<cffunction name="onApplicationStart">
		<cfset LOCAL.success = true>
		
        <!--- Store config data as application data --->
		<cfset APPLICATION.CONFIG = CONFIG>
        
        <cfset APPLICATION.asd = CONFIG.datasource.asd>
		
		<!--- Reload ORM on application start --->
		<cfset ORMReload()>	
		
		<cfreturn LOCAL.success>
	</cffunction>
	
    
	<!--- Runs on session start --->
	<cffunction name="onSessionStart">
    	
    
    </cffunction>
    
    
    
    
    <!--- Runs on request start --->
	<cffunction name="onRequestStart">
		<cfargument name="targetPage" type="string" required="yes">
		<cfset LOCAL.success = true>
		
		<cfif !isNull(URL.appRefresh)>
			<cfset onApplicationStart()>
			<cfset onSessionStart()>
		</cfif>	
        
        	
		<cfreturn LOCAL.success>
	</cffunction>
	
    
	<!--- Runs after onRequestStart --->
	<cffunction name="onRequest">
		<cfargument name="targetPage" type="string" required="yes">
		
       		
        <cfinclude template="#Arguments.targetPage#">
	</cffunction>
	
    
	<!--- Runs after request ends --->
	<cffunction name="onRequestEnd">
		<cfargument type="String" name="targetPage" required=true> 
		
	</cffunction>



	<!--- Runs on uncaught exception --->
	<cffunction name="onError" returnType="void"> 
		<cfargument name="Exception" required=true/> 
		<cfargument name="EventName" type="String" required=true/> 
		
		<cfset rethrow = true>
		
		<cfif (NOT isNull(exception.rootCause.message) AND findNoCase("AbortException", exception.rootCause.message))
			OR (NOT isNull(exception.rootCause.detail) AND findNoCase("AbortException", exception.rootCause.detail))>
			<cfset rethrow = false>
		</cfif>
		
		<cfset ORMFlush()>
		<cfset ORMCloseSession()>
		
		<cfif rethrow>
			<cfthrow object="#exception#">
            
		</cfif>
	</cffunction>
    
    <!--- ***** ERROR (PAGE DOES NOT EXIST) ***** --->
	<cffunction name="onMissingTemplate">
		<cfset error = "nopage">
		<cfinclude template="/framework/error.cfm">
	</cffunction>
</cfcomponent>