<%-- 
    Document   : consultarHuespedes
    Created on : 28 sept 2024, 18:54:59
    Author     : Usuario
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
        <link rel="stylesheet" type="text/css" href="styles/styles.css"/>
        <title>Consultas Huesped</title>
    </head>
    <body>
        <!-- Título -->
        <h1 class="form-title">Consultar Huespedes</h1>

        <div class="form-container">
            <div>
                <%
                    ControladorBD controlador = new ControladorBD();
                    Integer id = null;
                    ArrayList<Huesped> huespedes = new ArrayList<>();
                    Huesped huespedId = new Huesped();
                    if ("POST".equalsIgnoreCase(request.getMethod())
                            && request.getParameter("id") != null) {
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
                            out.println("Error: El ID debe ser un número.");
                        }
                    }
                %>
            </div>
            <h2>Buscar huesped por id</h2>
            <form class="form" method="post">
                <div class="form-group">
                    Id <input 
                        type="text" 
                        class="form-input"
                        placeholder="id"
                        name="id"
                        />
                </div>
                <!-- Botón de envío -->
                <button
                    type="submit" 
                    class="form-submit"
                    >Buscar</button>
            </form>
        </div>
        <br>
        <%
            if (id != null && huespedId != null) { %>
        <h3>Huésped encontrado</h3>
        <table border=1, width="500">
            <tr>
                <th>Id</th><th>Nombre</th><th>Apellido</th><th>Fecha de Nacimiento</th><th>Nacionalidad</th><th>Telefono</th>
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
        <h3>>No se encontró ningún huésped con el ID <%= id%></h3>
        <%} else { %>
        <h3>Lista de todos los huéspedes</h3>
        <table border=1, width="500">
            <tr>
                <th>Id</th><th>Nombre</th><th>Apellido</th><th>Fecha de Nacimiento</th><th>Nacionalidad</th><th>Telefono</th>
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
        <%
            }
        %>
    </body>
</html>
