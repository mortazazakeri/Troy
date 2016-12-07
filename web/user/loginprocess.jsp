<%-- 
    Document   : loginprocess
    Created on : Dec 7, 2016, 1:39:25 PM
    Author     : Morteza
--%>

<%@page import="user.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Login Process</title>
    </head>
    <body>

        <%

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            user.Login logginer = new Login();
            user.User loggedUser = logginer.doLogin(username, password,role);

            if (loggedUser != null)
            {
                out.println("You are successfully logged in!");
                session.setAttribute("session", "TRUE");
                session.setAttribute("status", "logged");
               
                session.setAttribute("firstname", loggedUser.getFirstname());
                session.setAttribute("lastname", loggedUser.getLastname());
                session.setAttribute("username", username);
                session.setAttribute("password", password);
                session.setAttribute("role", role);
                //session.setAttribute("loggedUser", loggedUser);

                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else
            {
                out.print(" Sorry, username or password is not correct! ");
                out.print("<a href=\"./login.html\"> Try again  </a>");
                out.print(" or ");
                out.print("<a href=\"./register.jsp\"> Register </a>");
        %>  
        <%--jsp:include page="../index.html"></jsp:include> --%>
        <%
            }

        %>  
        

    </body>
</html>
