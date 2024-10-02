<%-- 
    Document   : agregarHuesped
    Created on : 28 sept 2024, 14:41:35
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
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
        <script src="../javascript/script.js"></script>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarHuesped.jsp" %>
            </div>

            <div class="main-content">
                <div class="form-container">
                    <form class="form" method="post" accept-charset="UTF-8">
                        <!-- Título -->
                        <h1 class="form-title">Registro de Huésped</h1>
                        <div>
                            <%
                                request.setCharacterEncoding("UTF-8");
                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    String nombre = request.getParameter("nombre");
                                    String apellido = request.getParameter("apellido");
                                    String fechaNac = request.getParameter("fechaNacimiento");
                                    String nacionalidad = request.getParameter("nacionalidad");
                                    String telefono = request.getParameter("telefono");

                                    if (nombre == null || nombre.trim().isEmpty()
                                            || apellido == null || apellido.trim().isEmpty()
                                            || fechaNac == null || fechaNac.trim().isEmpty()
                                            || nacionalidad == null || nacionalidad.trim().isEmpty()
                                            || telefono == null || telefono.trim().isEmpty()) {

                                        out.println("<p style='color:red;'>Todos los campos son obligatorios</p>");
                                    } else {

                                        LocalDate fechaNacimiento = LocalDate.parse(fechaNac);

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
                            Nombre: <input 
                                type="text" 
                                class="form-input"
                                placeholder="Nombre"
                                name="nombre"
                                required="true"
                                />
                        </div>

                        <div class="form-group">
                            Apellido: <input 
                                type="text" 
                                class="form-input"
                                placeholder="Apellido"
                                name="apellido"
                                required="true"
                                />
                        </div>
                        <div class="form-group">
                            <label class="form-label">Fecha de nacimiento</label>
                            <input type="date" name="fechaNacimiento" class="form-input" required="true"/>
                        </div>

                        <div class="form-group">
                            <%
                                ArrayList<String> nacionalidades = Huesped.obtenerNacionalidadesFijas();
                            %>
                            Nacionalidad <select name="nacionalidad" class="form-input" required="true">
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
                                required="true"
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
