<%-- 
    Document   : managermap
    Created on : Dec 8, 2016, 1:50:36 PM
    Author     : Amirian
--%>

<%@page import="db.ODBClass"%>
<%@page import="db.Node"%>
<%@page import="db.GraphListItem"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.ArrayList"%> 
<%@page import="java.util.HashMap"%> 
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="db.Edge"%>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title> TF - Map Manager </title>

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
    
    
    Map map = new HashMap();
    map.put("A", "aa");
    map.put("B", "bb");
    map.put("C", "cc");
    
    jsonObj.put("data", map);
    //jsonObj.putOpt("sd", map);
    jsonObj.put("city", "Mumbai"); 
    jsonObj.put("country", "India");
    jsonObj.accumulateAll(map);*/
    
    
    //JSONObject jsonObj= new JSONObject();
    
    /*List<String> Adjacencies = new ArrayList<String>();
    Adjacencies.add("v2");
    Adjacencies.add("v3");
    Adjacencies.add("v4");*/
    
    
    
    
    /*Map nodeData = new HashMap();
    nodeData.put("$color", "#C74243");
    nodeData.put("$type", "circle");
    nodeData.put("$dim", 10);*/
    
   
    
   /* String[] ss = new String[2]; 
    String t="\"v5\"";
    String st1 ="{\"adjacencies\":[" + t + "],\"data\":{\"$color\":\"#C74243\",\"$type\":\"circle\",\"$dim\":10},\"id\":\"v1\",\"name\":\"v1\"}";
    String st2 ="{\"adjacencies\":[],\"data\":{\"$color\":\"#C74243\",\"$type\":\"circle\",\"$dim\":10},\"id\":\"v2\",\"name\":\"v2\"}";
    
    ss[0]=st1;
    ss[1]=st2;*/
    
    JSONObject jsonObj= new JSONObject();
    
    List<String> jsonDataStrings = new ArrayList<String>();
    
    List<Node> nodesList;
    List<GraphListItem> edgesList;
    nodesList = db.ODBClass.getInstance().readAllNodes();
    edgesList = db.ODBClass.getInstance().getGraphForDrawing();
    
    String messageString = "";
    
    /////////////////////////////Request for add new edge or node////////////////////////////////
    if (request.getMethod().equals("POST")) 
    {
        // request for adding a new node
        if (request.getParameter("FormRecognizer").equals("Node")) 
        {
            String newNodeName = request.getParameter("NewNodeName");
            boolean replica = false;
            for(Node node : nodesList)
            {
                if (node.getName().equals(newNodeName)) 
                {
                    replica = true;
                }
            }

            if (replica) 
            {
                //can not add two nodes with same names
                messageString = "you have already a node with name:'" + newNodeName + "'. please choose another name.";
            }
            else
            {
                db.ODBClass.getInstance().insertNode(newNodeName, 0, 0, null);
            }
        }
        
        // request for adding a new edge
        else if (request.getParameter("FormRecognizer").equals("Edge")) 
        {
            String startNodeName =request.getParameter("StartNodeName");
            String endNodeName =request.getParameter("EndNodeName");
            int startNodeId = -1;
            int endNodeId = -1;

            for (Node node : nodesList) 
            {
                if (node.getName().equals(startNodeName) && startNodeId == -1) 
                {
                    if (node.getIdr() != endNodeId) 
                    {
                        startNodeId = node.getIdr();
                        continue;
                    }
                }

                else if (node.getName().equals(endNodeName)&& endNodeId == -1) 
                {
                    if (node.getIdr() != startNodeId) 
                    {
                        endNodeId=node.getIdr();
                        continue;
                    }
                }
            }

            if (startNodeId == -1 || endNodeId == -1) 
            {
                messageString = "can not add the edge, because one or more nodes you entered("+
                        startNodeName + ","+ endNodeName +") does not exist.";
            }
            else{
                db.ODBClass.getInstance().insertEdge(0, 2, startNodeId, endNodeId);
            }
        }
        
        nodesList.clear();
        edgesList.clear();

        nodesList = db.ODBClass.getInstance().readAllNodes();
        edgesList = db.ODBClass.getInstance().getGraphForDrawing();
    }
        
    /////////////////////////////////////////////////////////////
    List<String> Adjacencies = new ArrayList<String>();
    Map nodeData = new HashMap();
    
    for (Node node : nodesList) {
        
            jsonObj.clear();
            Adjacencies.clear();
            jsonObj.accumulate("adjacencies", Adjacencies);
            
            nodeData.clear();
            nodeData.put("$color", "#C74243");
            nodeData.put("$type", "circle");
            nodeData.put("$dim", 10);
            jsonObj.put("data", nodeData);
            
            jsonObj.put("id", node.getName());
            jsonObj.put("name", node.getName());
            
            jsonDataStrings.add(jsonObj.toString());
        }
    
    
    for (GraphListItem edge : edgesList) {
            
            jsonObj.clear();
            
            Adjacencies.clear();
            Adjacencies.add(edge.getDestinationNodeName());
            jsonObj.accumulate("adjacencies", Adjacencies);
            
            nodeData.clear();
            nodeData.put("$color", "#C74243");
            nodeData.put("$type", "circle");
            nodeData.put("$dim", 10);
            jsonObj.put("data", nodeData);
            
            jsonObj.put("id", edge.getStartNodeName());
            jsonObj.put("name", edge.getStartNodeName());
            
            jsonDataStrings.add(jsonObj.toString());
        }
    
%>
<!-- Mohsen JavaScript Codes -->
<script language="javascript" type="text/javascript"> 
        
        var json = [];
        // get data base into Json variable 
	function init()
	{       
            <%  
            for (int i=0; i < jsonDataStrings.size(); i++) {  
            %>  
            json.push(<%=jsonDataStrings.get(i)%>); 
            <%}%>
            DrawGraph();
            document.getElementById('messageLabel').innerHTML = "<%=messageString%>";
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
            
            <form action="./managermap.jsp" method="post">
                <fieldset>
                    <legend>Add Node:</legend>
                    NodeName:<br>
                    <input type="text" name="NewNodeName" value="" id="NewNodeName"><br>
                    <input type="hidden" name="FormRecognizer" value="Node">
                    <br>
                    <input type="submit" value="Add Node">
                </fieldset>
            </form> 
            
            <form action="./managermap.jsp" method="post">
                <fieldset>
                    <legend>Add Edge</legend>
                    Start Node Name:<br>
                    <input type="text" name="StartNodeName" value="" id="StartNodeName"><br>
                    End Node Name:<br>
                    <input type="text" name="EndNodeName" value="" id="EndNodeName"><br>
                    <input type="hidden" name="FormRecognizer" value="Edge">
                    <br>
                    <input type="submit" value="Add Edge">
                </fieldset>
            </form>
            
            <label style="color: red" id="messageLabel"></label>
			<!--
                        <h3>Build Map</h3> 
			<h4>Create New Node:</h4> 
			Node Name:<input type="text" name="NodeName1" id="NewNodeInput"><br>
			<button type="button" onclick="AddNode()">Create Node</button> 
			<br><br>   
			
			<h4>Create New Edge:</h4>
			First Node:<input type="text" name="NodeName2" id="FirsNodeNameInput"><br>
			Second Node:<input type="text" name="NodeName3" id="SecondNodeNameInput"><br>
			<button type="button" onclick="AddEdge()">Create Edge</button>
			<br><br>  -->
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

