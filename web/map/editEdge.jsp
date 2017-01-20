<%-- 
    Document   : editEdge
    Created on : Dec 30, 2016, 2:17:33 PM
    Author     : Amirian
--%>
<%@page import="db.ODBClass"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.Node"%>
<%@page import="db.Edge"%>
<%@page import="db.GraphListItem"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Edit Edge</title>
    </head>
    <%

        List<GraphListItem> edgesList = db.ODBClass.getInstance().getGraphForDrawing();
        String startNodeName = "";
        String endNodeName = "";
        boolean enableForm = false;

        int edgeIdr1 = -1;
        int edgeIdr2 = -1;

        float distance = -1;
        int traffic = -1;
        boolean refreshFlag = false;
        String messageString = "";

        if (request.getMethod().equals("POST")) {
            if (request.getParameter("FormRecognizer").equals("editForm")) {
                startNodeName = request.getParameter("editStartNodeName");
                endNodeName = request.getParameter("editEndNodeName");
                if (startNodeName.equals(endNodeName)) {
                    out.print("<a class=\"w3-hover-text-light-blue w3-center\" id=\"backToHome\" href=\"./managermap.jsp\">Back to Map</a> <br>");
                    out.print("<div class=\"w3-panel w3-red\">\n<h3>Sorry!</h3>\n<p>Start node and destination node can not be the same!</p>\n</div>");
                    enableForm = false;
                }
                for (GraphListItem edge : edgesList) {
                    if (edge.getStartNodeName().equals(startNodeName) && edge.getDestinationNodeName().equals(endNodeName)
                            && edgeIdr1 == -1) {
                        edgeIdr1 = edge.getEdgeID();
                        distance = edge.getDistance();
                        traffic = edge.getTraffic();
                        continue;
                    } else if (edge.getStartNodeName().equals(endNodeName) && edge.getDestinationNodeName().equals(startNodeName)
                            && edgeIdr2 == -1) {
                        edgeIdr2 = edge.getEdgeID();
                        continue;
                    }
                }

                if (edgeIdr1 == -1 || edgeIdr2 == -1) {
                    messageString = "the edge (" + startNodeName + "," + endNodeName + ") does not Exist";
                    enableForm = false;
                } else {
                    enableForm = true;
                }
            } else if (request.getParameter("FormRecognizer").equals("saveForm")) {
                startNodeName = request.getParameter("saveStartNodeName");
                endNodeName = request.getParameter("saveEndNodeName");
                edgeIdr1 = Integer.parseInt(request.getParameter("edgeIdr1"));
                edgeIdr2 = Integer.parseInt(request.getParameter("edgeIdr2"));
                distance = Float.parseFloat(request.getParameter("distance"));

                String trafficName = request.getParameter("trafficName");
                if (trafficName.equals("low")) {
                    traffic = 1;
                } else if (trafficName.equals("medium")) {
                    traffic = 2;
                } else if (trafficName.equals("high")) {
                    traffic = 3;
                }

                ODBClass.getInstance().updateEdge(edgeIdr1, distance, traffic);
                ODBClass.getInstance().updateEdge(edgeIdr2, distance, traffic);
                messageString = "Edge updated!";
                enableForm = true;
                refreshFlag = true;
            }
        }
    %>


    <script language="javascript" type="text/javascript">
        function init()
        {
            if (<%=enableForm%>)
            {
                document.getElementById('editForm').style.visibility = "visible";
                addOptions();
            }
            if (<%=refreshFlag%>)
            {
                document.getElementById('msgHeader').style.visibility = "visible";
                document.getElementById('messageLabel').style.visibility = "visible";
                document.getElementById('messageLabel').innerHTML = "<%=messageString%>";
                document.getElementById('backToHome').style.visibility = "visible";
            }
        }

        function addOptions()
        {
            var tempTraffic = <%=traffic%>;

            var optLow = document.createElement("option");
            optLow.value = "low";
            optLow.innerHTML = "Low";

            var optMedium = document.createElement("option");
            optMedium.value = "medium";
            optMedium.innerHTML = "Medium";

            var optHigh = document.createElement("option");
            optHigh.value = "high";
            optHigh.innerHTML = "High";

            if (tempTraffic === 1)
            {
                optLow.selected = "selected";
            }

            if (tempTraffic === 2)
            {
                optMedium.selected = "selected";
            }

            if (tempTraffic === 3)
            {
                optHigh.selected = "selected";
            }
            document.getElementById('traffic').appendChild(optLow);
            document.getElementById('traffic').appendChild(optMedium);
            document.getElementById('traffic').appendChild(optHigh);
        }

    </script>
    <body style="margin-left: 25%; margin-right: 25%; margin-top: 1%" onload="init();">

        <div class="w3-panel w3-leftbar w3-sand w3-xxlarge w3-serif">
            <p><i>From <%=startNodeName%> to <%=endNodeName%></i></p>
        </div> 
        <form class="w3-container w3-center" action="./editEdge.jsp" method="post" style="visibility:hidden; width: 50%; margin-left: 25%" id="editForm">
            <label class="w3-label">Distance</label> <br>
            <input class="w3-input w3-center" type="text" name="distance" value="<%=distance%>"><br>
            <label class="w3-label">Traffic</label><br>
            <select class="w3-select" name="trafficName" id="traffic">
            </select><br><br>
            <input class="w3-btn w3-round-large w3-center" type="submit" value="Save Changes">

            <input type="hidden" name="FormRecognizer" value="saveForm">
            <input type="hidden" name="saveStartNodeName" value="<%=startNodeName%>">
            <input type="hidden" name="saveEndNodeName" value="<%=endNodeName%>">
            <input type="hidden" name="edgeIdr1" value="<%=edgeIdr1%>">
            <input type="hidden" name="edgeIdr2" value="<%=edgeIdr2%>">
        </form>
        
        <form class="w3-container w3-center" style="width: 50%;margin-left: 25%; margin-top: 5%" method="POST" action="./deleteNode_Edge.jsp">
            <input type="hidden" name="FormRecognizer" value="deleteEdgeForm">
            <input type="hidden" name="deleteStartNodeName" value="<%=startNodeName%>">
            <input type="hidden" name="deleteEndNodeName" value="<%=endNodeName%>">
            <input type="hidden" name="deleteEdgeIdr1" value="<%=edgeIdr1%>">
            <input type="hidden" name="deleteEdgeIdr2" value="<%=edgeIdr2%>">
            <input class="w3-btn w3-blue w3-center" style="margin-top: 5%" type="submit" value="Delete Edge">
        </form>
        
        <div class="w3-panel w3-white">
            <h3 id="msgHeader" style="visibility: hidden">Attention!</h3>
            <label class="w3-label" id="messageLabel" style="visibility: hidden"></label>
        </div>
        <a class="w3-hover-text-light-blue w3-center" style="visibility: hidden" id="backToHome" href="./managermap.jsp">Back to Map</a> <br> 
    </body>
</html>
