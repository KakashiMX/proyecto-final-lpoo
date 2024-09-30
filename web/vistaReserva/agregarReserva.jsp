<%-- 
    Document   : agregarReserva
    Created on : 28 sept 2024, 19:08:47
    Author     : kakashi
--%>

<%@page import="modelo.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Habitacion"%>
<%@page import="modelo.Reserva"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.Date"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Reserva</title>
    </head>
    <body>
        <%
            ControladorBD controlador = new ControladorBD();
            controlador.conectar();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaEntrada = new Date(sdf.parse(request.getParameter("fechaEntrada")).getTime());
            Date fechaSalida = new Date(sdf.parse(request.getParameter("fechaSalida")).getTime());
            String formaPago = request.getParameter("formaPago");
            String informacionHabitacion [] = request.getParameter("habitacionDisponible").split(",");
            int idHabitacion = Integer.parseInt(informacionHabitacion[0]);
            float precio = Float.parseFloat(informacionHabitacion[1]);
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            
            Reserva reserva = new Reserva(fechaEntrada, fechaSalida, precio, formaPago, idHabitacion, idCliente);
            controlador.agregarReserva(reserva);
            
            controlador.actualizarHabitacion(idHabitacion, false, precio);
            controlador.desconectar();
            
            response.sendRedirect("reservas.jsp");
            
        %>
        
       
    </body>
</html>
