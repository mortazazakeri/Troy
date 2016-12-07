<%-- 
    Document   : mapmanager
    Created on : Dec 7, 2016, 11:46:11 AM
    Author     : Morteza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Map</title>
    </head>
    <body>
        <h1>Map Editor</h1>
        <form action="mapsaver.jsp" action="get">
            <fieldset>
                <legend>Node information:</legend>
                Node name:<br>
                <input type="text" name="nodename" value=""><br>
                Node Description:<br>
                <input type="text" name="nodedescription" value=""><br><br>
                <input type="submit" value="create">
            </fieldset>
        </form> 
        <br>
         <iframe id="maparea" width="100%" height="400" src="" >
         
        </iframe>
        
    </body>
</html>
