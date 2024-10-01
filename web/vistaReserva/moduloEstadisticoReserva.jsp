<%-- 
    Document   : moduloEstadisticoReserva
    Created on : 30 sept 2024, 11:32:52
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="modelo.Habitacion"%>
<%@page import="modelo.Huesped"%>
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
        <script src="../javascript/script.js"></script>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarReserva.jsp" %>
            </div>
            <div class="main-content">
                <h1 class="form-title">Módulo Estadístico de Reservas</h1>
                <%
                    ControladorBD controlador = new ControladorBD();
                    ArrayList<Reserva> reservas = new ArrayList<>();
                    ArrayList<Huesped> huespedes = new ArrayList<>();
                    ArrayList<Habitacion> habitaciones = new ArrayList<>();
                    controlador.conectar();
                    reservas = controlador.consultarReservas();
                    huespedes = controlador.consultarHuspedes();
                    habitaciones = controlador.consultarHabitaciones();
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
                     <table class="result-table">
                        <tr>
                            <th>Id Reserva</th>
                            <th>Fecha de entrada</th>
                            <th>Fecha de salida</th>
                            <th>Forma de pago</th>
                            <th>Id Habitacion</th>
                            <th>Tipo</th>
                            <th>Costo por noche</th>
                            <th>Id Huésped</th>
                            <th>Nombre Huésped</th>
                        </tr>
                        <%
                            for (Reserva reservaOrdenada : reservasOrdenadas) {
                                out.print("<tr><td>" + reservaOrdenada.getIdReserva() + "</td>");
                                out.print("<td>" + reservaOrdenada.getFechaEntrada() + "</td>");
                                out.print("<td>" + reservaOrdenada.getFechaSalida() + "</td>");
                                out.print("<td>" + reservaOrdenada.getFormaPago()+ "</td>");
                                out.print("<td>" + reservaOrdenada.getIdHabitacion() + "</td>");
                                for( Habitacion habitacion: habitaciones){
                                    if( habitacion.getIdHabitacion() == reservaOrdenada.getIdHabitacion()){
                                        out.print("<td>" + habitacion.getTipoHabitacion() + "</td>");
                                    }
                                }
                                out.print("<td>" + reservaOrdenada.getValor() + "</td>");
                                for( Huesped huesped: huespedes){
                                    if( huesped.getId() == reservaOrdenada.getIdCliente() ){
                                        out.print("<td>" + reservaOrdenada.getIdCliente()+ "</td>");
                                        out.print("<td>" + huesped.getNombre()+ " " + huesped.getApellido() + "</td></tr>");
                                    }
                                }
                            }
                            controlador.desconectar();
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
                            <th>Nombre</th>
                            <th>Días de instancia</th>
                        </tr>
                        <%
                            for (Map.Entry<Integer, Double> entry : estanciaPorCliente.entrySet()) {
                                out.println("<tr><td>" + entry.getKey() + "</td>");
                                for( Huesped huesped: huespedes){
                                    if( huesped.getId() == entry.getKey()){
                                        out.println("<td>" + huesped.getNombre() + " " + huesped.getApellido() + "</td><td>" + entry.getValue() + "</td></tr>");
                                    }
                                }
                            }
                        %>
                    </table>
                    
                    <h2>Forma de pago preferida por los clientes</h2>
                    <table>
                        <tr>
                            <%
                                out.print("<td>" + resultadoFormaPago + "</td>");
                            %>
                            
                            
                        </tr>
                    </table>
                    <br><br>
                    
                    <h2>Promedio de estadia de todos los clientes</h2>
                    <table>
                        <tr>
                            <%
                                out.print("<td>" + resultadoFormaPago + "</td>");
                            %>
                        </tr>
                    </table>
                    <br><br>
                    
                    <h2>Ganancias diarias</h2>
                    <table>
                        <tr>
                            <%
                                out.print("<td>" + resultadoPromedioGananciaPorDia + "</td>");
                            %>
                        </tr>
                    </table>
                    <br><br>
                    
                    
                </div>
            </div>
        </div>
    </body>
</html>
