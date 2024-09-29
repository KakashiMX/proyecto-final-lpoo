<%-- 
    Document   : huespedeId
    Created on : 28 sept 2024, 21:03:41
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page import="modelo.Huesped"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Huesped> huespedes = new ArrayList<>();

            controlador.conectar();

            huespedes = controlador.consultarHuspedes();

            controlador.desconectar();
            
            Integer id = Integer.parseInt(request.getParameter("id"));
            Huesped hp = new Huesped();

            Huesped huesped = hp.buscarHuespedPorId(huespedes, id);

        %>
        <table border=1, width="500">
            <tr>
                <th>Id</th><th>Nombre</th><th>Apellido</th><th>Fecha de Nacimiento</th><th>Nacionalidad</th><th>Telefono</th>
            </tr>
            <%
                    out.print("<tr><td>" + huesped.getId() + "</td>");
                    out.print("<td>" + huesped.getNombre() + "</td>");
                    out.print("<td>" + huesped.getApellido() + "</td>");
                    out.print("<td>" + huesped.getFechaNacimiento() + "</td>");
                    out.print("<td>" + huesped.getNacionalidad() + "</td>");
                    out.print("<td>" + huesped.getTelefono() + "</td></tr>");
            %>            
        </table> 
        <br><br>
    </body>
</html>
