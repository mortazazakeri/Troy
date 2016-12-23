<%-- 
    Document   : login
    Created on : Dec 23, 2016, 1:09:43 AM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>TaxiFinder - Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%
            if (session.getAttribute("status") != null)
            {
                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>
    </head>
    <body>
        <div>
            <h2>User Login</h2>
            <form action="./loginprocess.jsp" method="post">
                <fieldset>
                    <legend>User information:</legend>
                    Username:<br>
                    <input type="text" name="username" value=""><br>
                    Password:<br>
                    <input type="password" name="password" value=""><br>
                    Role:<br>
                    <select name="role">
                        <option value="driver">Driver</option>
                        <option value="passenger">Passenger</option>
                        <option value="manager">Manager</option>
                    </select>
                    <br>
                    <input type="submit" value="Login">
                </fieldset>
            </form> 
        </div>
        <a href="../index.jsp"> Back to Home </a> 
         | 
        <a href="./register.jsp"> Register </a>
    </body>
</html>