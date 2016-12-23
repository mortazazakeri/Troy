<%--  
    Document   : passengeredit
    Created on : Dec 8, 2016, 11:58:21 AM
    Author     : Morteza
--%>

<%@page import="db.Responsibility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Taxi Finder - Passenger Profile</title>
        <%
            if (session.getAttribute("status") == null)
            {
                String site = new String("./login.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else if (session.getAttribute("role").equals("passenger") == false && session.getAttribute("role").equals("manager") == false)
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
        <h1> Passenger Profile </h1>

        <%
            db.User u = null;
            if (request.getMethod() == "GET")
            {
                u = db.ODBClass.getInstance().readUser(request.getParameter("username"));
            } else if (request.getMethod() == "POST")
            {
                db.Responsibility driverEditor = new Responsibility();
                boolean b = driverEditor.doPassengerEdit(request.getParameter("name"),
                        request.getParameter("username"), request.getParameter("password"));
                u = db.ODBClass.getInstance().readUser(request.getParameter("username"));
                if (b == true)
                {
                    out.println("<h3>Your profile update uccessfully!</h3>");

                } else
                {
                    out.print(" Sorry, update was failed. Something is wrong... ");
                }
            }
        %>

        <div>
            <form action="./passengeredit.jsp" method="post">
                <h3>View and Edit Personal Information:</h3>
                <fieldset>
                    <legend>Passenger information:</legend>
                    Name:<br>
                    <input type="text" name="name" value="<%out.print(u.getName());%>"> <br>                   
                    Username:<br>
                    <input type="text" name="username" value="<%out.print(u.getUserName());%>" readonly > <br>
                    Password:<br>
                    <input type="password" name="password" value="<%out.print(u.getPassword());%>"> <br>

                    Role:<br>
                    <select name="role">
                        <option value="passenger">Passenger</option>                      
                    </select>
                    <br>
                    <input type="submit" value="Update">

                </fieldset>
            </form> 
            <br>

            <% if (session.getAttribute("role").equals("manager") == true)
                {
                    out.print("<a href=\"./profilemanager.jsp?username=" + session.getAttribute("username") + "\"> Back to Manager Profile  </a> | ");
                }
                out.print("<a href=\"./passengerdelete.jsp?username=" + u.getUserName() + "\"> Delete Profile </a> | ");
                out.print("<a href=\"../index.jsp?\"> Home </a>");
            %>

        </div>

    </body>

</html>

