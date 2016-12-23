<%-- 
    Document   : manageredit
    Created on : Dec 8, 2016, 11:58:41 AM
    Author     : Morteza
--%>

<%@page import="db.Responsibility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Manager Edit</title>
        <%
            if (session.getAttribute("status") == null)
            {
                String site = new String("./login.html");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
            else if(session.getAttribute("role").toString().equals("manager") == false  )
            {
                String site = new String("../error/permission.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>
    </head>
    <body>

        <%

            String name = request.getParameter("name").toString();
            String username = session.getAttribute("username").toString();
            String password = request.getParameter("password").toString();
            String role = request.getParameter("role").toString();
            String oldpassword = session.getAttribute("password").toString();

            db.Responsibility meditor = new Responsibility();
            boolean b  = meditor.doManagerEdit(name, username, password);

            if ( b == true)
            {
                out.println("<h3>Your profile update uccessfully!</h3>");
                out.print("<a href=\"./profilemanager.jsp?username="+session.getAttribute("username")+"\"> Back to Manager Profile  </a> | ");
                session.setAttribute("session", "TRUE");
                session.setAttribute("status", "logged");             
                session.setAttribute("name", name);
                session.setAttribute("username", username);
                session.setAttribute("password", password);
                session.setAttribute("role", role);

            } else
            {
                out.print(" Sorry, update was failed. Something is wrong... ");
                out.print("<a href=\"./profilemanager.jsp?username="+session.getAttribute("username")+"\"> Back to Manager Profile  </a> | ");
                out.print(" or ");
                out.print("<a href=\"./logout.jsp\"> Logout </a>");
        %>  
        <%--jsp:include page="../index.html"></jsp:include> --%>
        <%
            }

        %>  


    </body>
</html>
