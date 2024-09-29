<%-- 
    Document   : eliminarHuesped
    Created on : 28 sept 2024, 14:38:32
    Author     : Usuario
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="modelo.Huesped"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="styles/styles.css"/>
        <title>Eliminar Huesped</title>
    </head>
    <body>
        <!-- Título -->
        <h1 class="form-title">Eliminar Huesped</h1>
        <div class="form-container">
            <div>
                <%
                    ControladorBD controlador = new ControladorBD();
                    if ("POST".equalsIgnoreCase(request.getMethod())
                            && request.getParameter("id") != null) {

                        // Obtenemos los valores del formulario
                        Integer id = Integer.parseInt(request.getParameter("id"));
                        
                        controlador.conectar();

                        controlador.eliminarHuesped(id);

                        controlador.desconectar();

                        response.sendRedirect(request.getContextPath() + "/vistaHuesped/eliminarHuesped.jsp");
                    }
                %>
            </div>
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
                    >Eliminar</button>
            </form>
        </div>
            <br>
        <div>
            <%
                ArrayList<Huesped> huespedes = new ArrayList<>();

                controlador.conectar();

                huespedes = controlador.consultarHuspedes();

                controlador.desconectar();

            %>

            <table border=1, width="500">
                <tr>
                    <th>Id</th><th>Nombre</th><th>Apellido</th><th>Fecha de Nacimiento</th><th>Nacionalidad</th><th>Telefono</th>
                </tr>
                <%                for (Huesped hp : huespedes) {
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
            </form>

        </div>

    </body>
</html>
