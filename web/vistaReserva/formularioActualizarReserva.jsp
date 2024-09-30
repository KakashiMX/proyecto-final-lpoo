<%-- 
    Document   : formularioActualizarReserva
    Created on : 29 sept 2024, 11:36:20
    Author     : kakashi
--%>

<%@page import="modelo.Habitacion"%>
<%@page import="modelo.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Reserva"%>
<%@page import="datos.ControladorBD"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../styles/styles.css"/>
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
        <!-- El modal -->
        <div id="modalActualizarReserva" class="modal">
            <!-- Contenido del modal -->
            <div class="modal-content">
                <!-- El formulario va dentro del modal -->
                <h2>Editar información de reserva</h2>
                <form action="actualizarReserva.jsp" method="post">
                    ID de la reserva: 
                    <input type="number" name='idReserva'/>
                    <br><br>

                    Fecha de entrada: 
                    <input type="date" name="nuevaFechaEntrada" required />
                    <br><br>

                    Fecha de salida: 
                    <input type="date" name="nuevaFechaSalida" required />
                    <br><br>

                    Forma de pago: 
                    <select name="nuevaFormaPago">
                        <option value="Tarjeta">Tarjeta</option>
                        <option value="Efectivo">Efectivo</option>
                    </select>
                    <br><br>

                    Seleccione el tipo de habitación: 
                    <select name="nuevoTipoHabitacion" id="nuevoTipoHabitacion">
                        <option value="">Selecciona una opción</option>
                        <option value="Sencilla">Sencilla</option>
                        <option value="Doble">Doble</option>
                        <option value="Suite">Suite</option>
                    </select>
                    <br><br>

                    Habitaciones disponibles: 
                    <select name="nuevaHabitacionesDisponibles" id="nuevaHabitacionesDisponibles"></select>
                    <br><br>

                    <input type="submit" value="Actualizar" />
                </form>
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
                
                // Obtener el modal
            const modalActualizar = document.getElementById("modalActualizarReserva");

            // Obtener el botón que abre el modal
            const btnActualizar = document.getElementById("openActualizarReserva");

            // Cuando el usuario hace clic en el botón, abrir el modal
            btnActualizar.onclick = function() {
                modalActualizar.style.display = "block";
            };

            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalActualizar) {
                    modalActualizar.style.display = "none";
                }
            });
            </script>
    </body>
</html>
