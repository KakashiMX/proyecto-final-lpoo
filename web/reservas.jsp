<%-- 
    Document   : reservas
    Created on : 26 sept 2024, 16:48:51
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
        <title>Reservas</title>
    </head>
    <body>
        <h1>Reservas</h1>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Reserva> reservas = new ArrayList<>();
            ArrayList<Habitacion> habitaciones = new ArrayList<>();
            ArrayList<Usuario> clientes = new ArrayList<>();
            controlador.conectar();
            
            habitaciones = controlador.consultarHabitaciones();
            reservas = controlador.consultarReservas();
            clientes = controlador.consultarUsuarios();
            controlador.desconectar();

        %>
        
        <table border=1, width="800">
            <tr>
                <th>Id Reserva</th>
                <th>Fecha entrada</th>
                <th>Fecha Salida</th>
                <th>Forma de pago</th>
                <th>Id Habitacion</th>
                <th>costo por noche</th>
                <th>Id cliente</th>
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

        <h2>Agregar Reserva</h2>
        <form action="agregarReserva.jsp" method="post">
            Fecha de entrada <input type="date" name="fechaEntrada" />
            Fecha de salida <input type="date" name="fechaSalida" />
            Forma de pago <select name="formaPago">
                <option value="Tarjeta">Tarjeta</option>
                <option value="Efectivo">Efectivo</option>
            </select>
            Seleccione el tipo de habitacion <select name="tipoHabitacion" id="tipoHabitacion">
                <option value="">Selecciona una opción</option>
                <option value="Sencilla">Sencilla</option>
                <option value="Doble">Doble</option>
                <option value="Suite">Suite</option>
            </select>
            
            Habitaciones disponibles <select name="habitacionDisponible" id="habitacionesDisponibles"></select>
            
            Elige el cliente que realiza la reservación <select name="idCliente">
                <%
                    for(Usuario cliente: clientes){
                        if( cliente.getRol().equalsIgnoreCase("cliente") ){
                            out.print("<option value='" + cliente.getIdUsuario() + "'> ID: " + cliente.getIdUsuario() + " - Cliente: " +
                            cliente.getUsuario() + "</option>");
                        }
                    }
                %>
            </select>
            <br><br>
            <input type="submit" value="Agregar reserva" />
        </form>

        <h2>Actualizar Reserva</h2>
        <form action="actualizarReserva.jsp" method="post">
            <select name="idReserva">
                <%
                    for (Reserva reserva : reservas) {
                        out.print("<option>" + reserva.getIdReserva() + "</option>");
                    }
                %>
            </select> <br><br>
            Fecha de entrada <input type="date" name="nuevaFechaEntrada" />
            Fecha de salida <input type="date" name="nuevaFechaSalida" />
            Forma de pago <select name="nuevaFormaPago">
                <option value="Tarjeta">Tarjeta</option>
                <option value="Efectivo">Efectivo</option>
            </select>
            Seleccione el tipo de habitacion <select name="nuevoTipoHabitacion" id="nuevoTipoHabitacion">
                <option value="">Selecciona una opción</option>
                <option value="Sencilla">Sencilla</option>
                <option value="Doble">Doble</option>
                <option value="Suite">Suite</option>
            </select>
            
            Habitaciones disponibles <select name="nuevahabitacionesDisponibles" id="nuevaHabitacionesDisponibles"></select>
            <br><br>
        <input type="submit" value="Actualizar reserva" />
        </form>
            
        
        
         <h2>Eliminar Reserva</h2>

        <form action="eliminarReserva.jsp" method="post">
            <select name="idReserva">
                <%
                    for (Reserva reserva : reservas) {
                        out.print("<option>" + reserva.getIdReserva()+ "</option>");
                    }
                %>
            </select>
            <br><br>
            <input type="submit" value="Eliminar reserva">  
        </form>
            
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
                        const nuevasHabitacionesFiltradas = habitaciones.filter(habitacion => habitacion.tipo === nuevoTipoSeleccionado && habitacion.disponibilidad);
                        // Agregar opciones filtradas al select
                        nuevasHabitacionesFiltradas.forEach(habitacion => {
                            const optionSelect = document.createElement("option");
                            optionSelect.value = habitacion.id + ", " + habitacion.precio;
                            optionSelect.text = "# Habitación: " + habitacion.numero + "- Precio: " + habitacion.precio;
                            nuevoHabitacionesDisponibles.appendChild(optionSelect);
                        });
                    }
                    
                });
            </script>
    </body>
</html>
