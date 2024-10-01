<%-- 
    Document   : sideBarReserva
    Created on : 30 sept 2024, 14:52:19
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
    </head>
    <body>
        
            <img src="../assets/images/logo.jpeg" alt="Hotel Logo">
            <ul>
                <li><a href="../panelAdministrador.jsp" class="menu-link"><i class="fas fa-home"></i>Inicio</a></li>
                <li><a href="reservas.jsp" class="menu-link"><i class="fas fa-info"></i>Información</a></li>
                <li><a href="agregarReserva.jsp" class="menu-link"><i class="fas fa-calendar-plus"></i>Registrar Reserva</a></li>   
                <li><a href="actualizarReserva.jsp" class="menu-link"><i class="fas fa-calendar-check"></i> Modificar Reservas</a></li> 
                <li><a href="eliminarReserva.jsp" class="menu-link"><i class="fas fa-calendar-minus"></i>Borrar Reservas</a></li>
                <li><a href="consultarReservas.jsp" class="menu-link"><i class="fas fa-calendar-day"></i> Consultar Reservas</a></li>
                <li><a href="moduloEstadisticoReserva.jsp" class="menu-link"><i class="fas fa-chart-bar"></i> Módulo Estadístico</a></li> 
            </ul>
    </body>
</html>
