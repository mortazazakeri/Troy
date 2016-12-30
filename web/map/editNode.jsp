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

<% 
    String nodeName = "";
    String nodeIdr = "";
    int latitude = -1;
    int langtitude = -1;
    String messageString = "";
    if (request.getMethod().equals("POST")) 
    {
        if (request.getParameter("FormRecognizer").equals("editForm")) 
        {
            nodeName = request.getParameter("editNodeName");
        }
        else if (request.getParameter("FormRecognizer").equals("saveForm")) 
        {
            String[] driversUserNamesChecked = request.getParameterValues("checkbox");  
            String newNodeName = request.getParameter("nodeName");
            String newNodeIDr = request.getParameter("nodeidr");
            int newLatitude = Integer.parseInt(request.getParameter("latitude"));
            int newLangtitude = Integer.parseInt(request.getParameter("langtitude"));
            
            List<String> newDriverUsernames = new ArrayList<String>();
            
            if (driversUserNamesChecked != null) 
            {
                for (int i = 0; i < driversUserNamesChecked.length; i++) 
                {
                    newDriverUsernames.add(driversUserNamesChecked[i]);
                }
            }
            
            
            List<Node> nodesList = ODBClass.getInstance().readAllNodes();
            boolean replica = false;
            for(Node node : nodesList)
            {
                if (node.getName().equals(newNodeName) && node.getIdr()!= Integer.parseInt(newNodeIDr)) 
                {
                    replica = true;
                    break;
                }
            }
            if(replica) 
            {
                messageString = "you have already a node with name:'" + newNodeName + "'. please choose another name.";
                nodeName = request.getParameter("oldNodeName");
            }
            else
            {
                if (newDriverUsernames.size() == 0) 
                {
                    newDriverUsernames = null;    
                }
                ODBClass.getInstance().updateNode(Integer.parseInt(newNodeIDr), newNodeName,
                                        newLatitude, newLangtitude, newDriverUsernames);
                messageString = "node updated!";
                nodeName = newNodeName;
            }
        }
    }
    
    List<Node> nodesList = ODBClass.getInstance().readAllNodes();
    Node currentNode = new Node(0, "temp", 0, 0, null);
    
    for (Node node : nodesList) 
    {
        if (node.getName().equals(nodeName))
        {
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
    
    
    for (Driver driver : allDrivers) 
    {
        if (!nodeDriversUsernames.contains(driver.getUserName())) 
        {
            otherDriversUserNames.add(driver.getUserName());
        }
    }
    
    
%>

<script language="javascript" type="text/javascript"> 
    
    
    function init()
    {       
        var nodeDriversUserNames = [];
        var otherDriversUserNames = [];
        <%  
        for (int i=0; i < nodeDriversUsernames.size(); i++) {  
        %>  
        nodeDriversUserNames.push("<%=nodeDriversUsernames.get(i)%>"); 
        <%}%>
            
            
        
        <%  
        for (int j=0; j < otherDriversUserNames.size(); j++) {  
        %>  
        otherDriversUserNames.push("<%=otherDriversUserNames.get(j)%>"); 
        <%}%>
            
        
        var br = document.createElement("br");
        var lbl;
        //create a form
        var f = document.createElement("form");
        f.setAttribute('method',"post");
        f.setAttribute('action',"./editNode.jsp");
        
        
        var nodeName = document.createElement("input");
        nodeName.type = "text";
        nodeName.name = "nodeName";
        nodeName.id = "nodeName";
        nodeName.value = "<%=nodeName%>";
        lbl = document.createElement("label");
        lbl.for = "nodeName";
        lbl.innerHTML = "node name: ";
        f.appendChild(lbl);
        f.appendChild(nodeName);
        f.appendChild(br);
        
        var langtitude = document.createElement("input");
        langtitude.type = "text";
        langtitude.name = "langtitude";
        langtitude.id = "langtitude";
        langtitude.value = "<%=langtitude%>";
        lbl = document.createElement("label");
        lbl.for = "langtitude";
        lbl.innerHTML = "langtitude: ";
        f.appendChild(lbl);
        f.appendChild(langtitude);
        f.appendChild(br);
        
        var latitude = document.createElement("input");
        latitude.type = "text";
        latitude.name = "latitude";
        latitude.id = "latitude";
        latitude.value = "<%=latitude%>";
        lbl = document.createElement("label");
        lbl.for = "latitude";
        lbl.innerHTML = "latitude: ";
        f.appendChild(lbl);
        f.appendChild(latitude);
        f.appendChild(br);
        
        var oldNodeName = document.createElement("input");
        oldNodeName.type = "hidden";
        oldNodeName.name = "oldNodeName";
        oldNodeName.id = "oldNodeName";
        oldNodeName.value = "<%=nodeName%>";
        f.appendChild(oldNodeName);
        
        var nodeidr = document.createElement("input");
        nodeidr.type = "hidden";
        nodeidr.name = "nodeidr";
        nodeidr.id = "nodeidr";
        nodeidr.value = "<%=nodeIdr%>";
        f.appendChild(nodeidr);
        
        var temp = document.createElement("input");
        temp.type = "hidden";
        temp.name = "FormRecognizer";
        temp.value = "saveForm";
        f.appendChild(temp);
        
        var c1;
        var l;
        for (var i = 0; i < <%=nodeDriversUsernames.size()%>; i++)
        {
            c1 = document.createElement("input");
            c1.type = "checkbox";
            c1.id = "checkbox" + i.toString();
            c1.name = "checkbox";
            c1.value = nodeDriversUserNames[i];
            c1.checked = true;
            l = document.createElement("label");
            l.for = "checkbox" + i.toString();
            l.innerHTML = nodeDriversUserNames[i];
            f.appendChild(l);
            f.appendChild(c1);
        }
        
        var c2;
        var l;
        for (var i = 0; i < <%=otherDriversUserNames.size()%> ; i++) 
        {
            c2 = document.createElement("input");
            c2.type = "checkbox";
            c2.id = "checkbox" + i.toString();
            c2.name = "checkbox";
            c2.value = otherDriversUserNames[i];
            c2.checked = false;
            l = document.createElement("label");
            l.for = "checkbox" + i.toString();
            l.innerHTML = otherDriversUserNames[i];
            f.appendChild(l);
            f.appendChild(c2);
        }
        
        var s = document.createElement("input");
        s.type = "submit";
        s.value = "Save Changes";
        f.appendChild(s);
        
        
        document.getElementsByTagName('body')[0].appendChild(f);
        document.getElementById('messageLabel').innerHTML = "<%=messageString%>";
    }    
</script>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TF - Edit Node</title>
    </head>
    
    
    <body onload="init();">
        <h1>Node Name: <%=nodeName%></h1>
        <label style="color: red" id="messageLabel"></label> <br>
        <a href="./managermap.jsp">back to map</a> <br>
    </body>
</html>
