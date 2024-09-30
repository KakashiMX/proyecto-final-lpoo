<%-- 
    Document   : ordenarReservas
    Created on : 29 sept 2024, 14:53:03
    Author     : kakashi
--%>

<%@page import="modelo.Reserva"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Habitacion"%>
<%@page import="java.util.ArrayList"%>
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
            controlador.conectar();
            reservas = controlador.consultarReservas();
            controlador.desconectar();
            Reserva reserva = new Reserva();
            ArrayList<Reserva> reservasOrdenadas =reserva.ordenarPorFechaEntrada(reservas);

        %>
         <!-- El modal -->
        <div id="modalOrdenarReservas" class="modal">
            <!-- Contenido del modal -->
            <div class="modal-content">
                <h2>Reservas ordenadas por fecha de entrada</h2>
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
                for (Reserva reservaOrdenada: reservasOrdenadas) {
                    out.print("<tr><td>" + reservaOrdenada.getIdReserva() + "</td>");
                    out.print("<td>" + reservaOrdenada.getFechaEntrada() + "</td>");
                    out.print("<td>" + reservaOrdenada.getFechaSalida() + "</td>");
                    out.print("<td>" + reservaOrdenada.getFormaPago()+ "</td>");
                    out.print("<td>" + reservaOrdenada.getIdHabitacion() + "</td>");
                    out.print("<td>" + reservaOrdenada.getValor() + "</td>");
                    out.print("<td>" + reservaOrdenada.getIdCliente()+ "</td></tr>");
                }
            %>     
            </table>
            </div>
        </div>
         
        <script>
                // Obtener el modal
            const modalOrdenarReservas = document.getElementById("modalOrdenarReservas");

            // Obtener el botón que abre el modal
            const btnOrdenarReserva = document.getElementById("openOrdenarReservas");

            // Cuando el usuario hace clic en el botón, abrir el modal
            btnOrdenarReserva.onclick = function() {
                modalOrdenarReservas.style.display = "block";
            };

            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalOrdenarReservas) {
                    modalOrdenarReservas.style.display = "none";
                }
            });
            
        </script>
    </body>
</html>
