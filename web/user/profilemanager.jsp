<%-- 
    Document   : profilemanager
    Created on : Dec 8, 2016, 12:28:40 AM
    Author     : Morteza
--%>

<%@page import="com.sun.xml.rpc.encoding.soap.SOAP12Constants"%>
<%@page import="javax.swing.text.html.HTML.Tag"%>
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
        <title>Manager Profile</title>
        <%
            if (session.getAttribute("status") == null) {
                String site = new String("./login.html");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else if (session.getAttribute("role").toString().equals("manager") == false
                    || request.getParameter("username").toString().equals(session.getAttribute("username").toString()) == false) {
                String site = new String("../error/permission.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>
    </head>
    <body style="margin-left: 25%; margin-right: 25%; margin-top: 1%">
        <header class="w3-container w3-blue w3-round-xlarge">
            <h1 class="w3-margin w3-jumbo w3-center w3-hover-text-indigo">Your profile</h1>
        </header>
        <form class="w3-container w3-center" style="margin-top: 5%" action="./manageredit.jsp" method="post">
            <div class="w3-container">
                <label class="w3-label">Name</label>
                <input class="w3-input w3-center" type="text" name="name" value="<%out.print(session.getAttribute("name"));%>">
                <label class="w3-label">Username</label>
                <input class="w3-input w3-center" type="text" name="username" value="<%out.print(session.getAttribute("username"));%>" readonly >
                <label class="w3-label">Password</label>
                <input class="w3-input w3-center" type="password" name="password" value="<%out.print(session.getAttribute("password"));%>">
                <label class="w3-label">Role</label>
                <select class="w3-select" name="role">
                    <option value="manager">Manager</option>
                </select>
                <input class="w3-input w3-margin-top" style="width: 25%; margin-left: 37.5%" type="submit" value="Update">
                <a class="w3-hover-text-light-blue" href="../index.jsp"> Home | </a>
                <a class="w3-hover-text-light-blue" href="./logout.jsp"> Logout </a>
            </div>
        </form>
        <div class="w3-panel w3-red w3-round-xlarge">
            <p>List of Registered Drivers:</p>
        </div>
        <table class="w3-table-all">
            <thead>
                <tr class="w3-pink">
                    <th>ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th style="width: 5%">Edit</th>
                    <th style="width: 5%">Delete</th>
                </tr>
            </thead>
            <%
                int i = 1;
                for (db.Driver d
                        : db.ODBClass.getInstance().readAllDrivers()) {
                    out.print("<tr>");
                    out.print("<td>" + i + "</td>");
                    out.print("<td>" + d.getName() + "</td>");
                    //out.print("<td>" + d.getLastname() + "</td>");
                    out.print("<td>" + d.getUserName() + "</td>");
                    out.print("<td>" + "<a href=\".\\driveredit.jsp?username=" + d.getUserName() + "&action=edit" + "\">" + "<img src=\"../rsc/edit.png\" class=\"w3-round\" alt=\"edit?\" style=\"width: 70%\">" + "</a>" + "</td>");
                    out.print("<td>" + "<a href=\".\\driveredit.jsp?username="
                            + d.getUserName() + "&action=delete" + "\">" + "<img src=\"../rsc/rubbish-bin.png\" class=\"w3-round\" alt=\"delete?\" style=\"width: 50%\">" + "</a>" + "</td>");
                    out.print("</tr>");
                    i++;
                }
            %>
        </table>
        <div class="w3-panel w3-lime w3-round-xlarge">
            <p>List of Registered Passengers</p>
        </div>
        <table class="w3-table-all">
            <thead>
                <tr class="w3-green">
                    <th>ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th style="width: 5%">Edit?</th>
                    <th style="width: 5%">Delete?</th>
                </tr>
            </thead>

            <%
                int j = 1;
                for (db.User p : db.ODBClass.getInstance().readAllUsers()) {
                    out.print("<tr>");
                    out.print("<td>" + j + "</td>");
                    out.print("<td>" + p.getName() + "</td>");
                    //out.print("<td>" + p.getLastname() + "</td>");
                    out.print("<td>" + p.getUserName() + "</td>");
                    out.print("<td>" + "<a href=\".\\passengeredit.jsp?username="
                            + p.getUserName() + "&action=edit" + "\">" + "<img src=\"../rsc/edit.png\" class=\"w3-round\" alt=\"edit?\" style=\"width:70%\">" + "</a>" + "</td>");
                    out.print("<td>" + "<a href=\".\\passengeredit.jsp?username="
                            + p.getUserName() + "&action=delete" + "\">" + "<img src=\"../rsc/rubbish-bin.png\" class=\"w3-round\" alt=\"delete?\" style=\"width:50%\">" + "</a>" + "</td>");
                    out.print("</tr>");
                    j++;
                }
            %>
        </table>
    </body>
</html>