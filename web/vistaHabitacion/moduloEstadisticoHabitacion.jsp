<%-- 
    Document   : moduloEstadisticoHabitacion
    Created on : 30 sep 2024, 5:38:01 p.m.
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="modelo.HabitacionSuite"%>
<%@page import="modelo.HabitacionFamiliar"%>
<%@page import="modelo.HabitacionSencilla"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Habitacion"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Modulo Estadistico Habitacion</title>
        <style>
        th {
            text-align: center;
        }
    </style>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarHabitacion.jsp" %>
            </div>
            <div class="main-content">
                <h1 class="form-title">Módulo Estadístico de Habitación</h1>
                <%
                    ControladorBD controlador= new ControladorBD ();
                    ArrayList<Habitacion> habitaciones = new ArrayList<>();
                    ArrayList<HabitacionFamiliar> habitacionesFamiliar = new ArrayList<>();
                    ArrayList<HabitacionSuite> habitacionesSuite = new ArrayList<>();
                    controlador.conectar();
                    habitaciones = controlador.consultarHabitaciones();
                    controlador.desconectar();
                    
                    // Separar las habitaciones por tipo
                    for (Habitacion habitacion : habitaciones) {
                        if (habitacion instanceof HabitacionFamiliar) {
                            habitacionesFamiliar.add((HabitacionFamiliar) habitacion);  // Cast a HabitacionFamiliar
                        } else if (habitacion instanceof HabitacionSuite) {
                            habitacionesSuite.add((HabitacionSuite) habitacion);  // Cast a HabitacionSuite
                        }
                    }
                    
                    HabitacionSencilla habitacionSencilla = new HabitacionSencilla ();
                    HabitacionFamiliar habitacionFamiliar = new HabitacionFamiliar();
                    HabitacionSuite habitacionSuite = new HabitacionSuite();
                    String resultadoHbMasSolicitada = habitacionSencilla.obtenerHabitacionMasSolicitada(habitaciones);
                    ArrayList<Habitacion> resultadoHbDisponibles = habitacionSencilla.mostrarHabitacionDisponible(habitaciones);
                    ArrayList<Habitacion> resultadoHbNoDispo = habitacionSencilla.mostrarHabitacionNoDisponible(habitaciones);
                    ArrayList<HabitacionFamiliar> resultadoHabitS= habitacionFamiliar.mostrarHabitacionConSala(habitacionesFamiliar);
                    ArrayList<HabitacionSuite> resultadoHabServi = habitacionSuite.mostrarHabitacionConServicio(habitacionesSuite);
                    %>
                   
                    
                    <div class="main-content">
                        <h2>Habitación más solicitada</h2>
                        <table> 
                            <tr>
                                <% 
                                    out.print("<td>" + resultadoHbMasSolicitada + "</td>");
                                %>
                            </tr>
                        </table>
                    <br><br>
                    </div>
                    <div class="main-content">
                        <h2>Habitaciones disponibles</h2> 
                        <table> 
                            <tr>
                                <th>ID Habitación</th>
                                <th>Número de Habitación</th>
                                <th>Tipo</th>
                                <th>Precio</th>
                            </tr>
                            <%
                                for (Habitacion hbDispo: resultadoHbDisponibles){
                                out.print("<tr><td>" + hbDispo.getIdHabitacion()+"</td>");
                                out.print("<td>" + hbDispo.getNumHabitacion()+"</td>");
                                out.print("<td>" + hbDispo.getTipoHabitacion()+"</td>");
                                out.print("<td>" + hbDispo.getPrecio()+"</td></tr>");
                                }
                                %>
                        </table>
                    </div>
                        <div class="main-content">
                        <h2>Habitaciones no disponibles</h2> 
                        <table> 
                            <tr>
                                <th>ID Habitación</th>
                                <th>Número de Habitación</th>
                                <th>Tipo</th>
                            </tr>
                            <%
                                for (Habitacion hbDispo: resultadoHbNoDispo){
                                out.print("<tr><td>" + hbDispo.getIdHabitacion()+"</td>");
                                out.print("<td>" + hbDispo.getNumHabitacion()+"</td>");
                                out.print("<td>" + hbDispo.getTipoHabitacion()+"</td></tr>");
                                }
                                %>
                        </table>
                    </div>
                        <div class="main-content">
                        <h2>Habitaciones con Sala</h2> 
                        <table> 
                            <tr>
                                <th>ID Habitación</th>
                                <th>Número de Habitación</th>
                            </tr>
                            <%
                                for (HabitacionFamiliar hbSala: resultadoHabitS){
                                out.print("<tr><td>" + hbSala.getIdHabitacion()+"</td>");
                                out.print("<td>" + hbSala.getNumHabitacion()+"</td>");
                    
                                }
                                %>
                        </table>
                    </div>
                         <div class="main-content">
                        <h2>Habitaciones con Servicio</h2> 
                        <table> 
                            <tr>
                                <th>ID Habitación</th>
                                <th>Número de Habitación</th>
                            </tr>
                            <%
                                for (HabitacionSuite hbtServi: resultadoHabServi){
                                out.print("<tr><td>" + hbtServi.getIdHabitacion()+"</td>");
                                out.print("<td>" + hbtServi.getNumHabitacion()+"</td>");
                                
                                }
                                %>
                        </table>
                    </div>
    </body>
</html>
