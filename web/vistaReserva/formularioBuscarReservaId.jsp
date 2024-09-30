<%-- 
    Document   : consultarReservaPorId
    Created on : 29 sept 2024, 13:37:07
    Author     : kakashi
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Reserva"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
         <!-- El modal -->
        <div id="modalConsultaReserva" class="modal">
            <!-- Contenido del modal -->
            <div class="modal-content">
                <!-- El formulario va dentro del modal -->
                <form action="buscarReservaPorId.jsp" method="post" id="formBuscarPorId">
                    <h2>Consultar reserva por ID</h2>
                     <label>ID:</label><input type="number" name="idReserva" id="idReserva"/>
                    <br><br>
                    <input type="submit" value="Buscar" id="buscar">  
                </form>
            </div>
        </div>
         
        <script>
                // Obtener el modal
            const modalConsultaReserva = document.getElementById("modalConsultaReserva");

            // Obtener el botón que abre el modal
            const btnConsultaReserva = document.getElementById("openConsultarReserva");

            // Cuando el usuario hace clic en el botón, abrir el modal
            btnConsultaReserva.onclick = function() {
                document.getElementById("idReserva").value = "";
                modalConsultaReserva.style.display = "block";
            };

            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalConsultaReserva) {
                    modalConsultaReserva.style.display = "none";
                }
            });
            
        </script>
    </body>
</html>
