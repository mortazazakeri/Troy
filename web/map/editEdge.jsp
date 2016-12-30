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


<%
    
    List<GraphListItem> edgesList = db.ODBClass.getInstance().getGraphForDrawing();
    String startNodeName = "";
    String endNodeName = "";
    boolean enableForm = false;
    
    int edgeIdr1 = -1;
    int edgeIdr2 = -1;
    
    float distance = -1;
    int traffic = -1;
    String messageString = "";
    
    
    if (request.getMethod().equals("POST")) 
    {
        if (request.getParameter("FormRecognizer").equals("editForm")) 
        {
            startNodeName = request.getParameter("editStartNodeName");
            endNodeName = request.getParameter("editEndNodeName");
            
            for (GraphListItem edge : edgesList) 
            {
                if (edge.getStartNodeName().equals(startNodeName) && edge.getDestinationNodeName().equals(endNodeName)
                        && edgeIdr1 == -1)
                {
                     edgeIdr1 = edge.getEdgeID();
                     distance = edge.getDistance();
                     traffic = edge.getTraffic();
                     continue;
                }
                else if (edge.getStartNodeName().equals(endNodeName) && edge.getDestinationNodeName().equals(startNodeName)
                        && edgeIdr2 == -1) 
                {
                     edgeIdr2 = edge.getEdgeID(); 
                     continue;  
                }
            }
        
            if (edgeIdr1 == -1 || edgeIdr2 == -1) 
            {
                messageString = "the edge (" + startNodeName + "," + endNodeName + ") does not Exist";
                enableForm = false;
            }
            else
            {
                enableForm = true;
            }
        }
        else if (request.getParameter("FormRecognizer").equals("saveForm")) 
        {
            startNodeName = request.getParameter("saveStartNodeName");
            endNodeName = request.getParameter("saveEndNodeName");
            edgeIdr1 = Integer.parseInt(request.getParameter("edgeIdr1"));
            edgeIdr2 = Integer.parseInt(request.getParameter("edgeIdr2"));
            distance = Float.parseFloat(request.getParameter("distance"));
            
            String trafficName = request.getParameter("trafficName");
            if (trafficName.equals("low")) 
            {
                 traffic = 1;   
            }
            else if(trafficName.equals("medium")) 
            {
                 traffic = 2;    
            }
            else if(trafficName.equals("high")) 
            {
                 traffic = 3;    
            }
            
            ODBClass.getInstance().updateEdge(edgeIdr1, distance, traffic);
            ODBClass.getInstance().updateEdge(edgeIdr2, distance, traffic);
            messageString = "edge updated!";
            enableForm = true;
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
        document.getElementById('messageLabel').innerHTML = "<%=messageString%>";
    }
    
    function addOptions()
    {
        var tempTraffic = <%=traffic%> ;
                    
        var optLow = document.createElement("option");
        optLow.value= "low";
        optLow.innerHTML = "Low";

        var optMedium = document.createElement("option");
        optMedium.value= "medium";
        optMedium.innerHTML = "Medium";

        var optHigh = document.createElement("option");
        optHigh.value= "high";
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





<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TF - Edit Edge</title>
    </head>
    
    
    <body onload="init();">
        
        <h2>( <%=startNodeName%> , <%=endNodeName%> )</h2>
        <form action="./editEdge.jsp" method="post" style="visibility:hidden" id="editForm">
            Traffic:<br>
            <select name="trafficName" id="traffic"> 
            </select>
            <br>
            Distance:<br>
            <input type="text" name="distance" value="<%=distance%>"> <br>
            <input type="submit" value="Save Changes">
            
            <input type="hidden" name="FormRecognizer" value="saveForm">
            <input type="hidden" name="saveStartNodeName" value="<%=startNodeName%>">
            <input type="hidden" name="saveEndNodeName" value="<%=endNodeName%>">
            <input type="hidden" name="edgeIdr1" value="<%=edgeIdr1%>">
            <input type="hidden" name="edgeIdr2" value="<%=edgeIdr2%>">
        </form>
        
        <label style="color: red" id="messageLabel"></label> <br>
        <a href="./managermap.jsp">back to map</a> <br> 
        
    </body>
</html>
