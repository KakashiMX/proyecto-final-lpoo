<%-- 
    Document   : consultarHabitacion
    Created on : 1 oct 2024, 6:56:38 a.m.
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="modelo.HabitacionSuite"%>
<%@page import="modelo.HabitacionFamiliar"%>
<%@page import="modelo.HabitacionSencilla"%>
<%@page import="modelo.Habitacion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Consultar Habitación</title>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarHabitacion.jsp" %>
            </div>

            <div class="main-content">
                <div class="form-container">
                    <h1 class="form-title">Consultar habitación por ID</h1>
                    <form class="form" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="idHabitacion">ID Habitación:</label>
                            <input 
                                type="text" 
                                id="id"
                                class="form-input"
                                placeholder="Ingrese el valor a buscar (ej: 4, 10)"
                                name="id"
                                required
                                />
                        </div>
                        <!-- Botón de envío -->
                        <button type="submit" class="form-submit">Buscar</button>
                    </form>

                    <%
                        ControladorBD controlador = new ControladorBD();
                        controlador.conectar();
                        Integer id = null;
                        ArrayList<Habitacion> habitaciones = new ArrayList<>();
                        Habitacion habitacionID = null;
                        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("id") != null) {
                            try {
                                // Convertimos el ID en Integer
                                id = Integer.parseInt(request.getParameter("id"));

                                // Conectamos a la base de datos y buscamos la habitación
                                habitaciones = controlador.consultarHabitaciones();
                                controlador.desconectar();

                                // Buscamos la habitación en la lista por su ID
                                for (Habitacion habitacion : habitaciones) {
                                    if (habitacion.getIdHabitacion() == id) {
                                        habitacionID = habitacion;
                                        break;
                                    }
                                }
                            } catch (NumberFormatException e) {
                                out.println("<div class='error'>Error: El ID debe ser un número.</div>");
                            }
                        }
                    %>

                    <br>
                    <%
                    if (id != null && habitacionID != null) { %>
                    <h3>Habitación encontrada</h3>
                    <table class="result-table">
                        <tr>
                            <th>Id Habitación</th>
                            <th>Número de habitación</th>
                            <th>Tipo</th>
                            <th>Servicios extra</th>
                            <th>Disponibilidad</th>
                            <th>Precio</th>
                            <th>Precio con servicios extra</th>
                        </tr>
                        <%
                            out.print("<tr><td>" + habitacionID.getIdHabitacion() + "</td>");
                            out.print("<td>" + habitacionID.getNumHabitacion() + "</td>");
                            out.print("<td>" + habitacionID.getTipoHabitacion() + "</td>");

                            // Verificar el tipo de habitación y mostrar los atributos específicos
                            if (habitacionID instanceof HabitacionFamiliar) {
                                HabitacionFamiliar familiar = (HabitacionFamiliar) habitacionID;
                                out.print("<td>Capacidad máxima: " + familiar.getCapacidadMaxima() +
                                          ", Cocina: " + (familiar.isTieneCocina() ? "Sí" : "No") +
                                          ", Sala: " + (familiar.isTieneSala() ? "Sí" : "No") + "</td>");
                            } else if (habitacionID instanceof HabitacionSuite) {
                                HabitacionSuite suite = (HabitacionSuite) habitacionID;
                                out.print("<td>Servicio habitación: " + (suite.isServicioHabitacion() ? "Sí" : "No") +
                                          ", Vista: " + suite.getVista() + "</td>");
                            } else {
                                out.print("<td>No aplica</td>"); // HabitacionSencilla no tiene servicios extra
                            }

                            // Mostrar disponibilidad
                            if (habitacionID.isDisponibilidad()) {
                                out.print("<td>Disponible</td>");
                            } else {
                                out.print("<td>No disponible</td>");
                            }

                            // Mostrar precios
                            out.print("<td>" + habitacionID.getPrecio() + "</td>");
                            out.print("<td>" + habitacionID.getPrecioTotalTipoHabitacion() + "</td>");
                            out.print("</tr>");
                        %>            
                    </table> 
                    <% } else if (id != null) {%>
                    <h3>No se encontró ninguna habitación con el ID <%= id%></h3>
                    <% } else { %>
                    <h3>Lista de todas las habitaciones</h3>
                    <table class="result-table">
                        <tr>
                            <th>Id Hábitación</th>
                            <th>Número de habitación</th>
                            <th>Tipo</th>
                            <th>Servicios extra</th>
                            <th>Disponibilidad</th>
                            <th>Precio</th>
                            <th>Precio con servicios extra</th>
                        </tr>
                        <%
                            controlador.conectar();
                            habitaciones = controlador.consultarHabitaciones();
                            controlador.desconectar();

                            // Iterar sobre todas las habitaciones y mostrarlas en la tabla
                            for (Habitacion hb : habitaciones) {
                                out.print("<tr>");
                                out.print("<td>" + hb.getIdHabitacion() + "</td>");
                                out.print("<td>" + hb.getNumHabitacion() + "</td>");
                                out.print("<td>" + hb.getTipoHabitacion() + "</td>");

                                // Comprobar el tipo de habitación y mostrar los atributos adicionales
                                if (hb instanceof HabitacionFamiliar) {
                                    HabitacionFamiliar familiar = (HabitacionFamiliar) hb;
                                    out.print("<td>Capacidad máxima: " + familiar.getCapacidadMaxima() +
                                              ", Cocina: " + (familiar.isTieneCocina() ? "Sí" : "No") +
                                              ", Sala: " + (familiar.isTieneSala() ? "Sí" : "No") + "</td>");
                                } else if (hb instanceof HabitacionSuite) {
                                    HabitacionSuite suite = (HabitacionSuite) hb;
                                    out.print("<td>Servicio a la habitación: " + (suite.isServicioHabitacion() ? "Sí" : "No") +
                                              ", Vista: " + suite.getVista() + "</td>");
                                } else {
                                    out.print("<td>No aplica</td>"); // HabitacionSencilla no tiene servicios extra
                                }

                                // Mostrar disponibilidad
                                if (hb.isDisponibilidad()) {
                                    out.print("<td>Disponible</td>");
                                } else {
                                    out.print("<td>No disponible</td>");
                                }

                                // Mostrar precios
                                out.print("<td>" + hb.getPrecio() + "</td>");
                                out.print("<td>" + hb.getPrecioTotalTipoHabitacion() + "</td>");
                                out.print("</tr>");
                            }
                        %>            
                    </table> 
                    <% } %>
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
