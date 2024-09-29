<%-- 
    Document   : moduloEstadisticoHuesped
    Created on : 29 sept 2024, 08:45:14
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Huesped"%>
<%@page import="datos.ControladorBD"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modulo Estadistico Huespedes</title>
    </head>
    <body>
        <h1>Modulo Estadistico de Huespedes</h1>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Huesped> huespedes = new ArrayList<>();

            controlador.conectar();

            huespedes = controlador.consultarHuspedes();

            controlador.desconectar();

            Map<String, Integer> numHuespedesNacionalidad = Huesped.contarHuespedesPorNacionalidad(huespedes);

            int promedioEdad = Huesped.calcularEdadPromedio(huespedes);
            
            Map<String, Integer> numHuespedesIntervaloEdad=Huesped.contarPorRangosDeEdad(huespedes);
            
            Map<String, Integer> numHuespedesNombre=Huesped.nombresMasComunes(huespedes);
            
            Map<String, Integer> numHuespedesApellido=Huesped.apellidosMasComunes(huespedes);

        %>
        
        <h2>Número de Huespedes por Nacionalidad</h2>

        <table border=1, width="500">
            <tr>
                <th>Nacionalidad</th><th>Cantidad</th>
            </tr>
            <%                
                for (Map.Entry<String, Integer> entry : numHuespedesNacionalidad.entrySet()) {
                    out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                }
            %>            
        </table> 
        <br><br>
        
        <h2>Número de Huespedes por intervalo de edad</h2>

        <table border=1, width="500">
            <tr>
                <th>Rango de edad</th><th>Cantidad</th>
            </tr>
            <%                
                for (Map.Entry<String, Integer> entry : numHuespedesIntervaloEdad.entrySet()) {
                    out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                }
            %>            
        </table> 
        <br><br>
        
        <h2>Número de Huespedes con el mismo nombre</h2>

        <table border=1, width="500">
            <tr>
                <th>Nombre</th><th>Cantidad</th>
            </tr>
            <%                
                for (Map.Entry<String, Integer> entry : numHuespedesNombre.entrySet()) {
                    out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                }
            %>            
        </table> 
        <br><br>
        
        <h2>Número de Huespedes con el mismo apellido</h2>

        <table border=1, width="500">
            <tr>
                <th>Nombre</th><th>Cantidad</th>
            </tr>
            <%                
                for (Map.Entry<String, Integer> entry : numHuespedesApellido.entrySet()) {
                    out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                }
            %>            
        </table> 
        <br><br>
        
        <h2>Promedio de la edad de huespedes</h2>

        <table border=1, width="500">
            <tr>
                <th>Edad promedio</th><th><%out.print(promedioEdad+" años");%></th>
            </tr>            
        </table> 
        <br><br>
    </body>
</html>
