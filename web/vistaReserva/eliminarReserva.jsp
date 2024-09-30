<%-- 
    Document   : eliminarReserva
    Created on : 28 sept 2024, 20:04:37
    Author     : kakashi
--%>

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
        
            
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Reserva> reservas = new ArrayList<>();
            ArrayList<Habitacion> habitaciones = new ArrayList<>();
            ArrayList<Usuario> clientes = new ArrayList<>();
            controlador.conectar();
            
            habitaciones = controlador.consultarHabitaciones();
            reservas = controlador.consultarReservas();
            clientes = controlador.consultarUsuarios();

        %>
        
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
                    <form method="post" class="form">
                        <h1 class="form-title">Eliminar Reserva</h1>
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
                            <input type="number" name="idReserva" class="form-input"/> 
                        </div>
                        
                         <button
                            type="submit" 
                            class="form-submit"
                            >Eliminar</button>
                    </form>
                </form>
                        
                        <div>
                    <table border="1" width="500">
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
                    <br><br>
                </div>
                </div>
            </div>
        </div>
    </body>
</html>
