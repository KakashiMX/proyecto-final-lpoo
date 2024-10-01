<%-- 
    Document   : eliminarReserva
    Created on : 28 sept 2024, 20:04:37
    Author     : kakashi
--%>

<%@page import="modelo.Huesped"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Habitacion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Reserva"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Eliminar Reserva</title>
    </head>
    <body>
        <script src="../javascript/script.js"></script>
            
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
                <h1 class="form-title">Eliminar Reserva</h1>
                <div class="form-container">
                    <form method="post" class="form">
                        <div>
                            <%
                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    int id = Integer.parseInt(request.getParameter("idReserva"));

                                    if ( id < 0 ){
                                        out.println("<p style='color:red;'>Todos los campos son obligatorios</p>");
                                    } else {
                                    
                                        int idReserva= Integer.parseInt(request.getParameter("idReserva"));
                                        // Si se elimina una reserva, se tiene que actualizar el estado de la habitación a disponible
                                        for(Reserva reserva: reservas){
                                            if( idReserva == reserva.getIdReserva()){
                                                controlador.actualizarHabitacion(reserva.getIdHabitacion(), true, reserva.getValor());
                                            }
                                        }
                                        controlador.eliminarReserva(idReserva);
                                        controlador.desconectar();

                                        response.sendRedirect("eliminarReserva.jsp");
                                            
                                    }
                                }
                            %>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">ID: </label>
                            <input type="number" name="idReserva" class="form-input" placeholder="Ingrese el valor a eliminar (ej: 1, 8)"/> 
                        </div>
                        
                         <button
                            type="submit" 
                            class="form-submit"
                            >Eliminar</button>
                    </form>
                </form>
                        
                        <div>
                    <table class="result-table">
                        <tr>
                            <th>Id Reserva</th>
                            <th>Nombre Huésped</th>
                            <th>Fecha de entrada</th>
                            <th>Fecha de salida</th>
                            <th>Forma de pago</th>
                            <th>Número Habitacion</th>
                            <th>Tipo</th>
                            <th>Costo por noche</th>
                        </tr>
                        <%
                            for (Reserva reserva : reservas) {
                                out.print("<tr><td>" + reserva.getIdReserva() + "</td>");
                                for( Huesped huesped: huespedes){
                                    if( huesped.getId() == reserva.getIdCliente() ){
                                        out.print("<td>" + huesped.getNombre()+ " " + huesped.getApellido() + "</td>");
                                    }
                                }
                                out.print("<td>" + reserva.getFechaEntrada() + "</td>");
                                out.print("<td>" + reserva.getFechaSalida() + "</td>");
                                out.print("<td>" + reserva.getFormaPago()+ "</td>");
                                for( Habitacion habitacion: habitaciones){
                                    if( habitacion.getIdHabitacion() == reserva.getIdHabitacion()){
                                        out.print("<td>" + habitacion.getNumHabitacion() + "</td>");
                                        out.print("<td>" + habitacion.getTipoHabitacion() + "</td>");
                                        out.print("<td>" + habitacion.getPrecio() + "</td></tr>");
                                    }
                                }
                            }
                            controlador.desconectar();
                        %>            
                    </table> 
                    <br><br>
                </div>
                </div>
            </div>
        </div>
    </body>
</html>
