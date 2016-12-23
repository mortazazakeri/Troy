<%-- 
    Document   : registerprocess
    Created on : Dec 7, 2016, 10:24:30 PM
    Author     : Morteza
--%>

<%@page import="db.Responsibility"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Register Process</title>
        <%
            if (request.getMethod().toString().equals("POST") == false)
            {
                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>
    </head>
    <body>        
        <%
            String name = request.getParameter("name");
            //String firstname = request.getParameter("name");
            //String lastname = request.getParameter("lastname");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            db.Responsibility register = new Responsibility();
            boolean b = register.doRegister(name, username, password, role);

            if (b == true)
            {
                out.println("You are successfully Register and logged in!");

                session.setAttribute("session", "TRUE");
                session.setAttribute("status", "logged");
                session.setAttribute("name", name);
                session.setAttribute("username", username);
                session.setAttribute("password", password);
                session.setAttribute("role", role);
                //session.setAttribute("loggedUser", loggedUser);

                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else
            {
                out.print(" Sorry, something is wrong!  <br> ");
                out.print(" Chack your inputs and ");
                out.print("<a href=\"./register.jsp\"> try again </a>");
                out.print(" or ");
                out.print("<a href=\"./login.html\"> Login </a>");
        %>  
        <%--jsp:include page="../index.html"></jsp:include> --%>
        <%
            }

        %>  


    </body>
</html>
