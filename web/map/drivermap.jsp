<%-- 
    Document   : Driver Map
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

<!-- Mohsen Created Functions -->
<script language="javascript" type="text/javascript" src="../js/my_Functions.js"></script>

<%
    
    int tripEndNodeID = -1;
    int tripStartNodeID = -1;
    try {
            String ss = request.getParameter("start");
            tripStartNodeID = Integer.parseInt(request.getParameter("start"));
            tripEndNodeID = Integer.parseInt(request.getParameter("end"));
        } catch (Exception e) 
        {
            
        }
    
    GraphVisualyzer graphVis = new GraphVisualyzer();
    List<String> jsonDataStrings = new ArrayList<String>();
    String messageString = "";
    
    if (tripStartNodeID <=0 || tripEndNodeID <=0 ) 
        jsonDataStrings = graphVis.getJsonDataInStringList(null);
    else
        jsonDataStrings = graphVis.getJsonDataInStringList(ODBClass.getInstance().getCheapestPath(tripStartNodeID, tripEndNodeID));
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif}
            .w3-navbar,h1,button {font-family: "Montserrat", sans-serif}
            .fa-anchor,.fa-coffee {font-size:200px}
        </style>
        
        <title>Driver Map</title>
    </head>
    <body onload="init();">
        
        <div id="container">

        <div id="left-container">
                <div id="id-list"></div>
        </div>

        <div id="center-container">
            <div id="infovis"></div>  
        </div>

        <div id="right-container">
            <div id="inner-details"></div>
            <form class="w3-container" action="./editNode.jsp" method="post" id="editForm" style="visibility: hidden">

                <label class="w3-label">Node Name</label>
                <input class="w3-input w3-center" type="text" name="editNodeName" id="editNodeName" readonly>
                <input type="hidden" name="FormRecognizer" value="editForm">   
                <input class="w3-input w3-btn w3-margin-top w3-center" type="submit" value="Edit Node">

            </form>
        </div>
            
        <div id="log"></div>
        </div>
        
        <h2> Available Trip Requests </h2>
        <table class="w3-table-all">
            <thead>
                <tr class="w3-pink">
                    <th>ID</th>
                    <th>Passenger Name</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Accept</th
                </tr>
            </thead>
            <%
                for (trip.TripRequest t
                        : trip.TripRequestManager.getTripRequsetManagerInstance().getAllWaitingTripRequests())
                {
                    out.print("<tr>");
                    out.print("<td>" + t.getRequestId() + "</td>");
                    out.print("<td>" + t.getPassengerUsername() + "</td>");
                    out.print("<td>" + t.getStartNodeName() + "</td>");
                    out.print("<td>" + t.getDestinationNodeName() + "</td>");
                    out.print("<td>" + "<a href=\"..\\triprequest\\acceptrequest.jsp?requestId=" + t.getRequestId() + "&action=accept" + "\">" + "<img src=\"../rsc/edit.png\" class=\"w3-round\" alt=\"edit?\" style=\"width: 20%\">" + "</a>" + "</td>");
                    // out.print("<td>" + "<a href=\".\\driveredit.jsp?username="
                    // + d.getUserName() + "&action=delete" + "\">" + "<img src=\"../rsc/rubbish-bin.png\" class=\"w3-round\" alt=\"delete?\" style=\"width: 50%\">" + "</a>" + "</td>");
                    out.print("</tr>");
                }
            %>
        </table>
        
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
    
    
</script>
