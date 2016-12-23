<%-- 
    Document   : managermap
    Created on : Dec 8, 2016, 1:50:36 PM
    Author     : Amirian
--%>



<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%> 
<%@page import="java.util.HashMap"%> 
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title> TaxiFinder - Map </title>

<!-- CSS Files -->
<link type="text/css" href="../css/base.css" rel="stylesheet" />
<link type="text/css" href="../css/ForceDirected.css" rel="stylesheet" />

<!--[if IE]><script language="javascript" type="text/javascript" src="../../Extras/excanvas.js"></script><![endif]-->

<!-- JIT Library File -->
<script language="javascript" type="text/javascript" src="../js/jit.js"></script>

<!-- Example File -->
<script language="javascript" type="text/javascript" src="../js/MapGraph.js"></script>


<%
    /*List<String> list = new ArrayList<String>();
		list.add("Sunday");
		list.add("Monday");
		list.add("Tuesday");
		
		
                
    JSONObject jsonObj= new JSONObject(); 
    
    
    jsonObj.accumulate("weekdays", list);
    //jsonObj.
    
    Map map = new HashMap();
    map.put("A", "aa");
    map.put("B", "bb");
    map.put("C", "cc");
    
    jsonObj.put("data", map);
    //jsonObj.putOpt("sd", map);
    jsonObj.put("city", "Mumbai"); 
    jsonObj.put("country", "India");
    jsonObj.accumulateAll(map);*/
    JSONObject jsonObj= new JSONObject();
    
    List<String> Adjacencies = new ArrayList<String>();
    Adjacencies.add("v2");
    Adjacencies.add("v3");
    Adjacencies.add("v4");
    
    /*Map adData = new HashMap();
    adData.put("$color", "#C74243"); 
    jsonObj.put("", value)*/
    
    Map nodeData = new HashMap();
    nodeData.put("$color", "#C74243");
    nodeData.put("$type", "circle");
    nodeData.put("$dim", 10);
    
    
    jsonObj.accumulate("adjacencies", Adjacencies);
    jsonObj.put("data", nodeData);
    
    jsonObj.put("id", "v1"); 
    jsonObj.put("name", "v1");
    
    String aaaa = jsonObj.toString();
    
    String[] ss = new String[2]; 
    String t="\"v5\"";
    String st1 ="{\"adjacencies\":[" + t + "],\"data\":{\"$color\":\"#C74243\",\"$type\":\"circle\",\"$dim\":10},\"id\":\"v1\",\"name\":\"v1\"}";
    String st2 ="{\"adjacencies\":[],\"data\":{\"$color\":\"#C74243\",\"$type\":\"circle\",\"$dim\":10},\"id\":\"v2\",\"name\":\"v2\"}";
    
    ss[0]=st1;
    ss[1]=st2;
    
    //Object obj = parser.parse(s);
    //org.json.simple.JSONArray array = (JSONArray)obj;
%>
<!-- Mohsen JavaScript Codes -->
<script language="javascript" type="text/javascript"> 
        
        var json = [];
        // get data base into Json variable 
	function init()
	{       
                alert('<%=aaaa%>');
		
                json.push(<%=aaaa%>);
                DrawGraph(); 
	}
        
        function temp()
        {
            <%  
            for (int i=0; i < ss.length; i++) {  
            %>  
            json.push(<%=ss[i]%>);
            <%}%>
        }
	
	function AddNode()
	{
		document.getElementById("infovis").innerHTML=""; 
		var node_name = document.getElementById('NewNodeInput').value;
		json.push({"adjacencies":[],"data":{"$color":"#C74243","$type":"circle","$dim":10},"id":node_name,"name":node_name});
                DrawGraph();
	}
	
	function AddEdge()
	{
		document.getElementById("infovis").innerHTML="";
		var node_name1 = document.getElementById('FirsNodeNameInput').value;
		var node_name2 = document.getElementById('SecondNodeNameInput').value;
		json.push({"adjacencies":[node_name2],"data":{"$color":"#C74243","$type":"circle","$dim":10},"id":node_name1,"name":node_name1});
		DrawGraph();
	}

	
	
	
</script>
</head>

<body onload="init();">
<div id="container">

<div id="left-container">
        <div class="text">
			<h3>Build Map</h3> 
			<h4>Create New Node:</h4> 
			Node Name:<input type="text" name="NodeName1" id="NewNodeInput"><br>
			<button type="button" onclick="AddNode()">Create Node</button> 
			<br><br>   
			
			<h4>Create New Edge:</h4>
			First Node:<input type="text" name="NodeName2" id="FirsNodeNameInput"><br>
			Second Node:<input type="text" name="NodeName3" id="SecondNodeNameInput"><br>
			<button type="button" onclick="AddEdge()">Create Edge</button>
			<br><br>  
        </div>

        <div id="id-list"></div>
</div>

<div id="center-container">
    <div id="infovis"></div>  
</div>

<div id="right-container">

<div id="inner-details"></div>

</div>

<div id="log"></div>
</div>
</body>
</html>

