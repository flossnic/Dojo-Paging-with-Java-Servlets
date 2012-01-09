<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Paging Example by Prateep Gedupudi</title>

        <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dijit/themes/claro/claro.css" />
<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dojox/grid/resources/Grid.css" />
<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dojox/grid/resources/claroGrid.css" />
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/dojo/1.7/dojo/dojo.js" dojo-data-config="parseOnLoad:true"></script>

        <script type="text/javascript">
            dojo.require("dojox.data.QueryReadStore");
            dojo.require("dojox.grid._CheckBoxSelector");
            dojo.require("dojo.data.ObjectStore");
            dojo.require("dojo.parser");
            dojo.require("dojox.grid.DataGrid");
           
            
            dojo.ready(function(){
            	
            	mystore=new dojox.data.QueryReadStore({url:"/DojoProject/data"});
            	
            	grid = new dojox.grid.DataGrid({
                    store: mystore,
                    structure: [{
                    	type: "dojox.grid._CheckBoxSelector"
                    },[
                        {name:"id", field:"id", width: "200px"},
                        {name:"item", field:"item", width: "200px"},
                        {name:"quantity", field:"quantity", width: "200px"},
                        {name:"cost", field:"cost", width: "200px"},
                        {name:"total", field:"total", width: "200px"}
                    ]]
                },dojo.byId("gridContainer"));
                
                grid.startup();
            });
        </script>
    <head>
    <body class="claro">
        <div id="gridContainer"></div>
    </body>
</html>