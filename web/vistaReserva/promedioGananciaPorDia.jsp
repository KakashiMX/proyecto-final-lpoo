<%-- 
    Document   : promedioGananciaPorDia
    Created on : 30 sept 2024, 08:21:38
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
    </head>
    <body>
        <body>
         <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Reserva> reservas = new ArrayList<>();
            controlador.conectar();
            reservas = controlador.consultarReservas();
            controlador.desconectar();
            Reserva reserva = new Reserva();
            String resultado = reserva.promedioGananciaPorDia(reservas);

        %>
         <!-- El modal -->
        <div id="modalGananciaPorDia" class="modal">
            <!-- Contenido del modal -->
            <div class="modal-content">
                <h2>Ganacias diarias</h2>
                    <%
                        out.print("<p>" + resultado + "</p>");
                    %>
            </div>
        </div>
         
        <script>
                // Obtener el modal
            const modalGananciaPorDia = document.getElementById("modalGananciaPorDia");

            // Obtener el botón que abre el modal
            const btnPromedioGananciaPorDia = document.getElementById("openPromedioGananciaPorDia");

            // Cuando el usuario hace clic en el botón, abrir el modal
            btnPromedioGananciaPorDia.onclick = function() {
                modalGananciaPorDia.style.display = "block";
            };

            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalGananciaPorDia) {
                    modalGananciaPorDia.style.display = "none";
                }
            });
            
        </script>
    </body>
    </body>
</html>
