
<cfquery name="getRequests" datasource="#APPLICATION.asd#">
	SELECT	*
    FROM 	itnss_requirement
</cfquery>

<!--- Get Requestor Info --->
<cfquery name="getRequestor" datasource="#APPLICATION.asd#">
    SELECT *
    FROM	account_info
    WHERE 	cac_edipi = '#getRequests.poc#'
        AND non_user <> 1
        AND status_code = 1
</cfquery>
<cfset pocFullName = UCASE(getRequestor.first_name & " " & getRequestor.last_name)>


<style type="text/css">
    td{padding:5px;}
    #navmenu{list-style:none;margin-right:25px;padding:10px;}
    #navmenu li{cursor:pointer;padding:10px;}	
    #navmenu li:hover{background-color:#C1EBFF;}

	
    /* User Record Styles */
    .center_item{text-align:center;vertical-align:middle;}
    .indent_item{padding-left:25px;}
    td, th{border-left:1px solid rgba(16, 21, 24, 0.1);}
    .border_none{border-left:none;}
    /*Remove the borders from all table elements*/ 
    table{border:none;}
    thead {background-color:#a7a37e;border:1px solid rgb(224, 220, 183);line-height:35px;}
    tbody tr:nth-child(even) {background-color:rgba(224, 220, 183,0.3);}
    tbody tr:nth-child(even):hover {background-color:rgba(224, 220, 183,0.7);}
    tbody tr{line-height:25px;}
    tbody tr:hover {background-color:rgba(224, 220, 183,0.7);}
    .adam_container{display:flex;justify-content:center;border:1px solid rgba(216,225,244,1.00);width:100%;clear:both;margin:2px 2px;padding:2px 2px;}
    .generic_box{background-color:rgba(224, 220, 183,0.5);border:1px solid rgb(224, 220, 183);min-height:50px;min-width:75px;padding:2.5px 2.5px;margin:2.5px 2.5px;}
    .generic_box:hover{background-color:rgba(224, 220, 183,0.7);border:1px solid rgba(224, 220, 183,0.75);min-height:50px;min-width:75px;padding:2.5px 2.5px;margin:2.5px 2.5px;}	
</style>

<cfoutput>
<div style="margin:25px 0px;">
	<!--- Left Column --->
	<div style="float:left; margin-right:25px;">
    	<ul id="navmenu">
        	<li><a href="new_request.cfm">Generate New ITNSS</a></li>
            <li><a href="list_user_records.cfm">My Submissions</a></li>
            <li><a href="list.cfm">View All Submissions</a></li>
            <li>Advanced Search</li>
        </ul>
        
        <br style="clear:both;">
	</div>
	
    <div id="ticket_tabs" style="float:left; max-width:1350px; width:100%; min-height:700px;">   
        <ul>
            <li><a href="##itnss_tab">ITNSS/3215/CSRD</a></li>
        </ul>
        <div style="float:left; width:100%; max-width:1300px;  min-width:200px;">
            <div style="color:##F00;">       
            <div id="user_info_container" data-itnss="user_record_container" class="adam_container">
            <div class="generic_box"></div>
            <div class="generic_box"></div>
            <div class="generic_box" style="color:red;font-size:14;padding:2px 2px;">
                <strong>NOTICE:&nbsp;&nbsp;</strong>Approval of the ITNSS is required as the first step in any IT ACQUISITION (hardware or software).&nbsp;&nbsp;
                This is not approval to deploy or install as additional steps and approval are needed for management 
                of the IT asset per AFMAN 33-153.&nbsp;&nbsp;Read each approvers comments for further information.
            </div>
            <div class="generic_box"></div>
            <div class="generic_box"></div>
            </div><!--- END user_info_container --->
            </div>
            
            <br style="clear:both;">
            
                <table class="border_none" cellpadding="0" cellspacing="0" style="width:100%">
                <thead>
                    <tr>
                        <th>STATUS</th>
                        <th>TRACKING NUMBER</th>
                        <th>TITLE</th>
                        <th>REQUESTOR</th>
                        <th>SUBMITTED</th>
                    </tr>
                </thead>
                    <tbody>
                <cfloop query="getRequests">
                        <tr>
                            <td class="border_none center_item">#itnss_status#</td>
                            <td class="center_item">RQ-2018-#itnss_requirement_id#</td>
                            <td class="indent_item"><a href="detail.cfm?requestID=#itnss_requirement_id#">#title#</a></td>
                            <td class="center_item">#pocFullName#</td>
                            <td class="center_item">#dateFormat(date_created, 'MM/DD/YYYY')#</td>
                        </tr>
                </cfloop>
                    </tbody>
            </table>
        </div><!--- END table content --->
    </div><!--- END tab container --->
</div><!--- END all content --->
</cfoutput>

<script>
    //Initialize tabs
	$("#ticket_tabs").tabs();
</script>
