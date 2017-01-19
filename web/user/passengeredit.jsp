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
        <title>Passenger Profile</title>
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

    <body style="margin-left: 25%; margin-right: 25%; margin-top: 1%">
        <!-- Header -->
        <header class="w3-container w3-blue w3-round-xlarge">
            <h1 class="w3-margin w3-jumbo w3-center w3-hover-text-indigo">Passenger profile</h1>
        </header>
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
        <form class="w3-container w3-center" style="margin-top: 5%" action="./passengeredit.jsp" method="post">
            <div class="w3-container w3-left-align">
                <label class="w3-label">Name</label>
                <input class="w3-input w3-center" type="text" name="name" value="<%out.print(u.getName());%>">
                <label class="w3-label">Username</label>
                <input class="w3-input w3-center" type="text" name="username" value="<%out.print(u.getUserName());%>" readonly >
                <label class="w3-label">Password</label>
                <input class="w3-input w3-center" type="password" name="password" value="<%out.print(u.getPassword());%>">

                <label class="w3-label">Role</label>
                <select class="w3-select" name="role">
                    <option value="passenger">Passenger</option>
                </select>
                <input class="w3-btn w3-round-large w3-center" style="width: 25%; margin-left: 37.5%; margin-top: 10%" type="submit" value="Update">
            </div>
            <div class="w3-container w3-center">
                <% if (session.getAttribute("role").equals("manager") == true)
                    {
                        out.print("<a href=\"./profilemanager.jsp?username=" + session.getAttribute("username") + "\"> Back to Manager Profile  </a> | ");
                    }
                    out.print("<a href=\"./passengerdelete.jsp?username=" + u.getUserName() + "\"> Delete Profile </a> | ");
                    out.print("<a href=\"../index.jsp?\"> Home </a>");
                %>
            </div>
        </form> 

        <div>
            <h2> Passenger Trip List</h2>
            <table class="w3-table-all">
                <thead>
                    <tr class="w3-pink">
                        <th>ID</th>
                        <th>Driver Name</th>
                        <th>Home</th>
                        <th>Destination</th>

                    </tr>
                </thead>
                <%
                    int i = 1;
                    for (db.Trip trip
                            : db.ODBClass.getInstance().readPassengersTrips((String) session.getAttribute("username")))
                    {
                        out.print("<tr>");
                        out.print("<td>" + i + "</td>");
                        out.print("<td>" + trip.getDriverID() + "</td>");
                        out.print("<td>" + trip.getStartNodeID() + "</td>");
                        out.print("<td>" + trip.getEndNodeID() + "</td>");
                        // out.print("<td>" + "<a href=\".\\driveredit.jsp?username=" + d.getUserName() + "&action=edit" + "\">" + "<img src=\"../rsc/edit.png\" class=\"w3-round\" alt=\"edit?\" style=\"width: 70%\">" + "</a>" + "</td>");
                        // out.print("<td>" + "<a href=\".\\driveredit.jsp?username="
                        // + d.getUserName() + "&action=delete" + "\">" + "<img src=\"../rsc/rubbish-bin.png\" class=\"w3-round\" alt=\"delete?\" style=\"width: 50%\">" + "</a>" + "</td>");
                        out.print("</tr>");
                        i++;
                    }
                %>
            </table>  

            <h2> Passenger Trip Current Request</h2>
            <table class="w3-table-all">
                <thead>
                    <tr class="w3-pink">
                        <th>ID</th>
                        <th>Driver Name</th>
                        <th>Home</th>
                        <th>Destination</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <%
                    trip.TripRequest t = trip.TripRequestManager.getTripRequsetManagerInstance().getTripRequestOfPessenger((String) session.getAttribute("username"));

                    out.print("<tr>");
                    if (t != null)
                    {
                        out.print("<td>" + t.getRequestId() + "</td>");
                        out.print("<td>" + t.getDriverUsername() + "</td>");
                        out.print("<td>" + t.getStartNode() + "</td>");
                        out.print("<td>" + t.getDestinationNode() + "</td>");
                        out.print("<td>" + t.getStatus() + "</td>");
                       // out.print("<td>" + "<a href=\".\\driveredit.jsp?username=" + d.getUserName() + "&action=edit" + "\">" + "<img src=\"../rsc/edit.png\" class=\"w3-round\" alt=\"edit?\" style=\"width: 70%\">" + "</a>" + "</td>");
                        // out.print("<td>" + "<a href=\".\\driveredit.jsp?username="
                        // + d.getUserName() + "&action=delete" + "\">" + "<img src=\"../rsc/rubbish-bin.png\" class=\"w3-round\" alt=\"delete?\" style=\"width: 50%\">" + "</a>" + "</td>");
                    }
                    out.print("</tr>");

                %>
            </table>  

        </div>
    </body>
</html>

