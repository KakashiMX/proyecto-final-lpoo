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
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Lista de reservas</title>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <!-- Logo -->
                <img src="../assets/images/logo.jpeg" alt="Hotel Logo">
                <ul>
                    <li><a href="reservas.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Reservas</a></li>  
                    <li><a href="actualizarReserva.jsp" class="menu-link"><i class="fas fa-user-edit"></i> Modificar Reservas</a></li> 
                    <li><a href="eliminarReserva.jsp" class="menu-link"><i class="fas fa-user-times"></i> Borrar Reserva</a></li>
                    <li><a href="consultarReservas.jsp" class="menu-link"><i class="fas fa-users"></i> Consultar Reserva</a></li>
                    <li><a href="moduloEstadisticoReserva.jsp" class="menu-link"><i class="fas fa-chart-bar"></i> Módulo Estadístico</a></li>    
                </ul>
            </div>
            
            <div class="main-content">
                <div class="form-container">
                    <h1 class="form-title">Consultar Reserva por ID</h1>
                    <form class="form" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="id">Id</label>
                            <input 
                                type="text" 
                                id="id"
                                class="form-input"
                                placeholder="ID"
                                name="id"
                                required
                                />
                        </div>
                        <!-- Botón de envío -->
                        <button type="submit" class="form-submit">Buscar</button>
                    </form>

                    <%
                        ControladorBD controlador = new ControladorBD();
                        Integer idABuscar = null;
                        ArrayList<Reserva> reservas = new ArrayList<>();
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
                            <th>Fecha entrada</th>
                            <th>Fecha Salida</th>
                            <th>Forma de pago</th>
                            <th>Id Habitacion</th>
                            <th>costo por noche</th>
                            <th>Id Huésped</th>
                        </tr>
                        <%
                            out.print("<tr><td>" + reservaId.getIdReserva()+ "</td>");
                            out.print("<td>" + reservaId.getFechaEntrada()+ "</td>");
                            out.print("<td>" + reservaId.getFechaSalida()+ "</td>");
                            out.print("<td>" + reservaId.getFormaPago() + "</td>");
                            out.print("<td>" + reservaId.getIdHabitacion() + "</td>");
                            out.print("<td>" + reservaId.getValor() + "</td>");
                            out.print("<td>" + reservaId.getIdCliente() + "</td></tr>");
                        %>            
                    </table> 
                    <% } else if (idABuscar != null) {%>
                    <h3>No se encontró ningún huésped con el ID <%= idABuscar%></h3>
                    <% } else { %>
                    <h3>Lista de todos los huéspedes</h3>
                    <table class="result-table">
                        <tr>
                            <th>Id Reserva</th>
                            <th>Fecha entrada</th>
                            <th>Fecha Salida</th>
                            <th>Forma de pago</th>
                            <th>Id Habitacion</th>
                            <th>costo por noche</th>
                            <th>Id Huésped</th>
                        </tr>
                        <%
                            controlador.conectar();
                            reservas = controlador.consultarReservas();
                            for (Reserva reserva : reservas) {
                                out.print("<tr><td>" + reserva.getIdReserva() + "</td>");
                                out.print("<td>" + reserva.getFechaEntrada() + "</td>");
                                out.print("<td>" + reserva.getFechaSalida() + "</td>");
                                out.print("<td>" + reserva.getFormaPago()+ "</td>");
                                out.print("<td>" + reserva.getIdHabitacion() + "</td>");
                                out.print("<td>" + reserva.getValor() + "</td>");
                                out.print("<td>" + reserva.getIdCliente()+ "</td></tr>");
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
