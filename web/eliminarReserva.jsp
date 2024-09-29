<%-- 
    Document   : eliminarReserva
    Created on : 28 sept 2024, 20:04:37
    Author     : kakashi
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Reserva"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Reserva</title>
    </head>
    <body>
        <%
        ControladorBD controlador = new ControladorBD();
        controlador.conectar();
        
        int idReserva= Integer.parseInt(request.getParameter("idReserva"));
        
        ArrayList<Reserva> reservas = controlador.consultarReservas();
        // Si se elimina una reserva, se tiene que actualizar el estado de la habitación a disponible
        for(Reserva reserva: reservas){
            if( idReserva == reserva.getIdReserva()){
                controlador.actualizarHabitacion(reserva.getIdHabitacion(), true, reserva.getValor());
            }
        }
        controlador.eliminarReserva(idReserva);
        controlador.desconectar();
        
        response.sendRedirect("reservas.jsp");
        
        %>
    </body>
</html>
