<%-- 
    Document   : consultarHuespedes
    Created on : 28 sept 2024, 18:54:59
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page import="modelo.Huesped"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Consultas Huesped</title>
    </head>
    <body>
        <script src="../javascript/script.js"></script>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarHuesped.jsp" %>
            </div>

            <div class="main-content">
                <div class="form-container">
                    <h1 class="form-title">Consultar huésped por ID</h1>
                    <form class="form" method="post" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="id">ID:</label>
                            <input 
                                type="text" 
                                id="id"
                                class="form-input"
                                placeholder="Ingrese el valor a buscar (ej: 4, 10)"
                                name="id"
                                required
                                />
                        </div>
                        <!-- Botón de envío -->
                        <button type="submit" class="form-submit">Buscar</button>
                    </form>

                    <%
                        ControladorBD controlador = new ControladorBD();
                        Integer id = null;
                        ArrayList<Huesped> huespedes = new ArrayList<>();
                        Huesped huespedId = new Huesped();
                        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("id") != null) {
                            try {
                                // Convertimos el ID en Integer
                                id = Integer.parseInt(request.getParameter("id"));

                                // Conectamos a la base de datos y buscamos el huésped
                                controlador.conectar();
                                huespedes = controlador.consultarHuspedes();
                                controlador.desconectar();

                                // Buscamos el huésped en la lista por su ID
                                huespedId = Huesped.buscarHuespedPorId(huespedes, id);

                            } catch (NumberFormatException e) {
                                out.println("<div class='error'>Error: El ID debe ser un número.</div>");
                            }
                        }
                    %>

                    <br>
                    <%
                    if (id != null && huespedId != null) { %>
                    <h3>Huésped encontrado</h3>
                    <table class="result-table">
                        <tr>
                            <th>Id</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Fecha de Nacimiento</th>
                            <th>Nacionalidad</th>
                            <th>Teléfono</th>
                        </tr>
                        <%
                            out.print("<tr><td>" + huespedId.getId() + "</td>");
                            out.print("<td>" + huespedId.getNombre() + "</td>");
                            out.print("<td>" + huespedId.getApellido() + "</td>");
                            out.print("<td>" + huespedId.getFechaNacimiento() + "</td>");
                            out.print("<td>" + huespedId.getNacionalidad() + "</td>");
                            out.print("<td>" + huespedId.getTelefono() + "</td></tr>");
                        %>            
                    </table> 
                    <% } else if (id != null) {%>
                    <h3>No se encontró ningún huésped con el ID <%= id%></h3>
                    <% } else { %>
                    <h3>Lista de todos los huéspedes</h3>
                    <table class="result-table">
                        <tr>
                            <th>Id</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>Fecha de Nacimiento</th>
                            <th>Nacionalidad</th>
                            <th>Teléfono</th>
                        </tr>
                        <%
                            controlador.conectar();
                            huespedes = controlador.consultarHuspedes();
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
                    <% }%>
                </div>
            </div>
        </div>

        <script>
            function validateForm() {
                const idInput = document.getElementById("id").value;
                if (isNaN(idInput) || idInput.trim() === "") {
                    alert("Por favor, ingrese un ID válido.");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>
