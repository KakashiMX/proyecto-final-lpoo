<%-- 
    Document   : moduloEstadisticoHuesped
    Created on : 29 sept 2024, 08:45:14
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Huesped"%>
<%@page import="datos.ControladorBD"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Modulo Estadistico Huespedes</title>
    </head>
    <body>
        <script src="../javascript/script.js"></script>
        <div class="container">
            <div class="sidebar">
                <%@ include file="sideBarHuesped.jsp" %>
            </div>
            <div class="main-content">
                <h1 class="form-title">Módulo Estadístico de Huéspedes</h1>
                <%
                    ControladorBD controlador = new ControladorBD();
                    ArrayList<Huesped> huespedes = new ArrayList<>();

                    controlador.conectar();
                    huespedes = controlador.consultarHuspedes();
                    controlador.desconectar();

                    if (huespedes.size() == 0) {
                        out.print("<br><br><h2 class=form-title>No tienes huéspedes agregados</h1>");
                        return;
                    }

                    Map<String, Integer> numHuespedesNacionalidad = Huesped.contarHuespedesPorNacionalidad(huespedes);
                    int promedioEdad = Huesped.calcularEdadPromedio(huespedes);
                    Map<String, Integer> numHuespedesIntervaloEdad = Huesped.contarPorRangosDeEdad(huespedes);
                    Map<String, Integer> numHuespedesNombre = Huesped.nombresMasComunes(huespedes);
                    Map<String, Integer> numHuespedesApellido = Huesped.apellidosMasComunes(huespedes);


                %>

                <div class="main-content">
                    <h2>Número de Huéspedes por Nacionalidad</h2>
                    
                     <form method="POST" action="">
                        <p>Seleccione la nacionalidad</p>
                        <select name="nacionalidad" class="form-input" required="true" onchange="this.form.submit()">
                            <option value="">--Seleccionar--</option>
                            <%
                                for (Map.Entry<String, Integer> entry : numHuespedesNacionalidad.entrySet()) {
                                    out.print("<option>" + entry.getKey() + "</option>");
                                }
                            %>
                        </select>
                    </form>

                    <%
                        request.setCharacterEncoding("UTF-8");
                        String nacionalidad = request.getParameter("nacionalidad"); %>
                    <% if (nacionalidad != null && !nacionalidad.isEmpty()) {%>
                    <table>
                        <tr>
                            <th>Nacionalidad</th>
                            <th>Cantidad</th>
                        </tr>
                        <tr>
                            <td><%= nacionalidad%></td>
                            <td><%= numHuespedesNacionalidad.get(nacionalidad)%></td>
                        </tr>
                    </table>
                    <% } %>
                    
                    <h2>Número de Huéspedes por Intervalo de Edad</h2>
                    <table>
                        <tr>
                            <th>Rango de Edad</th>
                            <th>Cantidad</th>
                        </tr>
                        <%
                            for (Map.Entry<String, Integer> entry : numHuespedesIntervaloEdad.entrySet()) {
                                out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                            }
                        %>
                    </table>

                    <h2>Número de Huéspedes con el Mismo Nombre</h2>

                    <form method="POST" action="">
                        <p>Seleccione el nombre</p>
                        <select name="nombreComun" class="form-input" required="true" onchange="this.form.submit()">
                            <option value="">--Seleccionar--</option>
                            <%
                                for (Map.Entry<String, Integer> entry : numHuespedesNombre.entrySet()) {
                                    out.print("<option>" + entry.getKey() + "</option>");
                                }
                            %>
                        </select>
                    </form>

                    <%
                        request.setCharacterEncoding("UTF-8");
                        String nombre = request.getParameter("nombreComun"); %>
                    <% if (nombre != null && !nombre.isEmpty()) {%>
                    <table>
                        <tr>
                            <th>Nombre</th>
                            <th>Cantidad</th>
                        </tr>
                        <tr>
                            <td><%= nombre%></td>
                            <td><%= numHuespedesNombre.get(nombre)%></td>
                        </tr>
                    </table>
                    <% } %>

                    <h2>Número de Huéspedes con el Mismo Apellido</h2>

                    <form method="POST" action="">
                        <p>Seleccione el apellido:</p>
                        <select name="apellidoComun" class="form-input" required="true" onchange="this.form.submit()">
                            <option value="">--Seleccionar--</option>
                            <%
                                for (Map.Entry<String, Integer> entry : numHuespedesApellido.entrySet()) {
                                    out.print("<option>" + entry.getKey() + "</option>");
                                }
                            %>
                        </select>
                    </form>

                    <%
                        request.setCharacterEncoding("UTF-8");
                        String apellido = request.getParameter("apellidoComun"); %>
                    <% if (apellido != null && !apellido.isEmpty()) {%>
                    <table>
                        <tr>
                            <th>Apellido</th>
                            <th>Cantidad</th>
                        </tr>
                        <tr>
                            <td><%= apellido%></td>
                            <td><%= numHuespedesApellido.get(apellido)%></td>
                        </tr>
                    </table>
                    <% } %>

                    <h2>Promedio de la Edad de Huéspedes</h2>
                    <table>
                        <tr>
                            <th>Edad Promedio</th>
                            <td><% out.print(promedioEdad + " años");%></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </body>

</html>
