

<style type="text/css">
.app_mod_header {
	margin-top:10px;
	margin-bottom:5px;
}

.outProcess_desc {
	background-color:#FFF9CF; /*#F9F8E3;*/
	padding:5px;
	margin-bottom:5px;}

.outProcess_status {
	background-color:#EEE;
	padding:5px;
	margin-bottom:5px;
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

.action_bar {
	background-color:#bbb;
	margin-bottom:25px;
	padding:5px;
	text-align:left;}

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
	margin-right:7px;
	margin-top:3px;}
	
.status_box_green {
	height:15px;
	width:15px;
	background-color:#5FE85E;
	border:1px solid #1AAF19;
	float:left;
	margin-right:7px;
	margin-top:3px;}

.status_box_yellow {
	height:15px;
	width:15px;
	background-color:#FFEA33;
	border:1px solid #A39200;
	float:left;
	margin-right:7px;
	margin-top:3px;}
	
#keys {
	cursor:pointer;}
	
#navmenu {
	list-style:none;
	margin-right:25px;
	padding:10px;
}

#navmenu li {
	cursor:pointer;
	padding:10px;}
	
#navmenu li:hover {
	background-color:#C1EBFF;}
	
</style>

<cfoutput>
<div style="margin:25px 0px;">
	<!--- Left Column --->
	<div style="float:left; margin-right:25px;">
    	<ul id="navmenu">
        	<li><a href="new_request.cfm">Generate New ITNSS</a></li>
            <li>My Submissions</li>
            <li><a href="list.cfm">View All Submissions</a></li>
            <li>Advanced Search</li>
        </ul>
        
        <br style="clear:both;">
	</div>
	
    <div style="float:left; max-width:1350px;  min-width:200px;">
    	<h2 style="margin:15px 0px;">ITNSS</h2>
        
        <div style="color:##F00;">
        	<strong>NOTICE:&nbsp;&nbsp;</strong>
            Approval of the ITNSS is required as the first step in any IT ACQUISITION (hardware or software).&nbsp;&nbsp;
            This is not approval to deploy or install as additional steps and approval are needed for management 
            of the IT asset per AFMAN 33-153.&nbsp;&nbsp;Read each approvers comments for further information.
        </div>
    </div>
    
	<br style="clear:both;">
	
</div>
<br style="clear:both;">
</cfoutput>

<script type="text/javascript">
$(function() {
	
});
</script>