<%-- 
    Document   : actualizarHuesped
    Created on : 28 sept 2024, 15:38:37
    Author     : Usuario
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="modelo.Huesped"%>
<%@page import="java.time.LocalDate"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar Huesped</title>
    </head>
    <body>
        <%
            ControladorBD controlador = new ControladorBD();
            controlador.conectar();
            
            Integer id=Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            LocalDate fechaNacimiento = LocalDate.parse(request.getParameter("fechaNacimiento"), formato) ;
            String nacionalidad = request.getParameter("nacionalidad");
            String telefono = request.getParameter("telefono");
                       
            controlador.actualizarHuesped(nombre, apellido, fechaNacimiento, nacionalidad, telefono, id);
            
            controlador.desconectar();
            
            response.sendRedirect("modificarHuespedes.jsp");
            
        %>
    </body>
</html>
