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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="../src/java/js/dracula.min.js"></script>

    </head>
    <body>


        <!-- <script type="text/javascript">
             //var x = 23;
             //var y = 32;
             // var z = x + y;
             //document.write(z);
             var Dracula = require('../src/java/jsdracula.min');
 
             var Graph = Dracula.Graph;
             var Renderer = Dracula.Renderer.Raphael;
             var Layout = Dracula.Layout.Spring;
             var graph = new Graph();
             graph.addEdge('Banana', 'Apple');
             graph.addEdge('Apple', 'Kiwi');
             graph.addEdge('Apple', 'Dragonfruit');
             graph.addEdge('Dragonfruit', 'Banana');
             graph.addEdge('Kiwi', 'Banana');
 
             var layout = new Layout(graph);
             var renderer = new Renderer('#paper', graph, 400, 300);
             renderer.draw();
 
         </script>
        -->

        <h1> Welcome to TaxiFinder Web App (v0.1.0)</h1>
        <h3>Main Menu</h3> 

        <%
            String loginOrLogoutName;
            String registerOrProfileName;

            String loginOrLogoutLink;
            String registerOrProfileLink;
            loginOrLogoutName = new String("Login");
            loginOrLogoutLink = new String("./user/login.html");

            registerOrProfileName = new String("Register");
            registerOrProfileLink = new String("./user/register.jsp");

            if (session != null)
            {
                if (session.getAttribute("status") != null)
                {

                    loginOrLogoutName = new String("Logout");
                    loginOrLogoutLink = new String("./user/logout.jsp");

                    registerOrProfileName = new String("Hello " + session.getAttribute("username") + " :: Profile");
                    if (session.getAttribute("role").equals("manager"))
                    {
                        registerOrProfileLink = new String("./user/profilemanager.jsp");
                    } else
                    {
                        registerOrProfileLink = new String("./user/profile.jsp");
                    }
                }
            }

        %>

        <div style="border: 1px; margin: 10px;"> 
            <a href=<% out.print(loginOrLogoutLink); %>  <b><%out.print(loginOrLogoutName);%></b> </a>
            <br>
            <a href=<% out.print(registerOrProfileLink);%> ><b><%out.print(registerOrProfileName);%></b></a>
            <br>
            <br>
            <a href="./mapmanager.jsp" ><b>Map Manager</b></a>
            <br>
            <a href="" ><b>Request for Trip</b></a>
            <br>
        </div>

    </body>
</html>
