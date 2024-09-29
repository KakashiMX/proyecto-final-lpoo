<%-- 
    Document   : registroHuespedes
    Created on : 28 sept 2024, 18:11:14
    Author     : Usuario
--%>

<%@page import="modelo.Huesped"%>
<%@page import="modelo.Nacionalidad"%>
<%@page import="modelo.Nacionalidad"%>
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
            Nacionalidad na = new Nacionalidad();
            ArrayList<String> nacionalidades = na.obtenerNacionalidadesFijas();
        %>
        <h1>Registro de Huesped</h1>
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
    </body>
</html>
