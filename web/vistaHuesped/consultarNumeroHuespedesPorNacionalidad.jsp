<%-- 
    Document   : consultarHuespedesPorNacionalidad
    Created on : 28 sept 2024, 20:30:15
    Author     : Usuario
--%>

<%@page import="java.util.Map"%>
<%@page import="javax.crypto.AEADBadTagException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page import="modelo.Nacionalidad"%>
<%@page import="modelo.Huesped"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Huespedes por Nacionalidad</title>
    </head>
    <body>
        <h1>Número de Huespedes por Nacionalidad</h1>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Huesped> huespedes = new ArrayList<>();

            controlador.conectar();

            huespedes = controlador.consultarHuspedes();

            controlador.desconectar();

            Huesped hp = new Huesped();

            Map<String, Integer> resultado = hp.contarHuespedesPorNacionalidad(huespedes);

        %>
        <table border=1, width="500">
            <tr>
                <th>Nacionalidad</th><th>Cantidad</th>
            </tr>
            <%                
                for (Map.Entry<String, Integer> entry : resultado.entrySet()) {
                    out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue()+"</td></tr>");
                }
            %>            
        </table> 
        <br><br>
    </body>
</html>
