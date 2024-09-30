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
                <img src="../assets/images/logo.jpeg" alt="Hotel Logo">
                <ul>
                    <li><a href="huespedes.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Huéspedes</a></li> 
                    <li><a href="agregarHuesped.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Registrar Huéspedes</a></li>    
                    <li><a href="eliminarHuesped.jsp" class="menu-link"><i class="fas fa-user-times"></i> Borrar Huéspedes</a></li>
                    <li><a href="consultarHuespedes.jsp" class="menu-link"><i class="fas fa-users"></i> Consultar Huéspedes</a></li>
                    <li><a href="moduloEstadisticoHuesped.jsp" class="menu-link"><i class="fas fa-chart-bar"></i> Módulo Estadístico</a></li> 
                </ul>
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
                                if ("POST".equalsIgnoreCase(request.getMethod())
                                        && request.getParameter("nombre") != null
                                        && request.getParameter("apellido") != null
                                        && request.getParameter("fechaNacimiento") != null
                                        && request.getParameter("nacionalidad") != null) {

                                    // Obtenemos los valores del formulario
                                    Integer id = Integer.parseInt(request.getParameter("id"));
                                    String nombre = request.getParameter("nombre");
                                    String apellido = request.getParameter("apellido");
                                    DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                                    LocalDate fechaNacimiento = LocalDate.parse(request.getParameter("fechaNacimiento"), formato);
                                    String nacionalidad = request.getParameter("nacionalidad");
                                    String telefono = request.getParameter("telefono");

                                    controlador.conectar();
                                    controlador.actualizarHuesped(nombre, apellido, fechaNacimiento, nacionalidad, telefono, id);
                                    controlador.desconectar();

                                    response.sendRedirect(request.getContextPath() + "/vistaHuesped/actualizarHuesped.jsp");
                                }
                            %>
                        </div>

                        <div class="form-group">
                            Id <input 
                                type="text" 
                                class="form-input"
                                placeholder="id"
                                name="id"
                                />
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
                            >Actualizar</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
