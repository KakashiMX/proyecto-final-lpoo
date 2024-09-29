<%-- 
    Document   : huespedes
    Created on : 28 sept 2024, 14:30:10
    Author     : Usuario
--%>

<%@page import="modelo.Nacionalidad"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Huesped"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Huespedes</title>
    </head>
    <body>
        <h1>Huespedes</h1>

        <ul>
            <li><a href="registroHuespedes.jsp">Registar Huespedes</a></li>    
            <li><a href="modificarHuespedes.jsp">Modificar Huespedes</a></li> 
            <li><a href="borrarHuespedes.jsp">Borrar Huespedes</a></li> 
        </ul>
       
    </body>
</html>
