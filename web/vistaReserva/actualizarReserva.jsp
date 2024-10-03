<%-- 
    Document   : actualizarReserva
    Created on : 29 sept 2024, 08:37:40
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="modelo.HabitacionSuite"%>
<%@page import="modelo.HabitacionFamiliar"%>
<%@page import="modelo.HabitacionFamiliar"%>
<%@page import="modelo.Huesped"%>
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
                <h1 class="form-title">Actualizar Reserva</h1>
                    
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
                                       int idHabitacion = Integer.parseInt(informacionHabitacion[0]);
                                       float precio = Float.parseFloat(informacionHabitacion[1]);

                                       for( Reserva reserva: reservas){
                                           if( reserva.getIdReserva() == idReserva){
                                               controlador.actualizarHabitacionReserva(reserva.getIdHabitacion(), true);
                                           }
                                       }
                                       controlador.actualizarReserva(idReserva, fechaEntrada, fechaSalida, precio, formaPago, idHabitacion);
                                       controlador.actualizarHabitacionReserva(idHabitacion, false);
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
                                <option value="Tarjeta de débito">Tarjeta de dédito</option>
                                <option value="Paypal">Paypal</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Tipo de habitación: </label>
                            <select name="nuevoTipoHabitacion" id="nuevoTipoHabitacion" class="form-input" required="true">
                                <option value="">Selecciona una opción</option>
                                <option value="Sencilla">Sencilla</option>
                                <option value="Familiar">Familiar</option>
                                <option value="Suite">Suite</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Habitaciones disponibles</label>
                            <select name="nuevaHabitacionesDisponibles" id="nuevaHabitacionesDisponibles" class="form-input" required="true"></select>
                        </div>
                        
                        <div class="form-group">
                            <label class="form-label">Servicios de la habitación:</label>
                            <textarea id="serviciosHabitacion" class="form-input" rows="5" readonly></textarea>
                        </div>

                     <button
                            type="submit" 
                            class="form-submit"
                            >Actualizar</button>
                </form>
                </div>
                        
                <div>
                    <table border="1" width="500">
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
                                        out.print("<td>" + habitacion.getPrecioTotalTipoHabitacion() + "</td></tr>");
                                    }
                                }
                            }
                        %>            
                    </table> 
                    <br><br>
                </div>
            </div>
        </div>
        <script>
        // Generar dinámicamente la lista de habitaciones desde el servidor JSP
        const habitaciones = [
            <% 
                for (Habitacion habitacion : habitaciones) {
                    String servicios = "";
                    if (habitacion instanceof HabitacionFamiliar) {
                        HabitacionFamiliar familiar = (HabitacionFamiliar) habitacion;
                        servicios = "Capacidad máxima: " + familiar.getCapacidadMaxima() + 
                                    ", Cocina: " + (familiar.isTieneCocina() ? "Sí" : "No") + 
                                    ", Sala: " + (familiar.isTieneSala() ? "Sí" : "No");
                    } else if (habitacion instanceof HabitacionSuite) {
                        HabitacionSuite suite = (HabitacionSuite) habitacion;
                        servicios = "Servicio a la habitación: " + (suite.isServicioHabitacion() ? "Sí" : "No") + 
                                    ", Vista: " + suite.getVista();
                    } else {
                        servicios = "No aplica";
                    }

                    out.println("{ id: " + habitacion.getIdHabitacion() + 
                                 ", tipo: '" + habitacion.getTipoHabitacion() + 
                                 "', numero: '" + habitacion.getNumHabitacion() + 
                                 "', precio: " + habitacion.getPrecioTotalTipoHabitacion()+ 
                                 ", disponibilidad: " + habitacion.isDisponibilidad() + 
                                 ", servicios: '" + servicios + "' },");
                }
            %>
        ];

        const tipoHabitacion = document.getElementById("nuevoTipoHabitacion");
        const selectHabitacionesDisponibles = document.getElementById("nuevaHabitacionesDisponibles");

        // Función que actualiza el select de habitaciones disponibles
        tipoHabitacion.addEventListener('change', () => {
            const tipoSeleccionado = tipoHabitacion.value;
            selectHabitacionesDisponibles.innerHTML = ""; // Limpiar las opciones anteriores
            document.getElementById("serviciosHabitacion").value = ""; // Limpiar el textarea de servicios

            if (tipoSeleccionado === "") {
                selectHabitacionesDisponibles.innerHTML = "<option value=''>Seleccione una habitación</option>";
            } else {
                // Filtrar habitaciones por tipo seleccionado y disponibilidad
                const habitacionesFiltradas = habitaciones.filter(habitacion => habitacion.tipo === tipoSeleccionado && habitacion.disponibilidad);
                habitacionesFiltradas.forEach(habitacion => {
                    const optionSelect = document.createElement("option");
                    optionSelect.value = habitacion.id + ", " + habitacion.precio;
                    optionSelect.text = "# Habitación: " + habitacion.numero + "- Precio: " + habitacion.precio;
                    selectHabitacionesDisponibles.appendChild(optionSelect);
                });
            }
        });

        // Función que actualiza el textarea de servicios cuando se selecciona una habitación
        selectHabitacionesDisponibles.addEventListener('change', () => {
            const habitacionSeleccionada = parseInt(selectHabitacionesDisponibles.value.split(",")[0]); // Convertir a número
            const habitacion = habitaciones.find(h => h.id === habitacionSeleccionada);

            if (habitacion) {
                document.getElementById("serviciosHabitacion").value = habitacion.servicios;
            }
        });
    </script>       
    </body>
</html>
