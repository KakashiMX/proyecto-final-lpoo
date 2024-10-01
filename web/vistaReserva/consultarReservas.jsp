<%-- 
    Document   : consultarReservas
    Created on : 29 sept 2024, 11:18:07
    Author     : kakashi
--%>

<%@page import="modelo.Huesped"%>
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
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Lista de reservas</title>
    </head>
    <body>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Reserva> reservas = new ArrayList<>();
            ArrayList<Habitacion> habitaciones = new ArrayList<>();
            ArrayList<Huesped> huespedes = new ArrayList<>();
            controlador.conectar();
            
            habitaciones = controlador.consultarHabitaciones();
            reservas = controlador.consultarReservas();
            huespedes = controlador.consultarHuspedes();

        %>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarReserva.jsp" %>
            </div>
            <div class="main-content">
                <div class="form-container">
                    <h1 class="form-title">Consultar Reserva por ID</h1>
                    <form class="form" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="id">ID: </label>
                            <input 
                                type="text" 
                                id="id"
                                class="form-input"
                                placeholder="Ingrese el valor a buscar (ej: 18, 24)"
                                name="id"
                                required
                                />
                        </div>
                        <!-- Botón de envío -->
                        <button type="submit" class="form-submit">Buscar</button>
                    </form>

                    <%
                        Integer idABuscar = null;
                        Reserva reservaId = new Reserva();
                        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("id") != null) {
                            try {
                                // Convertimos el ID en Integer
                                idABuscar = Integer.parseInt(request.getParameter("id"));

                                // Conectamos a la base de datos y buscamos el huésped
                                controlador.conectar();
                                reservas = controlador.consultarReservas();
                                controlador.desconectar();

                                // Buscamos el huésped en la lista por su ID
                                reservaId = reservaId.buscarPorId(reservas, idABuscar);

                            } catch (NumberFormatException e) {
                                out.println("<div class='error'>Error: El ID debe ser un número.</div>");
                            }
                        }
                    %>

                    <br>
                    <%
                    if (idABuscar != null && reservaId != null) { %>
                    <h3>Reserva encontrada</h3>
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
                            out.print("<tr><td>" + reservaId.getIdReserva()+ "</td>");
                            out.print("<td>" + reservaId.getFechaEntrada()+ "</td>");
                            out.print("<td>" + reservaId.getFechaSalida()+ "</td>");
                            out.print("<td>" + reservaId.getFormaPago() + "</td>");
                            out.print("<td>" + reservaId.getIdHabitacion() + "</td>");
                            for( Habitacion habitacion: habitaciones){
                                    if( habitacion.getIdHabitacion() == reservaId.getIdHabitacion()){
                                        out.print("<td>" + habitacion.getTipoHabitacion() + "</td>");
                                    }
                                }
                            out.print("<td>" + reservaId.getValor() + "</td>");
                            for( Huesped huesped: huespedes){
                                    if( huesped.getId() == reservaId.getIdCliente() ){
                                        out.print("<td>" + reservaId.getIdCliente()+ "</td>");
                                        out.print("<td>" + huesped.getNombre()+ " " + huesped.getApellido() + "</td></tr>");
                                    }
                                }
                        %>            
                    </table> 
                    <% } else if (idABuscar != null) {%>
                    <h3>No se encontró ningún huésped con el ID <%= idABuscar%></h3>
                    <% } else { %>
                    <h3>Lista de todos las reservas</h3>
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
                            for (Reserva reserva : reservas) {
                                out.print("<tr><td>" + reserva.getIdReserva() + "</td>");
                                out.print("<td>" + reserva.getFechaEntrada() + "</td>");
                                out.print("<td>" + reserva.getFechaSalida() + "</td>");
                                out.print("<td>" + reserva.getFormaPago()+ "</td>");
                                out.print("<td>" + reserva.getIdHabitacion() + "</td>");
                                for( Habitacion habitacion: habitaciones){
                                    if( habitacion.getIdHabitacion() == reserva.getIdHabitacion()){
                                        out.print("<td>" + habitacion.getTipoHabitacion() + "</td>");
                                    }
                                }
                                out.print("<td>" + reserva.getValor() + "</td>");
                                for( Huesped huesped: huespedes){
                                    if( huesped.getId() == reserva.getIdCliente() ){
                                        out.print("<td>" + reserva.getIdCliente()+ "</td>");
                                        out.print("<td>" + huesped.getNombre()+ " " + huesped.getApellido() + "</td></tr>");
                                    }
                                }
                            }
                            controlador.desconectar();
                        %>            
                    </table> 
                    <% }%>
                </div>
            </div>
        </div>

        <script>
            function validateForm() {
                const idInput = document.getElementById("id").value;
                if (isNaN(idInput) || idInput.trim() === "") {
                    alert("Por favor, ingrese un ID válido.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>
