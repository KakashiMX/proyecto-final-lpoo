<%-- 
    Document   : consultarReservas
    Created on : 29 sept 2024, 11:18:07
    Author     : kakashi
--%>

<%@page import="modelo.Usuario"%>
<%@page import="modelo.Habitacion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Reserva"%>
<%@page import="datos.ControladorBD"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de reservas</title>
    </head>
    <body>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Reserva> reservas = new ArrayList<>();
            ArrayList<Habitacion> habitaciones = new ArrayList<>();
            ArrayList<Usuario> clientes = new ArrayList<>();
            controlador.conectar();
            
            habitaciones = controlador.consultarHabitaciones();
            reservas = controlador.consultarReservas();
            clientes = controlador.consultarUsuarios();
            controlador.desconectar();

        %>
        <table border=1, width="800">
            <tr>
                <th>Id Reserva</th>
                <th>Fecha entrada</th>
                <th>Fecha Salida</th>
                <th>Forma de pago</th>
                <th>Id Habitacion</th>
                <th>costo por noche</th>
                <th>Id cliente</th>
            </tr>
            <%
                for (Reserva reserva : reservas) {
                    out.print("<tr><td>" + reserva.getIdReserva() + "</td>");
                    out.print("<td>" + reserva.getFechaEntrada() + "</td>");
                    out.print("<td>" + reserva.getFechaSalida() + "</td>");
                    out.print("<td>" + reserva.getFormaPago()+ "</td>");
                    out.print("<td>" + reserva.getIdHabitacion() + "</td>");
                    out.print("<td>" + reserva.getValor() + "</td>");
                    out.print("<td>" + reserva.getIdCliente()+ "</td></tr>");
                }
            %>            
        </table>
    </body>
</html>
