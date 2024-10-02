<%-- 
    Document   : eliminarHabitacion
    Created on : 1 oct 2024, 6:56:53 a.m.
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="modelo.HabitacionSuite"%>
<%@page import="modelo.HabitacionFamiliar"%>
<%@page import="modelo.HabitacionFamiliar"%>
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
        <title>Eliminar Habitacion</title>
    </head>
    <body>
        <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <%@ include file="sideBarHabitacion.jsp" %>
        </div>
        
        <!-- Main content -->
        <div class="main-content">
            <!-- Título -->
            <h1 class="form-title">Eliminar Habitación</h1>
            <div class="form-container">
                <div>
                    <%
                         ControladorBD controlador = new ControladorBD();
                        if ("POST".equalsIgnoreCase(request.getMethod())
                                && request.getParameter("id") != null) {

                            // Obtenemos los valores del formulario
                            Integer id = Integer.parseInt(request.getParameter("id"));
                            
                            controlador.conectar();
                            controlador.eliminarHabitacion(id);
                            controlador.desconectar();
                            response.sendRedirect(request.getContextPath() + "/vistaHabitacion/eliminarHabitacion.jsp");
                        }
                        %>
                        </div>
                <form class="form" method="post">
                    <div class="form-group">
                        ID: <input 
                            type="text" 
                            class="form-input"
                            placeholder="Ingrese el valor a eliminar (ej: 5, 10)"
                            name="id"
                        />
                    </div>
                    <!-- Botón de envío -->
                    <button
                        type="submit" 
                        class="form-submit"
                    >Eliminar</button>
                </form>
            </div>

            <br>

            <div>
                <%
                    ArrayList<Habitacion> habitaciones = new ArrayList<>();

                    controlador.conectar();
                    habitaciones = controlador.consultarHabitaciones();
                    controlador.desconectar();
                %>

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
                <br><br>
            </div>
        </div>
    </div>
    </body>
</html>