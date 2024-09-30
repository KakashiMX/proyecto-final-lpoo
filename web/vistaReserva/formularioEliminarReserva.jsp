<%-- 
    Document   : formularioEliminarReserva
    Created on : 29 sept 2024, 11:40:46
    Author     : kakashi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../styles/styles.css"/>
    </head>
    <body>
         <!-- El modal -->
        <div id="modalEliminarReserva" class="modal">
            <!-- Contenido del modal -->
            <div class="modal-content">
                <!-- El formulario va dentro del modal -->
                 <form action="eliminarReserva.jsp" method="post">
                     <h2>Eliminar Reserva</h2>
                     <label>ID: </label><input type="number" name="idReserva"/>
            <br><br>
            <input type="submit" value="Eliminar">  
        </form>
            </div>
        </div>
            
        <script>
                // Obtener el modal
            const modalEliminarReserva = document.getElementById("modalEliminarReserva");

            // Obtener el botón que abre el modal
            const btnEliminarReserva = document.getElementById("openBorrarReserva");

            // Cuando el usuario hace clic en el botón, abrir el modal
            btnEliminarReserva.onclick = function() {
                modalEliminarReserva.style.display = "block";
            };

            // Cuando el usuario hace clic fuera del contenido del modal, cerrarlo
            window.addEventListener('click', e => {
                if (e.target === modalEliminarReserva) {
                    modalEliminarReserva.style.display = "none";
                }
            });
        </script>
    </body>
</html>
