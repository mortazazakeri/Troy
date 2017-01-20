<%-- 
    Document   : deleteNode_Edge
    Created on : Jan 20, 2017, 9:23:40 PM
    Author     : Amirian
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="db.ODBClass"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.Node"%>
<%@page import="db.Driver"%>
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
        
        <title>Delete Item</title>
    </head>
    
    <body>
        <h2> 
            <%
                if (request.getMethod().equals("POST")) 
                {
                    if (request.getParameter("FormRecognizer").equals("deleteNodeForm"))
                    {
                        ODBClass.getInstance().deleteNode(Integer.parseInt(request.getParameter("deleteNodeidr")));
                        out.print("Node " + request.getParameter("deleteNodeName") + "Deleted!");
                    }
                    else if (request.getParameter("FormRecognizer").equals("deleteEdgeForm")) 
                    {
                        ODBClass.getInstance().deleteEdge(Integer.parseInt(request.getParameter("deleteEdgeIdr1")));
                        ODBClass.getInstance().deleteEdge(Integer.parseInt(request.getParameter("deleteEdgeIdr2")));
                        out.print("Edge (" + request.getParameter("deleteStartNodeName") + "," + request.getParameter("deleteEndNodeName") + ") Deleted!");
                    }
                }
                out.print("");
            %>
        </h2>
        <a class="w3-hover-text-light-blue w3-center" href="./managermap.jsp">Back to Map</a>
    </body>
</html>
