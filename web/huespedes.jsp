<%-- 
    Document   : huespedes
    Created on : 28 sept 2024, 14:30:10
    Author     : Usuario
--%>

<%@page import="modelo.Nacionalidad"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Huesped"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Huespedes</title>
    </head>
    <body>
        <h1>Huespedes</h1>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Huesped> huespedes = new ArrayList<>();

            controlador.conectar();

            huespedes = controlador.consultarHuspedes();

            controlador.desconectar();

            Nacionalidad na = new Nacionalidad();
            ArrayList<String> nacionalidades = na.obtenerNacionalidadesFijas();
        %>

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

        <h2>Eliminar Huesped</h2>

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

        <h2>Agregar un Huesped</h2>
        <form action="agregarHuesped.jsp" method="post">
            Nombre <input type="text" name="nombre" size="15"><br><br>
            Apellido <input type="text" name="apellido" size="15"><br><br>
            Fecha Nacimiento <input type="text" name="fechaNacimiento" size="15"><br><br>
            Nacionalidad <select name="nacionalidad">
                <%
                    for (String nac : nacionalidades) {
                        out.print("<option>" + nac + "</option>");
                    }
                %>
            </select> <br><br>
            Telefono <input type="text" name="telefono" size="15"><br><br>
            <br><br>
            <input type="submit" value="agregar"> 

        </form>

        <h2>Actualizar Huesped</h2>
        <form action="actualizarHuesped.jsp" method="post">
            <select name="id">
                <%
                    for (Huesped hp : huespedes) {
                        out.print("<option>" + hp.getId() + "</option>");
                    }
                %>
            </select> <br><br>
            Nombre <input type="text" name="nombre" size="15"><br><br>
            Apellido <input type="text" name="apellido" size="15"><br><br>
            Fecha Nacimiento <input type="text" name="fechaNacimiento" size="15"><br><br>
            Nacionalidad <select name="nacionalidad">
                <%
                    for (String nac : nacionalidades) {
                        out.print("<option>" + nac + "</option>");
                    }
                %>
            </select> <br><br>
            Telefono <input type="text" name="telefono" size="15"><br><br>
            <br><br>
            <input type="submit" value="actualizar">  
        </form>
    </body>
</html>
