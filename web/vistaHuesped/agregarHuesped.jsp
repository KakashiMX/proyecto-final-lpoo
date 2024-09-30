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
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Agregar Huesped</title>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <!-- Logo -->
                <img src="../assets/images/logo.jpeg" alt="Hotel Logo">
                <ul>
                    <li><a href="huespedes.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Huéspedes</a></li>  
                    <li><a href="actualizarHuesped.jsp" class="menu-link"><i class="fas fa-user-edit"></i> Modificar Huéspedes</a></li> 
                    <li><a href="eliminarHuesped.jsp" class="menu-link"><i class="fas fa-user-times"></i> Borrar Huéspedes</a></li>
                    <li><a href="consultarHuespedes.jsp" class="menu-link"><i class="fas fa-users"></i> Consultar Huéspedes</a></li>
                    <li><a href="moduloEstadisticoHuesped.jsp" class="menu-link"><i class="fas fa-chart-bar"></i> Módulo Estadístico</a></li>    
                </ul>
            </div>

            <div class="main-content">
                <div class="form-container">
                    <form class="form" method="post">
                        <!-- Título -->
                        <h1 class="form-title">Registro de Huésped</h1>
                        <div>
                            <%
                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    String nombre = request.getParameter("nombre");
                                    String apellido = request.getParameter("apellido");
                                    String fechaNac = request.getParameter("fechaNacimiento");
                                    String nacionalidad = request.getParameter("nacionalidad");
                                    String telefono = request.getParameter("telefono");

                                    if (nombre == null || nombre.trim().isEmpty()
                                            || apellido == null || apellido.trim().isEmpty()
                                            || fechaNac == null || fechaNac.trim().isEmpty()
                                            || nacionalidad == null || nacionalidad.trim().isEmpty()) {

                                        out.println("<p style='color:red;'>Todos los campos son obligatorios</p>");
                                    } else {
                                        DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                                        LocalDate fechaNacimiento = LocalDate.parse(fechaNac, formato);
                                        out.println(fechaNacimiento);

                                        // Insertar datos a la base de datos
                                        ControladorBD controlador = new ControladorBD();
                                        controlador.conectar();

                                        Huesped huesped = new Huesped(nombre, apellido, fechaNacimiento, nacionalidad, telefono);
                                        controlador.agregarHuesped(huesped);
                                        controlador.desconectar();

                                        response.sendRedirect("../vistaReserva/reservas.jsp");
                                    }
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
                            Nacionalidad <select name="nacionalidad" class="form-input">
                                <%
                                    for (String nac : nacionalidades) {
                                        out.print("<option>" + nac + "</option>");
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            Teléfono <input 
                                type="text" 
                                class="form-input"
                                placeholder="Teléfono"
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
            </div>
        </div>

    </body>
</html>
