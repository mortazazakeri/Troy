<%-- 
    Document   : profilemanager
    Created on : Dec 8, 2016, 12:28:40 AM
    Author     : Morteza
--%>

<%@page import="javax.swing.text.html.HTML.Tag"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <style>
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
            }
            th, td {
                padding: 5px;
                text-align: left;    
            }
        </style>

        <title>TaxiFinder - Manager Profile </title>
    </head>
    <body>
        <%
            if (session.getAttribute("status") == null)
            {
                String site = new String("./login.html");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>
        <h2>Welcome Dear <% out.print(session.getAttribute("username")); %> to Administrator Console</h2>
        <h3>List of Registered Drivers:</h3>
        <table >
            <tr>
                <th> Id</th> <th>First Name</th> <th>Last Name</th> <th>Username</th>
                <th>Edit</th> <th>Delete</th>
            </tr>    

            <%
                int i = 1;
                for (user.Driver d
                        : user.UserRepository.getUserRepositoryInstance().allDrivers)
                {
                    out.print("<tr>");
                    out.print("<td>" + i + "</td>");
                    out.print("<td>" + d.getFirstname() + "</td>");
                    out.print("<td>" + d.getLastname() + "</td>");
                    out.print("<td>" + d.getUsername() + "</td>");
                    out.print("<td>" + "<a href=\".\\driveredit.jsp?username="
                            + d.getUsername() + "&action=edit" + "\">" + "Edit" + "</a>" + "</td>");
                    out.print("<td>" + "<a href=\".\\driveredit.jsp?username="
                            + d.getUsername() + "&action=delete" + "\">" + "Delete" + "</a>" + "</td>");
                    out.print("</tr>");
                    i++;
                }
            %>
        </table>
        <br>
        <h3>List of Registered Passengers:</h3>
        <table >
            <tr>
                <th> Id</th> <th>First Name</th> <th>Last Name</th> <th>Username</th>
                <th>Edit</th> <th>Delete</th>
            </tr>    

            <%
                int j = 1;
                for (user.Driver d
                        : user.UserRepository.getUserRepositoryInstance().allDrivers)
                {
                    out.print("<tr>");
                    out.print("<td>" + j + "</td>");
                    out.print("<td>" + d.getFirstname() + "</td>");
                    out.print("<td>" + d.getLastname() + "</td>");
                    out.print("<td>" + d.getUsername() + "</td>");
                    out.print("<td>" + "<a href=\".\\passengeredit.jsp?username="
                            + d.getUsername() + "&action=edit" + "\">" + "Edit" + "</a>" + "</td>");
                    out.print("<td>" + "<a href=\".\\passengeredit.jsp?username="
                            + d.getUsername() + "&action=delete" + "\">" + "Delete" + "</a>" + "</td>");
                    out.print("</tr>");
                    j++;
                }
            %>
        </table>

        <a href="../index.jsp"> Back to Home </a> 
        | 
        <a href="./logout.jsp"> Logout </a>

    </body>
</html>
