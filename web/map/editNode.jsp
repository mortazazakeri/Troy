<%-- 
    Document   : editNode
    Created on : Dec 29, 2016, 2:01:56 AM
    Author     : Amirian
--%>
<%@page import="db.ODBClass"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.Node"%>
<%@page import="db.Driver"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Node</title>
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
    </head>
    <script language="javascript" type="text/javascript">
        <%
            String nodeName = "";
            String nodeIdr = "";
            int latitude = -1;
            int langtitude = -1;
            String messageString = "";
            if (request.getMethod().equals("POST")) {
                if (request.getParameter("FormRecognizer").equals("editForm")) {
                    nodeName = request.getParameter("editNodeName");
                } else if (request.getParameter("FormRecognizer").equals("saveForm")) {
                    String[] driversUserNamesChecked = request.getParameterValues("checkbox");
                    String newNodeName = request.getParameter("nodeName");
                    String newNodeIDr = request.getParameter("nodeidr");
                    int newLatitude = Integer.parseInt(request.getParameter("latitude"));
                    int newLangtitude = Integer.parseInt(request.getParameter("langtitude"));
                    List<String> newDriverUsernames = new ArrayList<String>();
                    if (driversUserNamesChecked != null) {
                        for (int i = 0; i < driversUserNamesChecked.length; i++) {
                            newDriverUsernames.add(driversUserNamesChecked[i]);
                        }
                    }
                    List<Node> nodesList = ODBClass.getInstance().readAllNodes();
                    boolean replica = false;
                    for (Node node : nodesList) {
                        if (node.getName().equals(newNodeName) && node.getIdr() != Integer.parseInt(newNodeIDr)) {
                            replica = true;
                            break;
                        }
                    }
                    if (replica) {
                        messageString = "you have already a node with name:'" + newNodeName + "'. please choose another name.";
                        nodeName = request.getParameter("oldNodeName");
                    } else {
                        if (newDriverUsernames.size() == 0) {
                            newDriverUsernames = null;
                        }
                        ODBClass.getInstance().updateNode(Integer.parseInt(newNodeIDr), newNodeName,
                                newLatitude, newLangtitude, newDriverUsernames);
                        messageString = "Node updated!";
                        nodeName = newNodeName;
                    }
                }
            }
            List<Node> nodesList = ODBClass.getInstance().readAllNodes();
            Node currentNode = new Node(0, "temp", 0, 0, null);
            for (Node node : nodesList) {
                if (node.getName().equals(nodeName)) {
                    currentNode = node;
                    break;
                }
            }
            nodeIdr = Integer.toString(currentNode.getIdr());
            langtitude = currentNode.getLangtitude();
            latitude = currentNode.getLatitude();
            List<String> nodeDriversUsernames = currentNode.getDriversIDs(); //getDriversUsernames()
            List<String> otherDriversUserNames = new ArrayList<String>();
            List<Driver> allDrivers = ODBClass.getInstance().readAllDrivers();
            for (Driver driver : allDrivers) {
                if (!nodeDriversUsernames.contains(driver.getUserName())) {
                    otherDriversUserNames.add(driver.getUserName());
                }
            }
        %>
        function init()
        {
            var nodeDriversUserNames = [];
            var otherDriversUserNames = [];
        <%            for (int i = 0; i < nodeDriversUsernames.size(); i++) {
        %>
            nodeDriversUserNames.push("<%=nodeDriversUsernames.get(i)%>");
        <%}%>
        <%
            for (int j = 0; j < otherDriversUserNames.size(); j++) {
        %>
            otherDriversUserNames.push("<%=otherDriversUserNames.get(j)%>");
        <%}%>
            document.getElementById('messageLabel').innerHTML = "<%=messageString%>";
        }
    </script>
    <body style="margin-left: 25%; margin-right: 25%; margin-top: 1%" onload="init();">
        <header class="w3-container w3-blue w3-round-xlarge">
            <h1 class="w3-margin w3-jumbo w3-center w3-hover-text-indigo">Node Name: <%=nodeName%></h1>
        </header>
        <form class="w3-container w3-center" style="width: 50%;margin-left: 25%; margin-top: 5%" method="POST" action="./editNode.jsp">
            <label class="w3-label">Node Name is <%=nodeName%></label>
            <input type="hidden" name="nodeName" id="nodeName" value="<%=nodeName%>">
            <label class="w3-label">Latitude</label>
            <input class="w3-input w3-center" type="text" name="latitude" id="latitude" value="<%=latitude%>">
            <label class="w3-label">Longitude</label>
            <input class="w3-input w3-center" type="text" name="langtitude" id="langtitude" value="<%=langtitude%>">
            <input class="w3-input w3-center" type="hidden" id="oldNodeName" name="nodeName" value="<%=nodeName%>">
            <input class="w3-input w3-center" type="hidden" id="nodeidr" name="nodeidr" value="<%=nodeIdr%>">
            <input class="w3-input w3-center" type="hidden" name="FormRecognizer" value="saveForm">
            <%
                int i = 0;
                String cb = "";
                for (String s : nodeDriversUsernames) {
                    cb = "<input class=\"w3-check\" type=\"checkbox\" checked=\"checked\" id=\"checkbox" + i + "\"" + " name=\"checkbox\" value=\"" + s + "\">";
                    out.print("<label class=\"w3-label w3-text-black\">" + s + "</label>");
                    out.print(cb);
                    i++;
                }
                i = 0;
                cb = "";
                for (String s : otherDriversUserNames) {
                    cb = "<input class=\"w3-check\" type=\"checkbox\" id=\"checkbox" + i + "\"" + " name=\"checkbox\" value=\"" + s + "\">";
                    out.print(cb);
                    out.print("<label class=\"w3-label w3-text-black\">" + s + "</label>");
                    i++;
                }
            %>
            <br>
            <input class="w3-btn w3-blue w3-center" style="margin-top: 5%" type="submit" value="Save Changes">
        </form>
            
        <form class="w3-container w3-center" style="width: 50%;margin-left: 25%; margin-top: 5%" method="POST" action="./deleteNode_Edge.jsp">
            <input class="w3-input w3-center" type="hidden" name="FormRecognizer" value="deleteNodeForm">
            <input class="w3-input w3-center" type="hidden" id="deleteNodeidr" name="deleteNodeidr" value="<%=nodeIdr%>">
            <input class="w3-input w3-center" type="hidden" id="deleteNodeName" name="deleteNodeName" value="<%=nodeName%>">
            <input class="w3-btn w3-blue w3-center" style="margin-top: 5%" type="submit" value="Delete Node">
        </form>
        <label class="w3-light-blue" style="color: red" id="messageLabel"></label>
        <br>
        <a class="w3-hover-text-light-blue w3-center" href="./managermap.jsp">Back to Map</a> <br>
    </body>
</html>