<%-- 
    Document   : newjspconsultarHuespedesPorId
    Created on : 28 sept 2024, 20:48:30
    Author     : Usuario
--%>

<%@page import="modelo.Huesped"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buscar Huesped por id</title>
    </head>
    <body>
        <h1>Buqueda por id</h1>

        <form action="huespedId.jsp" method="post">
            Id <input type="text" name="id" size="15"><br><br>
            
            <br><br>
            <input type="submit" value="buscar"> 

        </form>
        
        
    </body>
</html>
