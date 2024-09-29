<%-- 
    Document   : modificarHuespedes
    Created on : 28 sept 2024, 18:15:01
    Author     : Usuario
--%>

<%@page import="modelo.Nacionalidad"%>
<%@page import="modelo.Huesped"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
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
        <h1>Modificar Datos Huesped</h1>
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
