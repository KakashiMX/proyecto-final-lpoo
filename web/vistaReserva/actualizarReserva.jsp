<%-- 
    Document   : actualizarReserva
    Created on : 29 sept 2024, 08:37:40
    Author     : kakashi
--%>

<%@page import="modelo.Usuario"%>
<%@page import="modelo.Habitacion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Reserva"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar Reserva</title>
    </head>
    <body>
        
        <%
            ControladorBD controlador = new ControladorBD();
            controlador.conectar();
            ArrayList<Reserva> reservas = controlador.consultarReservas();
            
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fechaEntrada = new Date(sdf.parse(request.getParameter("nuevaFechaEntrada")).getTime());
            Date fechaSalida = new Date(sdf.parse(request.getParameter("nuevaFechaSalida")).getTime());
            String formaPago = request.getParameter("nuevaFormaPago");
            String informacionHabitacion[] = request.getParameter("nuevaHabitacionesDisponibles").split(",");
            System.out.println(informacionHabitacion);
            int idHabitacion = Integer.parseInt(informacionHabitacion[0]);
            float precio = Float.parseFloat(informacionHabitacion[1]);
            
            for( Reserva reserva: reservas){
                if( reserva.getIdReserva() == idReserva){
                    controlador.actualizarHabitacion(reserva.getIdHabitacion(), true, reserva.getValor());
                }
            }
            controlador.actualizarReserva(idReserva, fechaEntrada, fechaSalida, precio, formaPago, idHabitacion);
            controlador.actualizarHabitacion(idHabitacion, false, precio);
            controlador.desconectar();
            
            response.sendRedirect("reservas.jsp");
            
        %>
    </body>
</html>
