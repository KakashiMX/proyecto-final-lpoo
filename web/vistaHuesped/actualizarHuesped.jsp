<%-- 
    Document   : actualizarHuesped
    Created on : 28 sept 2024, 15:38:37
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="modelo.Huesped"%>
<%@page import="java.time.LocalDate"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Actualizar Huesped</title>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarHuesped.jsp" %>
            </div>

            <div class="main-content">
                <h1 class="form-title">Actualizar Huesped</h1>
                <div>
                    <%
                        ControladorBD controlador = new ControladorBD();
                        ArrayList<Huesped> huespedes = new ArrayList<>();

                        controlador.conectar();
                        huespedes = controlador.consultarHuspedes();
                        controlador.desconectar();
                    %>
                    <table border="1" width="500">
                        <tr>
                            <th>Id</th><th>Nombre</th><th>Apellido</th><th>Fecha de Nacimiento</th><th>Nacionalidad</th><th>Telefono</th>
                        </tr>
                        <%
                            for (Huesped hp : huespedes) {
                                out.print("<tr><td>" + hp.getId() + "</td>");
                                out.print("<td>" + hp.getNombre() + "</td>");
                                out.print("<td>" + hp.getApellido() + "</td>");
                                out.print("<td>" + hp.getFechaNacimiento() + "</td>");
                                out.print("<td>" + hp.getNacionalidad() + "</td>");
                                out.print("<td>" + hp.getTelefono() + "</td></tr>");
                            }
                        %>            
                    </table> 
                    <br><br>
                </div>

                <div class="form-container">
                    <form class="form" method="post">
                        <div>
                            <%
                                if ("POST".equalsIgnoreCase(request.getMethod())) {

                                    // Obtenemos los valores del formulario
                                    Integer id = Integer.parseInt(request.getParameter("id"));
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

                                        controlador.conectar();
                                        controlador.actualizarHuesped(nombre, apellido, fechaNacimiento, nacionalidad, telefono, id);
                                        controlador.desconectar();

                                        response.sendRedirect("actualizarHuesped.jsp");
                                    }
                                }
                            %>
                        </div>

                        <div class="form-group">
                            ID: <input 
                                type="text" 
                                class="form-input"
                                placeholder="Ingrese el valor a actualizar (ej: 1, 8)"
                                name="id"
                                />
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
                            Nacionalidad: <select name="nacionalidad" class="form-input" required="true">
                                <%
                                    for (String nac : nacionalidades) {
                                        out.print("<option>" + nac + "</option>");
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            Telefono: <input 
                                type="text" 
                                class="form-input"
                                placeholder="Telefono"
                                name="telefono"
                                required="true"
                                />
                        </div>
                        <!-- Botón de envío -->
                        <button
                            type="submit" 
                            class="form-submit"
                            >Actualizar</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
