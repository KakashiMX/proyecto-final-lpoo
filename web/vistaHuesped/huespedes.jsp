<%-- 
    Document   : huespedes
    Created on : 28 sept 2024, 14:30:10
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Huesped"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Huespedes</title>
    </head>
    <body>
        <h1>Huespedes</h1>

        <ul>
            <li><a href="agregarHuesped.jsp">Registar Huespedes</a></li>    
            <li><a href="actualizarHuesped.jsp">Modificar Huespedes</a></li> 
            <li><a href="eliminarHuesped.jsp">Borrar Huespedes</a></li>
            <li><a href="consultarHuespedes.jsp">Consultar Huespedes</a></li>
            <li><a href="moduloEstadisticoHuesped.jsp">Modulo Estadistico de Huespedes</a></li> 
        </ul>
       
    </body>
</html>
