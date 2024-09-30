<%-- 
    Document   : formaPagoPreferida
    Created on : 30 sept 2024, 07:48:25
    Author     : kakashi
--%>

<%@page import="modelo.Reserva"%>
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
            String resultado = reserva.promedioFormaDePago(reservas);
        %>
         <!-- El modal -->
        <div id="modalFormaPago" class="modal">
            <!-- Contenido del modal -->
            <div class="modal-content">
                <h2>Promedio de la forma de pago de los clientes </h2>
                <%
                    out.print("<p>" + resultado + "</p>");
                %>
                
            </div>
        </div>
         
        <script>
                  // Obtener el modal
            const modalFormaPago = document.getElementById("modalFormaPago");
            // Obtener el botón que abre el modal
            const btnFormaPago = document.getElementById("openFormaDePago");

            // Cuando el usuario hace clic en el botón, abrir el modal
            btnFormaPago.onclick = function() {
                modalFormaPago.style.display = "block";
            };

            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalFormaPago) {
                    modalFormaPago.style.display = "none";
                }
            });
        </script>
    </body>
</html>
