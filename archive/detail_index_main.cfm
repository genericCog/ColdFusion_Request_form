

<style type="text/css">
.app_mod_header {
	margin-top:10px;
	margin-bottom:5px;
}

.outProcess_desc {
	background-color:#F9F8E3;
	padding:5px;
	margin-bottom:5px;}

.outProcess_status {
	background-color:#EEE;
	padding:5px;
	margin-bottom:25px;
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
	margin-right:5px;
	margin-top:5px;}
	
.status_box_green {
	height:15px;
	width:15px;
	background-color:#5FE85E;
	border:1px solid #1AAF19;
	float:left;
	margin-right:5px;
	margin-top:5px;}
	
#keys {
	cursor:pointer;}
</style>

<div style="margin:25px; ">
	<!--- Left Column --->
	<div style="float:left; margin-right:25px;">
    	<img src="ChrisMoore_Normal.jpg" style="height:300px; width:200px; background-color:#F3F3F3; border:1px solid #CCC; ">
        
        <div>
        	<span>CHRISTOPHER MOORE</span><br>
            <span>Wright-Patterson AFB</span><br>
            <span>AFRL/RQOC - Contractor</span><br>
        </div>
        
        <br style="clear:both;">
    </div>
	
    
	<!--- Right (main) Column --->
	<div id="ticket_tabs" style="float:left; width:80%; min-width:200px;">
		<ul>
        	<li><a href="#access_tab">AFRL/RQ Out Process</a></li>
        </ul>
        
        <div id="access_tab" style="margin:10px;">
            
            <div class="outProcess_desc">
            	Submission currently in progress and is awaiting all coordinators / approvers to review.  See status table below.
            </div>
            
            <div class="outProcess_status">
            	<div class="outProcess_status_bar">Out Processing Completion Status (62%)</div>
            </div>
            
            <div  class="app_mod_header">
            	<h3>Employee Information</h3>
            </div>
            
            <cfoutput>
            <div style="float:left; width:50%;">
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<td align="left" style="border-top:1px solid ##666;">User</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">Moore, Chris M</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Office</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">RQOC</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Grade</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">Cont</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Leaving Air Force</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">Yes</div></td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Leaving WPAFB</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">Yes</div></td>
                    </tr>
                    
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Going Where</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">RBOI</div></td>
                    </tr>
                </table>
            </div>
            
            <div style="float:left; width:50%;">
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Last Duty Day</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">2099-11-05</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666;">Official Effective Date <span style="font-size:0.8em;">(Entered by HR)</span></td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">2099-11-05</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Return to Duty Date</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">&nbsp;</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666;">Keeping Badge</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">No</div></td>
                    </tr>
                    
                    </tr>
                </table>
            </div>
            </cfoutput>
            
			
            
            <br style="clear:both;">
            <br style="clear:both;">
            <br style="clear:both;">
            <!---               --->
            
            <div class="app_mod_header">
            	<h3>Out Processing Steps</h3>
                <p>These are the steps that are required for the out processing employee to complete before they leave on their last day.</p>
            </div>
            
            <cfoutput>
            <div id="outSteps">
            	<table cellpadding="15" cellspacing="0" style="width:100%;">
                	<tr style="background-color:##ACD0EF; font-weight:bold; color:##444; ">
                    	<td style="width:250px;">Step</td>
                        <td>Status</td>
                        <td>User</td>
                        <td>Timestamp</td>
                        <td>Comments</td>
                    </tr>
                    
                    <tr>
                    	<td>Supervisor</td>
                        <td><div style="padding:3px;"><div class="status_box"></div><div style="float:left; font-size:1.25em;">Pending</div><br style="clear:both;"></div></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    
                    <tr style="background-color:##EFF6FC">
                    	<td>Personnel</td>
                        <td><div style="padding:3px;"><div class="status_box"></div><div style="float:left; font-size:1.25em;">Pending</div><br style="clear:both;"></div></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    
                    <tr>
                    	<td><div id="keys">Keys / Bldg Access</div></td>
                        <td><div style="padding:3px;"><div class="status_box"></div><div style="float:left; font-size:1.25em;">Pending</div><br style="clear:both;"></div></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    
                    <tr style="background-color:##EFF6FC">
                    	<td>Technical Order Distro Office</td>
                        <td><div style="padding:3px;"><div class="status_box_green"></div><div style="float:left; font-size:1.25em;">Completed</div><br style="clear:both;"></div></td>
                        <td>Souza, Alan</td>
                        <td>2017-10-29 08:06:11</td>
                        <td></td>
                    </tr>
                    
                    <tr>
                    	<td>ADPE</td>
                        <td><div style="padding:3px;"><div class="status_box_green"></div><div style="float:left; font-size:1.25em;">Completed</div><br style="clear:both;"></div></td>
                        <td>Heismann, Richard</td>
                        <td>2017-10-29 12:29:58</td>
                        <td>Equipment reassigned to Hank Grinner</td>
                    </tr>
                                        
                    <tr style="background-color:##EFF6FC">
                    	<td>Security</td>
                        <td><div style="padding:3px;"><div class="status_box"></div><div style="float:left; font-size:1.25em;">Pending</div><br style="clear:both;"></div></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    
                    <tr>
                    	<td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>	
            </div>
            </cfoutput>
            
            <br style="clear:both;">
            <!---               --->
            
            <div class="app_mod_header">
            	<h3>Additional Information</h3>
            </div>
            
            <cfoutput>
            <div style="float:left; width:100%;">
            	<table cellpadding="0" cellspacing="0" style=" width:100%;">
                	<tr>
                    	<td align="left" style="border-top:1px solid ##666; width:250px;">Comments</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##EEE; margin:5px;">
                        I am a retired AFRL civilian employee now currently working as a part-time contractor with MacAulay-Brown Inc. and supporting both AFRL/RYZT and AFLCMC/WIS with my office in RYZT. I will be transitioning to AFLCMC/WIS, Building 46, Area B, beginning 3 Oct 2017.
                        </div></td>
                    </tr>
            	</table>
            </div>
            </cfoutput>
            
            <br style="clear:both;">
            <br style="clear:both;">
            <br style="clear:both;">
            <!---               --->
            
            <cfoutput>
            <div style="background-color:##EEE; padding:10px;">
            <div style="float:left; width:50%;">
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<th colspan="2" style="text-align:left;"><strong>Status Info</strong></th>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Status</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">In Progress</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Tracking ##</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">RQ-2017-011</div></td>
                    </tr>

                    </tr>
                </table>
            </div>
            
            <div style="float:left; width:50%;">
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<th colspan="2" style="text-align:left;"><strong>Record Info</strong></th>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Created</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">2099-11-05 12:36:32</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Created By</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">Moore, Chris M</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Modified</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">2099-11-05 14:11:05</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Modified By</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">Grinner, Henry</div></td>
                    </tr>
                </table>
            </div>
            
            <br style="clear:both;">
            </div>
            
            <div style="background-color:##EEE; padding:10px; padding-bottom:25px;">
            <div style="float:left; width:50%;">
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<th colspan="2" style="text-align:left;"><strong>Milesone Dates</strong></th>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Created</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">2099-11-05 12:36:32</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Submitted for Review</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">2099-11-05 12:59:00</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Completion Date</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">&nbsp;</div></td>
                    </tr>
                </table>
            </div>
            
            <div style="float:left; width:50%;">
            	<table cellpadding="0" cellspacing="0" style=" width:95%;">
                	<tr>
                    	<th colspan="2" style="text-align:left;"><strong>Milestone Metrics</strong></th>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px; width:50%;">Days in Draft</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">0</div></td>
                    </tr>
                    <tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days in Review</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">4</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days From Review to Completed</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">21</div></td>
                    </tr>

					<tr>
                    	<td align="left" style="border-top:1px solid ##666; background-color:##FFF; padding-left:5px;">Days Overall</td>
                        <td style="background-color:##CCC;"><div style="padding:3px; background-color:##F3F3F3; margin:5px;">25</div></td>
                    </tr>
                </table>
            </div>
            
            <br style="clear:both;">
            </div>
            </cfoutput>
            
           
            
            <div class="outProcess_actions" style="border:1px solid #EEE; padding:15px;">
            	<input type="checkbox">&nbsp;&nbsp;<label style="font-weight:normal;">Yes, Out Processing for Chris Moore should be canceled.</label>
                &nbsp;&nbsp;&nbsp;&nbsp;
            	<button type="button" class="cancel_button" title="Cancel Out Processing for Chris Moore" style="color:#F00;">Cancel</button>
            </div>
            
            <br style="clear:both;">
        </div>
	</div>

	<br style="clear:both;">
	
</div>

<script type="text/javascript">
$(function() {
	//Initialize tabs
	$("#ticket_tabs").tabs();
	
	
	$(".cancel_button").button({
		icons: {
			primary: "ui-icon-cancel"
		}
	});
		
	$("#close_button").button({
		icons: {
			primary: "ui-icon-close"
		}
	});
	
	$("#keys").click(function() {
		//openWindow("steps_keys.cfm","","testme","Keys / Bldg Access");	
	});
});
</script>