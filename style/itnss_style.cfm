<!---<cfparam name="COLORS.windowColor" default="4e5a64">
<cfparam name="COLORS.headerColor" default="959ea0">
<cfparam name="COLORS.backgroundColor" default="e6e6e6">
--->


<cfscript>
	loadColors = [
		{name = "windowColor", defaultColor = "4e5a64"},
		{name = "headerColor", defaultColor = "959ea0"},
		{name = "backgroundColor", defaultColor = "e6e6e6"},
		{name = "backgroundWhite", defaultColor = "ffffff"}
	];
	
	COLORS = {};
	
	for(color in loadColors) {
		getColors = arrayNew(1); //ORMExecuteQuery("from user_setting where user_id = '#session.intranet.user_eipd#' AND name = '#color.name#'");
		COLORS[color.name] = arrayLen(getColors) ? getColors[1].getValue() : color.defaultColor;
	}
	
</cfscript>


<cfoutput>
	<style>
		* {
			margin:0;
			padding:0;
			font-family:"Segoe UI","Segoe WP",Arial,Sans-Serif;
		}
		
		##container {
			background-color:###COLORS.backgroundWhite#;
		}
		
		label {
			font-weight:bold;
		}
		
		.adpeWindow {
			padding:0px;
			border:0px;
			box-shadow:5px 5px 5px rgba(0, 0, 0, 0.2);
			overflow:visible;
			position:fixed;
		}
		
		.adpeWindow .ui-dialog-titlebar {
			background:###COLORS.windowColor#;
			border:0px;
		}
		
		.adpeWindow .ui-dialog-titlebar-close {
			width: 30px;
			height: 30px;
			bottom: 1em;
			right: 0.8em;
			top: 1.6em;
		}
		
		.adpeWindow .ui-dialog-title {
			background:###COLORS.windowColor#;
			font-size:28px;
			padding-left:0px;
			color:##efefef;
		}
		
		.adpeWindow .ui-dialog-content {
			padding:0px;
			overflow:visible;
		}
		
		.adminObject {
			float:left;
			font-size:20px;
			margin:15px;
		}
		
		.adminObject button {
			width:250px;
		}
		
		.ajaxSearchVertBar {
			background-color:###COLORS.windowColor#;
			width:10px;
		}
		
		.selectableList {
			font-size:14px;
			width:calc(100% - 5px);
			border-collapse:collapse;
			margin-right:5px;
		}
		
		.selectableList tr {
			background-color:###COLORS.backgroundColor#;
			color:##3e3e3e;
			padding:5px;
			margin:3px;
			font-weight:bold;
			border-bottom:solid 3px white;
		}
		
		.selectableList th {
			padding:5px;
		}
		
		.selectableList td {
			vertical-align:middle;
			padding:5px;
		}
		
		.selectableList tr:hover {
			cursor:copy;
		}
		
		.selectableList .ui-selecting {
			background:###COLORS.headerColor#;
			color:##efefef;
		}
		
		.selectableList .ui-selecting td {
			color:##efefef;
		}
		
		.selectableList .ui-selected {
			background:###COLORS.windowColor#;
			color:##efefef;
		}
		
		.selectableList .ui-selected td {
			color:##efefef;
		}
		
		.pickList {
			font-size:14px;
			padding:5px;
		}
		
		.pickList table {
			border-collapse:collapse;
		}
		
		.pickList tr {
			background-color:white;
			color:###COLORS.windowColor#;
			padding:5px;
			margin:3px;
			border-bottom:solid 2px white;
		}
		
		.pickList tr:hover {
			cursor:pointer;
			background:##c7c7c7;
			color:##efefef;
		}
		
		.pickList td {
			vertical-align:middle;
			padding:5px;
		}
		
		.selectList {
			padding:2px;
			font-size:5px;
		}
		
		.editControl {
			float:left;
			margin:5px;
		}
		
		.editGrouping {
			float:left;
			margin:5px;
			padding:3px;
			background-color:###COLORS.backgroundWhite#;
			border-radius:2px;
		}
		
		.editInputText {
			font-size:16px;
			border-radius:2px;
			width:auto;
			padding:5px;
		}
		
		.toolbarButton {
			padding-left:0px;
			padding-right:10px;
			font-size:16px !important;
		}
		
		.selectOverflow {
			max-height:500px;
			overflow-y:scroll;
		}
		
		.windowHeaderText {
			font-size:28px;
			vertical-align:central;
			float:left;
			padding-left:35px;
			color:##efefef;
		}
		
		.windowHeader {
			padding:10px;
			vertical-align:middle;
			width:100%;
			height:55px; 
			background-color:##383838;
		}
		
		##container {
		   min-height:100%;
		   position:relative;
		}
		
		##body {
		   padding:0px;
		   padding-bottom:100px;
		}
		
		.content {
			font-weight:bold; 
			font-size:1em; 
			padding:5px 10px;
			padding-bottom:25px;
			color:##333
		}
		
		.softwareButton {
			font-size:12px !important;
		}
		
		.iconButton {
			font-size:0px !important;
		}
		
		.transactionTable {
			width:100%;
			border-collapse:collapse;
		}
		
		.transactionTable td {
			background-color:##eeeeee;
			padding:3px;
		}
		
		.transactionTable tr {
			border:solid 3px white;
		}
		
		.transactionTable th {
			text-align:left;
			padding:3px;
		}
		
		.adpeContentMain {
			margin-top:25px;
			margin-left:8%;
			margin-right:15px;
			min-width:900px;
			max-width:1200px;
		}
		
		.contentHeader {
			font-size:24px;
			font-weight:bold;
			margin-right:25px;
			margin-left:5px
		}
		
		.contentSearch {
			width:550px;
			padding:3px;
			font-size:16px;
		}
		
		.ormSearch input[type=text] {
			width:500px;
			padding:3px;
			font-size:16px;
		}
		
		.ormSearchSmall input[type=text] {
			width:450px;
			padding:3px;
			font-size:16px;
		}
		
		.contentButton {
			padding:5px;
			width:90px;
		}
		
		.ormSearch button {
			width:90px;
			height:35px;
		}
		
		.ormSearch select {
			padding:3px;
			width:50px;
		}
		
		.ormSearchBody {
			width:100%;
		}
		
		.ormSearchItem {
			width:100%;
			margin-top:15px;
			margin-bottom:15px;
			background-color:##efefef;
			height:90px;
			overflow-x:auto;
		}
		
		.ormSearchLinkGroup {
			float:left;
			margin:0px 5px 0px 0px;
			padding:0px;
			padding-left:5px;
			border:0px;
			background-color:###COLORS.backgroundColor#;
			border-radius:2px;
			height:100%;
		}
		
		.ormSearchLinkGroup:hover {
			background-color:##f8f8f8 !important;
			cursor:pointer;
		}
		
		.ormSearchItem p {
			font-size:14px;
			width:auto;
		}
		
		.ormSearchItem label {
			font-size:14px;
		}
		
		.ormSearchItemBar {
			width:15px;
			background-color:###COLORS.windowColor#;
			float:left;
			height:100%;
		}
		
		.ormContentGroup {
			float:left;
			margin:1px 5px 1px 5px;
			overflow:hidden;
		}
		
		.softwareInstalled {
			background-color:##f8f8f8;
			height:28px;
			margin:5px;
		}
		
		.softwareListLinkGrouping {
			float:left;
			margin:0px;
			padding:5px;
			padding-left:8px;
			border:0px;
			background-color:##ebebeb;
			height:100%;
		}
		
		.softwareListLinkGrouping:hover {
			background-color:##f8f8f8;
			cursor:pointer;
		}
		
		.softwareListGrouping {
			float:left;
			margin:0px;
			padding-bottom:5px;
			padding-left:8px;
			border:0px;
			background-color:##f8f8f8;
			height:100%;
			width:300px;
		}
		
		.softwareListItem {
			font-size:12px;
			float:left;
			padding:5px;
			height:100%;
		}
		
		.smallListBar {
			width:8px;
			background-color:###COLORS.windowColor#;
			height:100%;
			float:left;
		}
		
		.ORMButton {
			font-size:0.8em;
		}
	</style>
</cfoutput>

