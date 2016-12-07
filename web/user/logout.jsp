<%-- 
    Document   : logout
    Created on : Dec 7, 2016, 1:40:36 PM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Logout</title>
    </head>
    <body>
        <h1>You successfully logout.</h1>
        <%
            if (session != null)
            {
                if (session.getAttribute("status") != null)
                {
                    session.invalidate();
                }
            }
            String site = new String("../index.jsp");
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site);
        %>
    </body>
</html>
