<%-- 
    Document   : register
    Created on : Dec 7, 2016, 4:24:22 PM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div>
            <h2> User Register </h2>
            <form action="./registerprocess.jsp" method="post">
                <fieldset>
                    <legend>User information:</legend>
                    First Name:<br>
                    <input type="text" name="name" value=""><br>
                   <!-- Last Name:<br>
                    <input type="text" name="lastname" value=""><br>      
                   -->
                    Username:<br>
                    <input type="text" name="username" value=""><br>
                    Password:<br>
                    <input type="password" name="password" value=""><br>
                    Role:<br>
                    <select name="role">
                        <option value="driver">Driver</option>
                        <option value="passenger">Passenger</option>
                    </select>
                    <br>
                    <input type="submit" value="Register">
                </fieldset>
            </form> 
            <a href="../index.jsp"> Back to Home </a> 
            | 
            <a href="./login.html"> Login </a>
        </div>
    </body>
</html>
