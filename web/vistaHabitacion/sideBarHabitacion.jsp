<%-- 
    Document   : sideBarHabitacion
    Created on : 30 sep 2024, 6:29:25 p.m.
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    </head>
    <body>

        <img src="../assets/images/logo.jpeg" alt="Hotel Logo">
        <ul>
            <li><a href="../panelAdministrador.jsp" class="menu-link"><i class="fas fa-home"></i>Inicio</a></li>
            <li><a href="habitaciones.jsp" class="menu-link"><i class="fas fa-info"></i>Información</a></li>
            <li><a href="agregarHabitacion.jsp" class="menu-link"><i class="fas fa-sharp fa-solid fa-plus"></i> Registrar Habitaciones</a></li>    
            <li><a href="actualizarHabitacion.jsp" class="menu-link"><i class="fas fa-solid fa-marker"></i> Modificar Habitaciones</a></li> 
            <li><a href="eliminarHabitacion.jsp" class="menu-link"><i class="fas fa-sharp fa-solid fa-trash"></i> Borrar Habitaciones</a></li>
            <li><a href="consultarHabitaciones.jsp" class="menu-link"><i class="fas fa-search"></i> Consultar Habitaciones</a></li>
            <li><a href="moduloEstadisticoHabitacion.jsp" class="menu-link"><i class="fas fa-chart-bar"></i> Módulo Estadístico</a></li> 
        </ul>
    </body>
</html>
