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

    GraphVisualyzer graphVis = new GraphVisualyzer();
    List<String> jsonDataStrings = new ArrayList<String>();
    String messageString = "";
    jsonDataStrings = graphVis.getJsonDataInStringList(ODBClass.getInstance().getCheapestPath(67, 66));
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <div>
            <%
                List<String> cheapestPath = ODBClass.getInstance().getCheapestPath(67, 66);
                String el;
                int i6 = 0;
                for (String ss : cheapestPath) {
                    el = "<label  id=\"lbl" + i6 + "\"" + " name=\"checkbox\" value=\"" + ss+ "\">" + ss
                            + " - </label>";
                    out.print(el);
                    i6++;
                }
            %>
        </div>
        
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
