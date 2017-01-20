<%-- 
    Document   : Passenger Map
    Created on : Dec 8, 2016, 1:50:17 PM
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

<!-- CSS Files -->
<link type="text/css" href="../css/base.css" rel="stylesheet" />
<link type="text/css" href="../css/ForceDirected.css" rel="stylesheet" />

<!-- JIT Library File -->
<script language="javascript" type="text/javascript" src="../js/jit.js"></script>

<!-- Example File -->
<script language="javascript" type="text/javascript" src="../js/MapGraph.js"></script>


<%

    GraphVisualyzer graphVis = new GraphVisualyzer();
    List<String> jsonDataStrings = new ArrayList<String>();
    String messageString = "";
    
    if (request.getMethod().equals("POST")) 
    {
        String startNodeName = request.getParameter("beginNodeInput");
        String destinationNodeName = request.getParameter("endNodeInput");
        String userName =(String) session.getAttribute("username");
        int startNodeID = -1;
        int destinationNodeID = -1;
        
        List<Node> nodesList = ODBClass.getInstance().readAllNodes();
        for (Node node : nodesList) 
        {
            if (node.getName().equals(startNodeName)) 
            {
                startNodeID = node.getIdr();
            }
            else if (node.getName().equals(destinationNodeName)) 
            {
                destinationNodeID = node.getIdr();
            }
        }
        
        if (startNodeID == -1 || destinationNodeID == -1) 
        {
            messageString = "false location";
        }
        else
        {
            trip.TripRequestManager.getTripRequsetManagerInstance().addTripRequest(startNodeID, destinationNodeID,
                userName, null, null, "waiting");
            messageString = "Your taxi request recieved,please wait!";
        }
    }
    
    jsonDataStrings = graphVis.getJsonDataInStringList(null);
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Passenger Map</title>
    </head>
    <body onload="init();">
        
        <div id="container">

        <div id="left-container">
            <div id="id-list"></div>
            
            <button onclick="initTripRequest();" id="tripRequestButton">Trip Request</button> <br> 
            
            <div id="beginNodeDiv" style="visibility: hidden">   
                <label>Select Your Beggining Location:</label> <br> 
                <label id="beginNodeLabel">0</label> <br> 
                <button id="submitBeginLocationButton" onclick="submitBeginLocation();">Submit Location</button> <br>
            </div>
            
            <div id="endNodeDiv" style="visibility: hidden">
                <label>Select Your Destination Location</label> <br> 
                <label id="endNodeLabel">0</label> <br> 
                <button onclick="submitEndLocation();">Send Trip Request</button> <br> 
            </div>
             
            <form id="tripRequestForm" class="w3-container" action="./passengermap.jsp" method="post" style="visibility: hidden">               
                <input type="text" name="beginNodeInput" value="" id="beginNodeInput">
                <input type="text" name="endNodeInput" value="" id="endNodeInput">
                <input type="submit" value="Taxi Request">
            </form>
            <label style="color: red" id="messageLabel"></label>
        </div>

        <div id="center-container">
            <div id="infovis"></div>  
        </div>

        <div id="right-container" style="visibility: hidden">
            <div id="inner-details"></div>
            
        </div>

        <div id="log"></div>
        </div>
        <a href="../index.jsp"> Home </a> 
        
    </body>
</html>

<script language="javascript" type="text/javascript">
    var selectedNodeName;
    var json = [];
    // get data base into Json variable 
    function init()
    {
    <%
        for (int i = 0; i < jsonDataStrings.size(); i++) {
    %>
        json.push(<%=jsonDataStrings.get(i)%>);
    <%}%>
        DrawGraph();
        document.getElementById('messageLabel').innerHTML = "<%=messageString%>";
    }
    
    function ff1(nn)
    {
        if (document.getElementById('beginNodeLabel').innerHTML==0) 
        {
            document.getElementById('beginNodeLabel').innerHTML = nn;
        }
        else
        {
            document.getElementById('endNodeLabel').innerHTML = nn;
        }
    }
    
    function initTripRequest()
    {
        document.getElementById('tripRequestButton').style.visibility = "hidden";
        document.getElementById('beginNodeDiv').style.visibility = "visible";
    }
    
    function submitBeginLocation()
    {
        document.getElementById('submitBeginLocationButton').disabled = true;
        document.getElementById('endNodeDiv').style.visibility = "visible";
        document.getElementById('beginNodeInput').value = document.getElementById('beginNodeLabel').innerHTML;
    }
    
    function submitEndLocation()
    {
        document.getElementById('endNodeInput').value = document.getElementById('endNodeLabel').innerHTML;
        document.getElementById("tripRequestForm").submit();
    }
    
</script>
