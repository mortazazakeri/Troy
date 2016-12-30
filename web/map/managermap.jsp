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
<%@page import="db.GraphVisualyzer"%>


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

<!-- Mohsen Created Functions -->
<script language="javascript" type="text/javascript" src="../js/my_Functions.js"></script>


<%
    
    GraphVisualyzer graphVis = new GraphVisualyzer();
    List<String> jsonDataStrings = new ArrayList<String>();
    String messageString = "";
    
    /////////////////////////////Request for add new EDGE or NODE////////////////////////////////
    if (request.getMethod().equals("POST")) 
    {
        // request for adding a new node
        if (request.getParameter("FormRecognizer").equals("Node")) 
        {
            String newNodeName = request.getParameter("NewNodeName");
            int latitude = Integer.parseInt(request.getParameter("latitude"));
            int langtitude = Integer.parseInt(request.getParameter("langtitude"));
            
            if (graphVis.isAlredyDefinedNode(newNodeName))
            {
                //can not add two nodes with same names
                messageString = "you have already a node with name:'" + newNodeName + "'. please choose another name.";
            }
            else
            {
                db.ODBClass.getInstance().insertNode(newNodeName, latitude, langtitude, null);
            }
        }
        
        // request for adding a new edge
        else if (request.getParameter("FormRecognizer").equals("Edge")) 
        {
            String startNodeName =request.getParameter("StartNodeName");
            String endNodeName =request.getParameter("EndNodeName");
            
            int[] nodesId = new int[2];
            nodesId = graphVis.getNodeIds(startNodeName, endNodeName);
            
            if (nodesId[0] == -1 || nodesId[1] == -1)
            {
                messageString = "can not add the edge, because one or more nodes you entered (" +
                        startNodeName + "," + endNodeName + ") does not exist.";
            }
            else if (graphVis.isAlredyDefinedEdge(startNodeName, endNodeName)) 
            {
                messageString = "can not add the edge (" +
                        startNodeName + ","+ endNodeName + "). this edge is already exist.";  
            }
            else
            {
                float distance = Float.parseFloat(request.getParameter("distance"));
                int trafficNumber = 0;
                String traffic = request.getParameter("traffic");
                if (traffic.equals("low")) 
                {
                     trafficNumber = 1;   
                }
                else if(traffic.equals("medium")) 
                {
                     trafficNumber = 2;    
                }
                else if(traffic.equals("high")) 
                {
                     trafficNumber = 3;    
                }
                
                db.ODBClass.getInstance().insertEdge(distance, trafficNumber, nodesId[0], nodesId[1]);
                db.ODBClass.getInstance().insertEdge(distance, trafficNumber, nodesId[1], nodesId[0]);
            }
        }
        
    }
    
    jsonDataStrings = graphVis.getJsonDataInStringList();
%>
<!-- Mohsen JavaScript Codes -->
<script language="javascript" type="text/javascript"> 
        var selectedNodeName;
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
                    Latitude:<br>
                    <input type="text" name="latitude" value="0" id="latitude"><br>
                    Langtitude:<br>
                    <input type="text" name="langtitude" value="0" id="langtitude"><br>
                            
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
                    Traffic:<br>
                    <select name="traffic"> 
                        <option value="low">Low</option>
                        <option value="medium">Medium</option>
                        <option value="high">High</option>
                    </select>
                    <br>
                    Distance:<br>
                    <input type="text" name="distance" value="0"> <br>
                    <input type="submit" value="Add Edge">
                </fieldset>
            </form>
            
            <label style="color: red" id="messageLabel"></label>
			
        </div>

        <div id="id-list"></div>
</div>

<div id="center-container">
    <div id="infovis"></div>  
</div>

<div id="right-container">

    <div id="inner-details"></div>
    
    <form action="./editNode.jsp" method="post" style="visibility:hidden" id="editForm">
        <input type="hidden" name="editNodeName" id="editNodeName">
        <input type="hidden" name="FormRecognizer" value="editForm">   
        <input type="submit" value="Edit Node">
    </form>
    <br>
    
    <form action="./editEdge.jsp" method="post">
        <fieldset>
            <legend>Edit Edge</legend>
            Start Node Name:<br>
            <input type="text" name="editStartNodeName" value="" id="editStartNodeName"><br>
            End Node Name:<br>
            <input type="text" name="editEndNodeName" value="" id="editEndNodeName"><br>
            <input type="hidden" name="FormRecognizer" value="editForm">
            <input type="submit" value="Edit Edge">
        </fieldset>
    </form>
</div>

<div id="log"></div>
</div>
</body>
</html>

