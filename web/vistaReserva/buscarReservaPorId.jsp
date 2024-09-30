<%-- 
    Document   : buscarReservaPorId
    Created on : 29 sept 2024, 13:45:32
    Author     : kakashi
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page import="modelo.Reserva"%>
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

        int idABuscar = Integer.parseInt(request.getParameter("idReserva"));
        Reserva reserva = new Reserva();
        String resultado = reserva.buscarPorId(reservas, idABuscar);
    %>
        
        <!-- El modal -->
        <div id="modalConsultaResultado" class="modal">
            <!-- Contenido del modal -->
            <div class="modal-content" id="resultado">
                <h2>Resultado de la búsqueda</h2>
            </div>
        </div>
        <script>
                // Obtener el modal
            const modalConsultaResultado = document.getElementById("modalConsultaResultado");
            modalConsultaResultado.style.display = "block";
            const modal = document.getElementById("resultado");
            const p = document.createElement("p");
            p.innerHTML = '<%= resultado %>';
            modal.appendChild(p);
            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalConsultaResultado) {
                    modalConsultaResultado.style.display = "none";
                    window.history.back(); // Regresa a la página anterior
                }
            });
        </script>
    </body>
</html>
