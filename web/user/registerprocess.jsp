<%-- 
    Document   : registerprocess
    Created on : Dec 7, 2016, 10:24:30 PM
    Author     : Morteza
--%>

<%@page import="user.User"%>
<%@page import="user.UserRepository"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Register Process</title>
    </head>
    <body>        
        <%
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            User u = new user.User(firstname, lastname, username, password);

            boolean status = UserRepository.getUserRepositoryInstance().insertUser(u, role);

            if (status)
            {
                out.println("You are successfully Register and logged in!");
                 session.setAttribute("session", "TRUE");
                session.setAttribute("status", "logged");
               
                session.setAttribute("firstname", firstname);
                session.setAttribute("lastname", lastname);
                session.setAttribute("username", username);
                session.setAttribute("password", password);
                session.setAttribute("role", role);
                //session.setAttribute("loggedUser", loggedUser);

                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else
            {
                out.print(" Sorry, invalid input! ");
                out.print("<a href=\"./register.jsp\"> Try again </a>");
                out.print(" or ");
                out.print("<a href=\"./login.html\"> Login </a>");
        %>  
        <%--jsp:include page="../index.html"></jsp:include> --%>
        <%
            }

        %>  


    </body>
</html>
