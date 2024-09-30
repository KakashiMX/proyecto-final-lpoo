<%-- 
    Document   : formularioAgregarReserva
    Created on : 29 sept 2024, 11:33:18
    Author     : kakashi
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Habitacion"%>
<%@page import="modelo.Reserva"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            controlador.desconectar();

        %>
        <div id="modalAgregarReserva" class="modal">
            <div class="modal-content">
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
                
                 
                // Obtener el modal
            const modalAgregarReserva = document.getElementById("modalAgregarReserva");

            // Obtener el botón que abre el modal
            const btnAgregarReserva = document.getElementById("openAgregarReserva");

            // Cuando el usuario hace clic en el botón, abrir el modal
            btnAgregarReserva.onclick = function() {
                modalAgregarReserva.style.display = "block";
            };

            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalAgregarReserva) {
                    modalAgregarReserva.style.display = "none";
                }
            });
                
            </script>
    </body>
</html>
