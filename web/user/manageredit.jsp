<%-- 
    Document   : manageredit
    Created on : Dec 8, 2016, 11:58:41 AM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Manager Edit</title>
    </head>
    <body>


        <%

            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String username = session.getAttribute("username").toString();
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            String oldpassword = session.getAttribute("password").toString();

            user.Manager old = (user.Manager) user.UserRepository.getUserRepositoryInstance().getUser(username, oldpassword, role);

            if (old != null)
            {
                user.Manager newManager = user.UserRepository.getUserRepositoryInstance().updateManager(old);

                out.println("Your profile uccessfully update!");
                session.setAttribute("session", "TRUE");
                session.setAttribute("status", "logged");

                session.setAttribute("firstname", newManager.getFirstname());
                session.setAttribute("lastname", newManager.getLastname());
                session.setAttribute("username", username);
                session.setAttribute("password", newManager.getPassword());
                session.setAttribute("role", role);
                //session.setAttribute("loggedUser", loggedUser);

                String site = new String("./profilemanager.jsp?action=updated");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);

            } else
            {
                out.print(" Sorry, username or password is not correct! ");
                out.print("<a href=\"./profilemanager.jsp\"> Back to Profile  </a>");
                out.print(" or ");
                out.print("<a href=\"./logout.jsp\"> Logout </a>");
        %>  
        <%--jsp:include page="../index.html"></jsp:include> --%>
        <%
            }

        %>  


    </body>
</html>
