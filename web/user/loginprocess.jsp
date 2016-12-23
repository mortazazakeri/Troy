<%-- 
    Document   : loginprocess
    Created on : Dec 7, 2016, 1:39:25 PM
    Author     : Morteza
--%>

<%@page import="db.Responsibility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Login Process</title>
        <%
            if (session.getAttribute("status") != null)
            {
                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>
    </head>
    <body>

        <%
           
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            db.Responsibility logginer = new Responsibility();
            db.Person loggedPerson = logginer.doLogin(username, password,role);

            if (loggedPerson != null)
            {
                out.println("You are successfully logged in!");
                
                session.setAttribute("session", "TRUE");
                session.setAttribute("status", "logged");             
                session.setAttribute("name", loggedPerson.getName());
                session.setAttribute("username", username);
                session.setAttribute("password", password);
                session.setAttribute("role", role);
                //session.setAttribute("loggedPerson", loggedPerson);

                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else
            {
                out.print(" Sorry, username or password is not correct! ");
                out.print("<a href=\"./login.jsp\"> Try again  </a>");
                out.print(" or ");
                out.print("<a href=\"./register.jsp\"> Register </a>");
        %>  
        <%--jsp:include page="../index.html"></jsp:include> --%>
        <%
            }

        %>  
        

    </body>
</html>
