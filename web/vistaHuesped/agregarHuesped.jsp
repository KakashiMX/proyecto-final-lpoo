<%-- 
    Document   : agregarHuesped
    Created on : 28 sept 2024, 14:41:35
    Author     : Usuario
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="modelo.Huesped"%>
<%@page import="datos.ControladorBD"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Huesped</title>
    </head>
    <body>
        <%
            ControladorBD controlador = new ControladorBD();
            controlador.conectar();
            
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            LocalDate fechaNacimiento = LocalDate.parse(request.getParameter("fechaNacimiento"), formato) ;
            String nacionalidad = request.getParameter("nacionalidad");
            String telefono = request.getParameter("telefono");
            
            Huesped huesped = new Huesped(nombre, apellido, fechaNacimiento, nacionalidad, telefono);
            
            controlador.agregarHuesped(huesped);
            
            controlador.desconectar();
            
            response.sendRedirect(request.getContextPath() +"/vistaReserva/reservas.jsp");
            
        %>
    </body>
</html>
