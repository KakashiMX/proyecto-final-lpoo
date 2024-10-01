<%-- 
    Document   : index
    Created on : 26 sept 2024, 14:28:07
    Author     : kakashi
--%>

<%@page import="modelo.Administrador"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Iniciar Sesión</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="styles/styles.css"/>
    </head>
    <body>
        <div class="form-container">
            <!-- Formulario -->
            <form class="form" method="post" id="formInicioSesion">
                <!-- Icono del formulario -->
                <div class="form-icon">
                    <img src="./assets/images/logo.jpeg" alt="alt" class="form-icon-logo"/>
                </div>
                <!-- Título -->
                <h1 class="form-title">Iniciar Sesión</h1>

                <div>
                    <%
                        // Solo procesamos si el método es POST y los campos no son nulos
                        if ("POST".equalsIgnoreCase(request.getMethod())
                                && request.getParameter("administrador") != null
                                && request.getParameter("contrasena") != null) {

                            // Obtenemos los valores del formulario
                            String nombreAdministrador = request.getParameter("administrador");
                            String contrasena = request.getParameter("contrasena");

                            // Validamos usuario y contraseña
                            ControladorBD controlador = new ControladorBD();
                            controlador.conectar();
                            boolean existe = controlador.verificarContrasena(nombreAdministrador, contrasena);

                            if (existe) {
                                // si el usuario existe, hay que traer su información ya que depende del rol del usuario
                                // para ver a donde será redireccionado
                                Administrador administrador = new Administrador();
                                administrador = controlador.consultarAdministrador(nombreAdministrador, contrasena);
                                controlador.desconectar();

                                response.sendRedirect("panelAdministrador.jsp");

                            } else {
                                // Mostramos un mensaje de error
                                out.print("<p id='mensajeError' class='form-alert hidden' data-show-error='true'>El nombre de administrador o la contraseña son incorrectos</p>");
                            }
                        }
                    %>
                </div>
                <!-- Contenedor del icono y campo -->
                <div class="form-group">
                    <!-- Icono del campo -->
                    <i class="fas fa-user-tag input-icon"></i>
                    <!-- campo de texto -->
                    <input 
                        type="text" 
                        class="form-input"
                        placeholder="Nombre Administrador"
                        name="administrador"
                        id="nombreAdministrador"
                        />
                </div>

                <!-- Contenedor del icono y campo -->
                <div class="form-group">
                    <!-- Icono del campo -->
                    <i class="fas fa-lock input-icon"></i>
                    <!-- campo de texto -->
                    <input 
                        type="password"
                        class="form-input"
                        placeholder="Contraseña"
                        name="contrasena"
                        />
                </div>

                <!-- Condiciones del servicio -->
                <small class="form-small">
                    <p>¿Aún no estas registrado? <a href="registro.jsp" class="small-link"> Crea una cuenta</a></p>
                </small>

                <!-- Botón de envío -->
                <button
                    type="submit" 
                    class="form-submit"
                    >Iniciar Sesión</button>
            </form>
        </div>

        <script>
            // este script sirve para ocultar la alerta despues de 3 segundos
            // Función para mostrar u ocultar el mensaje de error
            function mostrarError(elemento) {
                if (elemento.dataset.showError === 'true') {
                    elemento.classList.remove('hidden');
                    setTimeout(() => {
                        elemento.classList.add('hidden');
                    }, 3000); // Ocultar después de 3 segundos
                }
            }

            // Llamar a la función si el atributo data-show-error está presente
            const mensajeError = document.getElementById('mensajeError');
            if (mensajeError) {
                mostrarError(mensajeError);
            }
            document.getElementById('formInicioSesion').addEventListener('submit', () => {
                localStorage.setItem("Usuario", document.getElementById('nombreAdministrador').value);
            });
        </script>
    </body>
</html>
