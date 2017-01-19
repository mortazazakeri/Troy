<%-- 
    Document   : newjspindexindex
    Created on : Dec 7, 2016, 3:38:58 PM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>TaxiFinder - Home </title>
        <meta charset="UTF-8">
        <script type="text/javascript" src="../src/java/js/dracula.min.js"></script>
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
    </head>
    <body>
        <%  String loginOrLogoutName;
            String registerOrProfileName;

            String loginOrLogoutLink;
            String registerOrProfileLink;
            loginOrLogoutName = new String("Login");
            loginOrLogoutLink = new String("./user/login.jsp");

            registerOrProfileName = new String("Register");
            registerOrProfileLink = new String("./user/register.jsp");

            String mapPageDynamicURL = "#";

            if (session != null)
            {
                if (session.getAttribute("status") != null)
                {

                    loginOrLogoutName = new String("Logout");
                    loginOrLogoutLink = new String("./user/logout.jsp");

                    registerOrProfileName = new String("Profile");
                    if (session.getAttribute("role").toString().equals("manager"))
                    {
                        registerOrProfileLink = new String("./user/profilemanager.jsp?username="
                                + session.getAttribute("username"));
                        mapPageDynamicURL = new String("./map/managermap.jsp");
                    } else if (session.getAttribute("role").toString().equals("driver"))
                    {
                        registerOrProfileLink = new String("./user/driveredit.jsp?username="
                                + session.getAttribute("username"));
                        mapPageDynamicURL = new String("./map/drivermap.jsp");
                    } else if (session.getAttribute("role").toString().equals("passenger"))
                    {
                        registerOrProfileLink = new String("./user/passengeredit.jsp?username="
                                + session.getAttribute("username"));
                        mapPageDynamicURL = new String("./map/passengermap.jsp");
                    }
                }
            }
        %>
        <!-- Navbar -->
        <div class="w3-top">
            <ul class="w3-navbar w3-yellow w3-card-2 w3-left-align w3-large">
                <li class="w3-hide-medium w3-hide-large w3-opennav w3-right">
                    <a class="w3-padding-large w3-hover-white w3-large w3-red" href="javascript:void(0);" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
                </li>
                <li><a href="#" class="w3-padding-large w3-white">Home</a></li>
                    <%
                        if (session != null && session.getAttribute("status") != null)
                        {
                            out.print("<li class=\"w3-hide-small\"><a href=\"" + mapPageDynamicURL + "\" class=\"w3-padding-large w3-hover-white\"><b> Map </b></a></li>");
                        }
                    %>
                <li class="w3-hide-small"><a href="<% out.print(registerOrProfileLink);%>" class="w3-padding-large w3-hover-white"><b> <%out.print(registerOrProfileName);%> </b></a></li>
                <li class="w3-hide-small"><a href="<% out.print(loginOrLogoutLink);%>" class="w3-padding-large w3-hover-white"><b> <%out.print(loginOrLogoutName);%> </b></a></li>                
                <li class="w3-hide-small"><a href="#" class="w3-padding-large w3-hover-white"><b> Help and About </b></a></li>
            </ul>

            <!-- Navbar on small screens -->
            <div id="navDemo" class="w3-hide w3-hide-large w3-hide-medium">
                <ul class="w3-navbar w3-left-align w3-large w3-black">
                    <li><a class="w3-padding-large" href="<% out.print(registerOrProfileLink);%>"><b> <%out.print(registerOrProfileName);%> </b></a></li>
                    <li><a class="w3-padding-large" href="<% out.print(loginOrLogoutLink);%>"><b> <%out.print(loginOrLogoutName);%> </b></a></li>
                    <!-- <li><a class="w3-padding-large" href=""><b> Request for Trip  </b></a></li>-->
                    <li><a class="w3-padding-large" href="<% out.print(mapPageDynamicURL);%>"><b> Map </b></a></li>
                    <!--<li><a class="w3-padding-large" href="./map/drivermap.jsp"> <b> Driver Map </b> </a></li>
                    <li><a class="w3-padding-large" href="./map/passengermap.jsp"><b> Passenger Map </b></a></li>-->
                    <li><a class="w3-padding-large" href=""><b> Help and About </b></a></li>
                </ul>
            </div>
        </div>

        <!-- Header -->
        <header class="w3-container w3-orange w3-center w3-padding-128">
            <h1 class="w3-margin w3-jumbo w3-hover-text-grey">TaxiFinder Web App</h1>
            <%
                if (session != null && session.getAttribute("status") != null)
                {
                    out.print("<h2> Weclome " + session.getAttribute("username") + "!" + " </h2>");
                }
            %>
        </header>

        <!-- Footer -->
        <footer class="w3-container w3-padding-64 w3-center w3-opacity">  
            <div class="w3-xlarge w3-padding-32">
                <p class="w3-hover-text-indigo">Follow us!</p>
                <a href="#" class="w3-hover-text-indigo"><i class="fa fa-facebook-official"></i></a>
                <a href="#" class="w3-hover-text-red"><i class="fa fa-pinterest-p"></i></a>
                <a href="#" class="w3-hover-text-light-blue"><i class="fa fa-twitter"></i></a>
                <a href="#" class="w3-hover-text-grey"><i class="fa fa-flickr"></i></a>
                <a href="#" class="w3-hover-text-indigo"><i class="fa fa-linkedin"></i></a>
            </div>
        </footer>

        <script>
            // Used to toggle the menu on small screens when clicking on the menu button
            function myFunction() {
                var x = document.getElementById("navDemo");
                if (x.className.indexOf("w3-show") === -1) {
                    x.className += " w3-show";
                } else {
                    x.className = x.className.replace(" w3-show", "");
                }
            }
        </script>
    </body>
</html>
