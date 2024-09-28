<%-- 
    Document   : registro
    Created on : 26 sept 2024, 18:50:58
    Author     : kakashi
--%>

<%@page import="modelo.Usuario"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro</title>
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" href="./styles/styles.css"/>
    </head>
    <body>
        <div class="form-container">
            <!-- Formulario -->
            <form class="form" method="post">
                <!-- Icono del formulario -->
                <div class="form-icon">
                    <img src="./assets/images/logo.jpeg" alt="alt" class="form-icon-logo"/>
                </div>
                <!-- Título -->
                <h1 class="form-title">Registrar Cuenta</h1>
                <div>
                    <%
                        // Solo procesamos si el método es POST y los campos no son nulos
                        if ("POST".equalsIgnoreCase(request.getMethod()) && 
                            request.getParameter("usuario") != null && 
                            request.getParameter("contrasena") != null &&
                            request.getParameter("repetirContrasena") != null ) {
                            
                            
                            ControladorBD controlador = new ControladorBD();
                            controlador.conectar();
                            // Obtenemos los valores del formulario
                            String nombreUsuario = request.getParameter("usuario");
                            String contrasena = request.getParameter("contrasena");
                            String repetirContrasena = request.getParameter("repetirContrasena");

                            if(nombreUsuario.trim() == "" || contrasena.trim() == "" || repetirContrasena.trim() == "" || !contrasena.equals(repetirContrasena)) {
                                // Mostramos un mensaje de error
                                out.print("<p id='mensajeError' class='form-alert hidden' data-show-error='true'>Verifica que los datos sean correctos</p>");
                            }else{
                                boolean usuarioExistente = controlador.yaExisteUsuario(nombreUsuario);
                                if( usuarioExistente){
                                    out.print("<p id='mensajeError' class='form-alert hidden' data-show-error='true'>Intenta con otro nombre de usuario</p>");
                                }else{
                                    // agrega al usuario a la DB
                                    Usuario nuevoUsuario = new Usuario(nombreUsuario, contrasena, "cliente");
                                    // llama al método para crear un usuario nuevo
                                    controlador.agregarUsuario(nuevoUsuario);
                                    controlador.desconectar();
                                    response.sendRedirect("index.jsp");
                                }
                                
                            }
                            %>
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
                                </script>
                                <%
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
                        placeholder="Nombre Usuario"
                        name="usuario"
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

                <!-- Contenedor del icono y campo -->
                <div class="form-group">
                    <!-- Icono del campo -->
                    <i class="fas fa-unlock input-icon"></i>
                    <!-- campo de texto -->
                    <input 
                        type="password"
                        class="form-input"
                        placeholder="Confirmar Contraseña"
                        name="repetirContrasena"
                    />
                </div>

                <!-- Condiciones del servicio -->
                <small class="form-small">
                    Al registrarte estás aceptando los 
                    <a href="!#" class="small-link">Términos de servicio</a> & 
                    <a href="!#" class="small-link">Politica de privacidad</a>
                </small>

                <!-- Botón de envío -->
                <button
                    type="submit" 
                    class="form-submit"
                >Registrar</button>
            </form>
        </div>
    </body>
</html>
