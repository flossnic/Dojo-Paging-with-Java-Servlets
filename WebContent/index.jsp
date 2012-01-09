<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/dojo/1.7.1/dojo/dojo.js" data-dojo-config="parseOnLoad: true"></script>
<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dojox/grid/resources/Grid.css" />
<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dojox/grid/resources/claroGrid.css" />
<script type="text/javascript">
	dojo.require("dijit.form.TextBox");
	dojo.require("dijit.form.RadioButton");
	dojo.require("dijit.TitlePane");
	dojo.require("dojox.grid.DataGrid");
	dojo.require("dojo.data.ItemFileReadStore");
	dojo.require("dojo.data.ItemFileWriteStore");
	dojo.require("dijit.Dialog");
	dojo.require("dojo.store.JsonRest");
	dojo.require("dojo.data.ObjectStore");
	dojo.require("dojo.io.script");
	function collapse(){
		
		dijit.byId("titlepane1")._setOpenAttr(true,true);
	}
	function expand(){
		dijit.byId("titlepane1")._setOpenAttr(false,true);
	}
	function datagrid(){
		
	}
	dojo.addOnLoad(function(){
			var layout=[{
				field: 'from_user',
	            name: 'from_user',
	            width: '50%'
			},
			{
				field: 'text',
	            name: 'text',
	            width: '50%'
			}];
			
			var myStore;
			 
			dojo.io.script.get({
		        // The URL to get JSON from Twitter
		        url: "http://search.twitter.com/search.json",
		        // The callback paramater
		        callbackParamName: "callback", // Twitter requires "callback"
		        // The content to send
		        content: {
		            q: "pradeep4566" // Searching for tweets about Dojo
		        },
		        // The success callback
		        load: function(tweetsJson) {  // Twitter sent us information!
		        	console.log(tweetsJson);
		        	myStore = new dojo.store.JsonRest({target:tweetsJson});
		        	console.log(myStore.query(results));
		        }
		    });
		
			
			var datastore=new dojo.data.ItemFileReadStore({
				url:"http://search.twitter.com/search.json?q=pradeep4566",
				clearOnClose:true,
				urlPreventCache:true
			});
			
			var datastore1=new dojo.data.ItemFileWriteStore({
				url:"http://localhost:8080/Demo/getNotificationListView?method=list&orgid=737557"
				/*clearOnClose:true,
				urlPreventCache:true*/
			});
			
			var grid=new dojox.grid.DataGrid({
				structure:layout,
				store:datastore1,
				rowsPerPage: 10,
				style: "width:100%"
			},
			dojo.byId("gridContainer")
			);
			//grid.startup();			
	});
</script>
<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dijit/themes/claro/claro.css" media="all" />
<title>Insert title here</title>
</head>
<body class="claro">
	<div id="gridContainer"></div>
	<div data-dojo-type="dijit.TitlePane" title="Title" open="false" id="titlepane1" class="titlepaneuse">
		<p>I am content</p>
	</div>
	<div data-dojo-type="dijit.TitlePane" title="Title" open="false" id="titlepane2" class="titlepaneuse">
		<p>I am content2</p>
	</div>
	<div data-dojo-type="dijit.TitlePane" title="Title" open="false" id="titlepane3" class="titlepaneuse">
		<p>I am content3</p>
	</div>
	<div data-dojo-type="dijit.TitlePane" title="Title" open="false" id="titlepane4" class="titlepaneuse">
		<p>I am content4</p>
	</div>
	
	<a href="javascript:collapse();">Collapse All</a><br /><a href="javascript:expand();">Expand All</a>
</body>
</html>