<%-- 
    Document   : actualizarReserva
    Created on : 29 sept 2024, 08:37:40
    Author     : kakashi
--%>

<%@page import="modelo.Habitacion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Reserva"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Actualizar Reserva</title>
    </head>
    <body>
       <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Reserva> reservas = new ArrayList<>();
            ArrayList<Habitacion> habitaciones = new ArrayList<>();
            controlador.conectar();
            
            habitaciones = controlador.consultarHabitaciones();
            reservas = controlador.consultarReservas();

        %>
        <div class="container">
            <div class="sidebar">
                    <%@ include file="sideBarReserva.jsp" %>
            </div>

            <div class="main-content">
                <h1 class="form-title">Actualizar Reserva</h1>
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
                    
                <div class="form-container">
                    <form method="post" class="form">
                        <div>
                            <%
                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    request.setCharacterEncoding("UTF-8");
                                    int id = Integer.parseInt(request.getParameter("idReserva"));
                                    String tipoHabitacion = request.getParameter("nuevoTipoHabitacion");
                                    String habitacionDisponible = request.getParameter("nuevaHabitacionesDisponibles");

                                    if ( id < 0 || tipoHabitacion.trim().isEmpty()
                                            || habitacionDisponible == null){
                                        out.println("<p style='color:red;'>Todos los campos son obligatorios</p>");
                                    } else {
                                    
                                       int idReserva = Integer.parseInt(request.getParameter("idReserva"));
                                       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                       Date fechaEntrada = new Date(sdf.parse(request.getParameter("nuevaFechaEntrada")).getTime());
                                       Date fechaSalida = new Date(sdf.parse(request.getParameter("nuevaFechaSalida")).getTime());
                                       String formaPago = request.getParameter("nuevaFormaPago");
                                       String informacionHabitacion[] = request.getParameter("nuevaHabitacionesDisponibles").split(",");
                                       System.out.println(informacionHabitacion);
                                       int idHabitacion = Integer.parseInt(informacionHabitacion[0]);
                                       float precio = Float.parseFloat(informacionHabitacion[1]);

                                       for( Reserva reserva: reservas){
                                           if( reserva.getIdReserva() == idReserva){
                                               controlador.actualizarHabitacion(reserva.getIdHabitacion(), true, reserva.getValor());
                                           }
                                       }
                                       controlador.actualizarReserva(idReserva, fechaEntrada, fechaSalida, precio, formaPago, idHabitacion);
                                       controlador.actualizarHabitacion(idHabitacion, false, precio);
                                       controlador.desconectar();
                                       response.sendRedirect("actualizarReserva.jsp");
                                            
                                    }
                                }
                            %>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">ID: </label>
                            <input type="number" name='idReserva' class="form-input" required="true" placeholder="Ingrese el valor a actualizar (ej: 1, 8)"/>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Fecha de entrada:</label>
                            <input type="date" name="nuevaFechaEntrada" class="form-input" required="true"/>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Fecha de salida:</label>
                            <input type="date" name="nuevaFechaSalida" class="form-input" required="true"/>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Forma de pago: </label>
                            <select name="nuevaFormaPago" class="form-input" required="true">
                                <option value="Efectivo">Efectivo</option>
                                <option value="Tarjeta de crédito">Tarjeta de crédito</option>
                                <option value="Tarjeta de débito">Tarjeta de crédito</option>
                                <option value="Paypal">Paypal</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Tipo de habitación: </label>
                            <select name="nuevoTipoHabitacion" id="nuevoTipoHabitacion" class="form-input" required="true">
                                <option value="">Selecciona una opción</option>
                                <option value="Sencilla">Sencilla</option>
                                <option value="Doble">Doble</option>
                                <option value="Suite">Suite</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Habitaciones disponibles</label>
                            <select name="nuevaHabitacionesDisponibles" id="nuevaHabitacionesDisponibles" class="form-input" required="true"></select>
                        </div>

                     <button
                            type="submit" 
                            class="form-submit"
                            >Actualizar</button>
                </form>
                </div>
            </div>
        </div>
        <script>
                // Generar dinámicamente la lista de habitaciones desde el servidor JSP
                const otrasHabitaciones = [
                    <% 
                        for (Habitacion habitacion : habitaciones) {
                            // Crear un objeto para cada habitación en formato que JavaScript pueda leer
                            out.println("{ id: " + habitacion.getIdHabitacion() + 
                                         ", tipo: '" + habitacion.getTipoHabitacion() + 
                                         "', numero: '" + habitacion.getNumHabitacion() + 
                                         "', precio: " + habitacion.getPrecio() + 
                                         ", disponibilidad: " + habitacion.isDisponibilidad() + " },");
                        }
                    %>
                ];
                
                const nuevoTipoHabitacion = document.getElementById("nuevoTipoHabitacion");
                const nuevoHabitacionesDisponibles = document.getElementById("nuevaHabitacionesDisponibles");
                
                // Función que actualiza el select de habitaciones disponibles
                nuevoTipoHabitacion.addEventListener('change', () => {
                    const nuevoTipoSeleccionado = nuevoTipoHabitacion.value;
                    nuevoHabitacionesDisponibles.innerHTML = ""; // Limpiar las opciones anteriores

                    if (nuevoTipoSeleccionado === "") {
                        // Si no se selecciona un tipo, mostrar opción vacía
                        nuevoHabitacionesDisponibles.innerHTML = "<option value=''>Seleccione una habitación</option>";
                        
                    }else{
                        // Filtrar habitaciones por tipo seleccionado y disponibilidad
                        const nuevasHabitacionesFiltradas = otrasHabitaciones.filter(habitacion => habitacion.tipo === nuevoTipoSeleccionado && habitacion.disponibilidad);
                        // Agregar opciones filtradas al select
                        nuevasHabitacionesFiltradas.forEach(habitacion => {
                            const optionSelect = document.createElement("option");
                            optionSelect.value = habitacion.id + "," + habitacion.precio;
                            optionSelect.text = "# Habitación: " + habitacion.numero + "- Precio: " + habitacion.precio;
                            nuevoHabitacionesDisponibles.appendChild(optionSelect);
                        });
                    }
                    
                });
                
            </script>          
    </body>
</html>
