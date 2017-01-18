<%--  
    Document   : driveredit
    Created on : Dec 8, 2016, 11:58:21 AM
    Author     : Morteza
--%>

<%@page import="db.Responsibility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <title>Driver Profile</title>
        <%
            if (session.getAttribute("status") == null) {
                String site = new String("./login.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else if (session.getAttribute("role").equals("driver") == false && session.getAttribute("role").equals("manager") == false) {
                String site = new String("../error/permission.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else if (session.getAttribute("username").toString().equals(request.getParameter("username")) == false && session.getAttribute("role").equals("manager") == false) {

                String site = new String("../error/permission.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>     
    </head>

    <body style="margin-left: 25%; margin-right: 25%; margin-top: 1%">

        <!-- Header -->
        <header class="w3-container w3-blue w3-round-xlarge">
            <h1 class="w3-margin w3-jumbo w3-center w3-hover-text-indigo">Driver profile</h1>
        </header>
        <%
            db.Driver d = null;
            if (request.getMethod() == "GET") {
                d = db.ODBClass.getInstance().readDriver(request.getParameter("username"));
            } else if (request.getMethod() == "POST") {
                db.Responsibility driverEditor = new Responsibility();
                boolean b = driverEditor.doDriverEdit(request.getParameter("name"),
                        request.getParameter("username"), request.getParameter("password"),
                        request.getParameter("ln")
                );
                d = db.ODBClass.getInstance().readDriver(request.getParameter("username"));
                if (b == true) {
                    out.println("<h3>Your profile update uccessfully!</h3>");

                } else {
                    out.print(" Sorry, update was failed. Something is wrong... ");
                }
            }
        %>
        <form class="w3-container w3-center" style="margin-top: 5%" action="./driveredit.jsp.jsp" method="post">
            <div class="w3-container w3-left-align">
                <label class="w3-label">Name</label>
                <input class="w3-input w3-center" type="text" name="name" value="<%out.print(d.getName());%>">
                <label class="w3-label">Username</label>
                <input class="w3-input w3-center" type="text" name="username" value="<%out.print(d.getUserName());%>" readonly >
                <label class="w3-label">Password</label>
                <input class="w3-input w3-input" type="password" name="password" value="<%out.print(d.getPassword());%>">  
                <label class="w3-label">License Number</label>
                <input class="w3-input w3-center" type="text" name="ln" value="<%out.print(d.getLicenseNumber());%>">
                <label class="w3-label">Role</label>
                <select class="w3-select" name="role">
                    <option value="driver">Driver</option>  
                </select>
                <input class="w3-btn w3-round-large w3-center" style="width: 25%; margin-left: 37.5%; margin-top: 10%" type="submit" value="Update">
                <div class="w3-container w3-center">
                    <% if (session.getAttribute("role").equals("manager") == true) {
                            out.print("<a href=\"./profilemanager.jsp?username=" + session.getAttribute("username") + "\"> Back to Manager Profile  </a> | ");
                        }
                        out.print("<a href=\"./driverdelete.jsp?username=" + d.getUserName() + "\"> Delete Profile </a> | ");
                        out.print("<a href=\"../index.jsp?\"> Home  </a>");
                    %>
                </div>
        </form> 
    </body>
</html>

