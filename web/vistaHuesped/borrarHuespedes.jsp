<%-- 
    Document   : borrarHuespedes
    Created on : 28 sept 2024, 18:17:28
    Author     : Usuario
--%>

<%@page import="modelo.Nacionalidad"%>
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

            Nacionalidad na = new Nacionalidad();
            ArrayList<String> nacionalidades = na.obtenerNacionalidadesFijas();
        %>
        <h1>Borrar Huesped</h1>
        <table border=1, width="500">
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
                    //out.print("<td>" + hp.getIdReserva()+ "</td></tr>");
                }
            %>            
        </table> 
        <br><br>
        <form action="eliminarHuesped.jsp" method="post">
            <select name="id">
                <%
                    for (Huesped hp : huespedes) {
                        out.print("<option>" + hp.getId() + "</option>");
                    }
                %>
            </select>
            <br><br>
            <input type="submit" value="eliminar">  
        </form>
    </body>
</html>
