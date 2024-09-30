<%-- 
    Document   : promedioEstadia
    Created on : 30 sept 2024, 08:14:08
    Author     : kakashi
--%>

<%@page import="modelo.Reserva"%>
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
            String resultado = reserva.promedioTiempoEstadia(reservas);

        %>
         <!-- El modal -->
        <div id="modalPromedioEstadia" class="modal">
            <!-- Contenido del modal -->
            <div class="modal-content">
                <h2>Promedio de estadia de los clientes</h2>
                    <%
                        out.print("<p>" + resultado + "</p>");
                    %>
            </div>
        </div>
         
        <script>
                // Obtener el modal
            const modalPromedioEstadia = document.getElementById("modalPromedioEstadia");

            // Obtener el botón que abre el modal
            const btnPromedioDeEstadia = document.getElementById("openPromedioDeEstadia");

            // Cuando el usuario hace clic en el botón, abrir el modal
            btnPromedioDeEstadia.onclick = function() {
                modalPromedioEstadia.style.display = "block";
            };

            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalPromedioEstadia) {
                    modalPromedioEstadia.style.display = "none";
                }
            });
            
        </script>
    </body>
</html>
