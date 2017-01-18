<%-- 
    Document   : register
    Created on : Dec 7, 2016, 4:24:22 PM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Register</title>
        <meta charset="UTF-8">
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
        <%
            if (session.getAttribute("status") != null) {
                String site = new String("../index.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            }
        %>
    </head>
    <body style="margin-left: 25%; margin-right: 25%; margin-top: 1%">
        <!-- Header -->
        <header class="w3-container w3-blue w3-round-xlarge">
            <h1 class="w3-margin w3-jumbo w3-center w3-hover-text-indigo">Sign up!</h1>
        </header>
        <form class="w3-container w3-center" style="margin-top: 5%" action="./registerprocess.jsp" method="post">
            <div class="w3-container w3-left-align">
                <label class="w3-label">Name</label>
                <input class="w3-input w3-center" type="text" name="name" value="">

                <br>
                
                <label class="w3-label">Username</label>
                <input class="w3-input w3-center" type="text" name="username" value="">

                <br>
                
                <label class="w3-label">Password</label>
                <input class="w3-input w3-center" type="password" name="password" value="">
                
                <label class="w3-label">Role</label>
                <select class="w3-select" name="role">
                    <option value="passenger">Passenger</option>
                    <option value="driver">Driver</option>
                </select>
                <input class="w3-btn w3-round-large w3-center" style="width: 25%; margin-left: 37.5%; margin-top: 10%" type="submit" value="Register!">
            </div>
            <a class="w3-hover-text-red" href="../index.jsp"> Home Page </a> 
            | 
            <a class="w3-hover-text-red" href="./login.jsp"> Login </a>
        </form>
    </body>
</html>
