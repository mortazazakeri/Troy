<%-- 
    Document   : acceptrequest
    Created on : Jan 20, 2017, 12:59:25 AM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TaxiFinder - Accept Request</title>
        <%
            if (session.getAttribute("status") == null)
            {
                String site = new String("./login.jsp");
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);
            } else if (session.getAttribute("role").equals("driver") == false && session.getAttribute("role").equals("manager") == false)
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
    <body>

        <%
            int tripRequestId = Integer.parseInt(request.getParameter("requestId").toString());
            trip.TripRequestManager.getTripRequsetManagerInstance().
                    updateTripRequestStatusAndDriver(tripRequestId, "accept", session.getAttribute("username").toString());

            String site = new String("../user/driveredit.jsp");
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site);
        %>


    </body>
</html>
