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
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Modulo Estadistico Huespedes</title>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <img src="../assets/images/logo.jpeg" alt="Hotel Logo">
                <ul>
                    <li><a href="huespedes.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Huéspedes</a></li> 
                    <li><a href="agregarHuesped.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Registrar Huéspedes</a></li>    
                    <li><a href="actualizarHuesped.jsp" class="menu-link"><i class="fas fa-user-edit"></i> Modificar Huéspedes</a></li> 
                    <li><a href="eliminarHuesped.jsp" class="menu-link"><i class="fas fa-user-times"></i> Borrar Huéspedes</a></li>
                    <li><a href="consultarHuespedes.jsp" class="menu-link"><i class="fas fa-users"></i> Consultar Huéspedes</a></li>
                </ul>
            </div>
            <div class="main-content">
                <h1 class="form-title">Módulo Estadístico de Huéspedes</h1>
                <%
                    ControladorBD controlador = new ControladorBD();
                    ArrayList<Huesped> huespedes = new ArrayList<>();

                    controlador.conectar();
                    huespedes = controlador.consultarHuspedes();
                    controlador.desconectar();

                    Map<String, Integer> numHuespedesNacionalidad = Huesped.contarHuespedesPorNacionalidad(huespedes);
                    int promedioEdad = Huesped.calcularEdadPromedio(huespedes);
                    Map<String, Integer> numHuespedesIntervaloEdad = Huesped.contarPorRangosDeEdad(huespedes);
                    Map<String, Integer> numHuespedesNombre = Huesped.nombresMasComunes(huespedes);
                    Map<String, Integer> numHuespedesApellido = Huesped.apellidosMasComunes(huespedes);
                %>

                <div class="main-content">
                    <h2>Número de Huéspedes por Nacionalidad</h2>
                    <table>
                        <tr>
                            <th>Nacionalidad</th>
                            <th>Cantidad</th>
                        </tr>
                        <%
                            for (Map.Entry<String, Integer> entry : numHuespedesNacionalidad.entrySet()) {
                                out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                            }
                        %>
                    </table>

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
                    <table>
                        <tr>
                            <th>Nombre</th>
                            <th>Cantidad</th>
                        </tr>
                        <%
                            for (Map.Entry<String, Integer> entry : numHuespedesNombre.entrySet()) {
                                out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                            }
                        %>
                    </table>

                    <h2>Número de Huéspedes con el Mismo Apellido</h2>
                    <table>
                        <tr>
                            <th>Apellido</th>
                            <th>Cantidad</th>
                        </tr>
                        <%
                            for (Map.Entry<String, Integer> entry : numHuespedesApellido.entrySet()) {
                                out.println("<tr><td>" + entry.getKey() + "</td><td>" + entry.getValue() + "</td></tr>");
                            }
                        %>
                    </table>

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
