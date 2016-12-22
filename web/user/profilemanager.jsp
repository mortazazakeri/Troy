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

        <div>
            <form action="./manageredit.jsp" method="post">
                <h3>View and Edit Personal Information:</h3>
                <fieldset>
                    <legend>User information:</legend>
                    Name:<br>
                    <input type="text" name="firstname" value="<%out.print(session.getAttribute("name"));%>"> <br>                   
                    Username:<br>
                    <input type="text" name="username" value="<%out.print(session.getAttribute("username"));%>" readonly > <br>
                    Password:<br>
                    <input type="password" name="password" value="<%out.print(session.getAttribute("password"));%>"> <br>
                    Role:<br>
                    <select name="role">
                        <option value="manager">Manager</option>                      
                    </select>
                    <br>
                    <input type="submit" value="Update">
                </fieldset>
                <p><%
                    if (request.getParameter("action") != null)
                    {
                        out.print("Your profile update!");
                        }%></p>
            </form> 

            <h3>List of Registered Drivers:</h3>
            <table >
                <tr>
                    <th>Id</th> <th>Name</th> <th>Username</th>
                    <th>Edit</th> <th>Delete</th>
                </tr>    

                <%
                    int i = 1;
                    for (db.Driver d
                            : db.ODBClass.getInstance().readAllDrivers())
                    {
                        out.print("<tr>");
                        out.print("<td>" + i + "</td>");
                        out.print("<td>" + d.getName() + "</td>");
                        //out.print("<td>" + d.getLastname() + "</td>");
                        out.print("<td>" + d.getUserName() + "</td>");
                        out.print("<td>" + "<a href=\".\\driveredit.jsp?username="
                                + d.getUserName() + "&action=edit" + "\">" + "Edit" + "</a>" + "</td>");
                        out.print("<td>" + "<a href=\".\\driveredit.jsp?username="
                                + d.getUserName() + "&action=delete" + "\">" + "Delete" + "</a>" + "</td>");
                        out.print("</tr>");
                        i++;
                    }
                %>
            </table>
            <br>
            <h3>List of Registered Passengers:</h3>
            <table >
                <tr>
                    <th> Id</th> <th>Name</th> <th>Username</th>
                    <th>Edit</th> <th>Delete</th>
                </tr>    

                <%
                    int j = 1;
                    for (db.User p : db.ODBClass.getInstance().readAllUsers())
                    {
                        out.print("<tr>");
                        out.print("<td>" + j + "</td>");
                        out.print("<td>" + p.getName() + "</td>");
                        //out.print("<td>" + p.getLastname() + "</td>");
                        out.print("<td>" + p.getUserName() + "</td>");
                        out.print("<td>" + "<a href=\".\\passengeredit.jsp?username="
                                + p.getUserName() + "&action=edit" + "\">" + "Edit" + "</a>" + "</td>");
                        out.print("<td>" + "<a href=\".\\passengeredit.jsp?username="
                                + p.getUserName() + "&action=delete" + "\">" + "Delete" + "</a>" + "</td>");
                        out.print("</tr>");
                        j++;
                    }
                %>
            </table>
            <br>
            <a href="../index.jsp"> Back to Home </a> 
            | 
            <a href="./logout.jsp"> Logout </a>
            <br>
            </body>
            </html>