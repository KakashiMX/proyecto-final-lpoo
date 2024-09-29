<%-- 
    Document   : agregarHuesped
    Created on : 28 sept 2024, 14:41:35
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="modelo.Huesped"%>
<%@page import="datos.ControladorBD"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="styles/styles.css"/>
        <title>Agregar Huesped</title>
    </head>
    <body>
        <div class="form-container">
            <form class="form" method="post">
                <!-- Título -->
                <h1 class="form-title">Registro de Huesped</h1>
                <div>
                    <%
                        if ("POST".equalsIgnoreCase(request.getMethod())
                                && request.getParameter("nombre") != null
                                && request.getParameter("apellido") != null
                                && request.getParameter("fechaNacimiento") != null
                                && request.getParameter("nacionalidad") != null) {

                            // Obtenemos los valores del formulario
                            String nombre = request.getParameter("nombre");
                            String apellido = request.getParameter("apellido");
                            DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                            LocalDate fechaNacimiento = LocalDate.parse(request.getParameter("fechaNacimiento"), formato);
                            String nacionalidad = request.getParameter("nacionalidad");
                            String telefono = request.getParameter("telefono");

                            ControladorBD controlador = new ControladorBD();
                            controlador.conectar();

                            Huesped huesped = new Huesped(nombre, apellido, fechaNacimiento, nacionalidad, telefono);

                            controlador.agregarHuesped(huesped);

                            controlador.desconectar();

                            response.sendRedirect(request.getContextPath() + "/vistaReserva/reservas.jsp");
                        }
                    %>
                </div>

                <div class="form-group">
                    Nombre <input 
                        type="text" 
                        class="form-input"
                        placeholder="Nombre"
                        name="nombre"
                        />
                </div>

                <div class="form-group">
                    Apellido <input 
                        type="text" 
                        class="form-input"
                        placeholder="Apellido"
                        name="apellido"
                        />
                </div>

                <div class="form-group">
                   Fecha de nacimiento <input 
                        type="text" 
                        class="form-input"
                        placeholder="dd/mm/yyyy"
                        name="fechaNacimiento"
                        />
                </div>

                <div class="form-group">
                    <%         
                        ArrayList<String> nacionalidades = Huesped.obtenerNacionalidadesFijas();
                    %>
                    Nacionalidad <select name="nacionalidad">
                        <%
                            for (String nac : nacionalidades) {
                                out.print("<option>" + nac + "</option>");
                            }
                        %>
                    </select>
                </div>
                    
                <div class="form-group">
                    Telefono <input 
                        type="text" 
                        class="form-input"
                        placeholder="Telefono"
                        name="telefono"
                        />
                </div>
                 <!-- Botón de envío -->
                <button
                    type="submit" 
                    class="form-submit"
                >Agregar</button>
            </form>
        </div>

    </body>
</html>
