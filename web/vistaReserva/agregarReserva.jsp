<%-- 
    Document   : agregarReserva
    Created on : 28 sept 2024, 19:08:47
    Author     : kakashi
--%>

<%@page import="modelo.Huesped"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Habitacion"%>
<%@page import="modelo.Reserva"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.Date"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Agregar Reserva</title>
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
                    <form method="post" class="form">
                        <h1 class="form-title">Agregar Reserva</h1>
                        <div>
                            <%
                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    request.setCharacterEncoding("UTF-8");
                                    String tipoHabitacion = request.getParameter("tipoHabitacion");
                                    String habitacionDisponible = request.getParameter("habitacionDisponible");

                                    if (tipoHabitacion.trim().isEmpty()
                                            || habitacionDisponible == null){
                                        out.println("<p style='color:red;'>Todos los campos son obligatorios</p>");
                                    } else {
                                    
                                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                            Date fechaEntrada = new Date(sdf.parse(request.getParameter("fechaEntrada")).getTime());
                                            Date fechaSalida = new Date(sdf.parse(request.getParameter("fechaSalida")).getTime());
                                            String formaPago = request.getParameter("formaPago");
                                            String informacionHabitacion [] = request.getParameter("habitacionDisponible").split(",");
                                            int idHabitacion = Integer.parseInt(informacionHabitacion[0]);
                                            float precio = Float.parseFloat(informacionHabitacion[1]);
                                            int idCliente = Integer.parseInt(request.getParameter("idCliente"));

                                            Reserva reserva = new Reserva(fechaEntrada, fechaSalida, precio, formaPago, idHabitacion, idCliente);
                                            controlador.agregarReserva(reserva);

                                            controlador.actualizarHabitacion(idHabitacion, false, precio);
                                            controlador.desconectar();
                                            out.println("<p style='color:green;'>La reserva se agregó correctamente</p>");
                                            response.sendRedirect("agregarReserva.jsp");
                                            
                                    }
                                }
                            %>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Fecha de entrada:</label>
                            <input type="date" name="fechaEntrada" class="form-input" required="true"/>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Fecha de salida:</label>
                            <input type="date" name="fechaSalida" class="form-input" required="true"/>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Forma de pago: </label>
                            <select name="formaPago" class="form-input" required="true">
                                <option value="Efectivo">Efectivo</option>
                                <option value="Tarjeta de crédito">Tarjeta de crédito</option>
                                <option value="Tarjeta de débito">Tarjeta de dédito</option>
                                <option value="Paypal">Paypal</option>
                                
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Tipo de habitación: </label>
                            <select name="tipoHabitacion" id="tipoHabitacion" class="form-input" required="true">
                                <option value="">Selecciona una opción</option>
                                <option value="Sencilla">Sencilla</option>
                                <option value="Doble">Doble</option>
                                <option value="Suite">Suite</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Habitaciones disponibles</label>
                            <select name="habitacionDisponible" id="habitacionesDisponibles" class="form-input" required="true"></select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Cliente que realiza la reservación</label>
                            <select name="idCliente" class="form-input" required="true">
                                <%
                                    for(Huesped huesped: huespedes){
                                        
                                        out.print("<option value='" + huesped.getId()+ "'> ID: " + huesped.getId()+ " - Nombre: " +
                                        huesped.getNombre()+ " " + huesped.getApellido() + "</option>");
                                    }
                                %>
                            </select>
                        </div>

                     <button
                            type="submit" 
                            class="form-submit"
                            >Agregar</button>
                </form>
                </div>
            </div>
        </div>
       <script>
                // Generar dinámicamente la lista de habitaciones desde el servidor JSP
                const habitaciones = [
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

                const tipoHabitacion = document.getElementById("tipoHabitacion");
                const selectHabitacionesDisponibles = document.getElementById("habitacionesDisponibles");
                
                // Función que actualiza el select de habitaciones disponibles
                tipoHabitacion.addEventListener('change', () => {
                    const tipoSeleccionado = tipoHabitacion.value;
                    selectHabitacionesDisponibles.innerHTML = ""; // Limpiar las opciones anteriores

                    if (tipoSeleccionado === "") {
                        // Si no se selecciona un tipo, mostrar opción vacía
                        selectHabitacionesDisponibles.innerHTML = "<option value=''>Seleccione una habitación</option>";
                        
                    }else{
                        // Filtrar habitaciones por tipo seleccionado y disponibilidad
                        const habitacionesFiltradas = habitaciones.filter(habitacion => habitacion.tipo === tipoSeleccionado && habitacion.disponibilidad);
                        // Agregar opciones filtradas al select
                        habitacionesFiltradas.forEach(habitacion => {
                            const optionSelect = document.createElement("option");
                            optionSelect.value = habitacion.id + ", " + habitacion.precio;
                            optionSelect.text = "# Habitación: " + habitacion.numero + "- Precio: " + habitacion.precio;
                            selectHabitacionesDisponibles.appendChild(optionSelect);
                        });
                    }
                    
                });
        </script>
    </body>
</html>
