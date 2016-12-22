<%-- 
    Document   : passengeredit
    Created on : Dec 8, 2016, 2:21:58 AM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <% 
            //if()
            
            String s1  = request.getParameter("username");
            String s2 = request.getParameter("action");
            
            out.print(s1 + "\n\n and action = " + s2);
        %>
        
    </body>
</html>
