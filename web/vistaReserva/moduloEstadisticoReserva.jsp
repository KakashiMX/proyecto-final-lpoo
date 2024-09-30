<%-- 
    Document   : moduloEstadisticoReserva
    Created on : 30 sept 2024, 11:32:52
    Author     : kakashi
--%>

<%@page import="java.util.Map"%>
<%@page import="modelo.Reserva"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Modulo Estadistico Reserva</title>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarReserva.jsp" %>
            </div>
            <div class="main-content">
                <h1 class="form-title">Módulo Estadístico de Reservas</h1>
                <%
                    ControladorBD controlador = new ControladorBD();
                    ArrayList<Reserva> reservas = new ArrayList<>();
                    controlador.conectar();
                    reservas = controlador.consultarReservas();
                    Reserva reserva = new Reserva();
                    String resultadoFormaPago = reserva.promedioFormaDePago(reservas);
                    String resultadoPromedioEstadia = reserva.promedioTiempoEstadia(reservas);
                    String resultadoPromedioGananciaPorDia = reserva.promedioGananciaPorDia(reservas);
                    ArrayList<Reserva> reservasOrdenadas =reserva.ordenarPorFechaEntrada(reservas);
                    Map<String, Integer> reservasPorMes = reserva.obtenerReservasPorMes(reservas);
                    Map<Integer, Double> estanciaPorCliente = reserva.obtenerPromedioEstadiaPorCliente(reservas);
                    
                %>

                <div class="main-content">
                    <h2>Reservas ordenadas por fecha de entrada</h2>
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
                        for (Reserva reservaOrdenada: reservasOrdenadas) {
                            out.print("<tr><td>" + reservaOrdenada.getIdReserva() + "</td>");
                            out.print("<td>" + reservaOrdenada.getFechaEntrada() + "</td>");
                            out.print("<td>" + reservaOrdenada.getFechaSalida() + "</td>");
                            out.print("<td>" + reservaOrdenada.getFormaPago()+ "</td>");
                            out.print("<td>" + reservaOrdenada.getIdHabitacion() + "</td>");
                            out.print("<td>" + reservaOrdenada.getValor() + "</td>");
                            out.print("<td>" + reservaOrdenada.getIdCliente()+ "</td></tr>");
                        }
                    %>     
                    </table>
                    
                    <h2>Reservas por mes</h2>
                    <table>
                        <tr>
                            <th>Mes</th>
                            <th>Número de reservas</th>
                        </tr>
                        <%
                            for (Map.Entry<String, Integer> entry : reservasPorMes.entrySet()) {
                                out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                            }
                        %>
                    </table>
                    <br><br>
                    
                    <h2>Promedio de estadia por Huésped</h2>
                    <table>
                        <tr>
                            <th>ID Huésped</th>
                            <th>Días</th>
                        </tr>
                        <%
                            for (Map.Entry<Integer, Double> entry : estanciaPorCliente.entrySet()) {
                                out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                            }
                        %>
                    </table>
                    
                    <h2>Forma de pago preferida por los clientes</h2>
                    <%
                        out.print("<p>" + resultadoFormaPago + "</p");
                    %>
                    <br><br>
                    
                    <h2>Promedio de estadia de todos los clientes</h2>
                    <%
                        out.print("<p>" + resultadoPromedioEstadia + "</p");
                    %>
                    <br><br>
                    
                    <h2>Ganancias diarias</h2>
                    <%
                        out.print("<p>" + resultadoPromedioGananciaPorDia + "</p");
                    %>
                    <br><br>
                    
                    
                </div>
            </div>
        </div>
    </body>
</html>
