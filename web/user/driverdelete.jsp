<%-- 
    Document   : driverdelete
    Created on : Dec 23, 2016, 4:42:06 PM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Driver Delete</title>
        <%
            if (session.getAttribute("status") == null)
            {
                String site = new String("./login.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else if (session.getAttribute("role").equals("driver") == false && session.getAttribute("role").equals("manager") == false)
            {
                String site = new String("../error/permission.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else if (session.getAttribute("username").toString().equals(request.getParameter("username")) == false && session.getAttribute("role").equals("manager") == false)
            {
                String site = new String("../error/permission.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>     
    </head>
    <body>

        <%
            String username = request.getParameter("username");
            db.ODBClass.getInstance().deleteDriver(username);
            if (session.getAttribute("role").equals("driver") == true)
            {
                session.invalidate();
                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else if (session.getAttribute("role").equals("manager") == true)
            {
                String site = new String("./profilemanager.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>

    </body>
</html>
