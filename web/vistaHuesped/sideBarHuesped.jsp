<%-- 
    Document   : sideBarHuesped
    Created on : 30 sept 2024, 15:16:02
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
            <li><a href="huespedes.jsp" class="menu-link"><i class="fas fa-info"></i>Información</a></li>
            <li><a href="agregarHuesped.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Registrar Huéspedes</a></li>    
            <li><a href="actualizarHuesped.jsp" class="menu-link"><i class="fas fa-user-edit"></i> Modificar Huéspedes</a></li> 
            <li><a href="eliminarHuesped.jsp" class="menu-link"><i class="fas fa-user-times"></i> Borrar Huéspedes</a></li>
            <li><a href="consultarHuespedes.jsp" class="menu-link"><i class="fas fa-users"></i> Consultar Huéspedes</a></li>
            <li><a href="moduloEstadisticoHuesped.jsp" class="menu-link"><i class="fas fa-chart-bar"></i> Módulo Estadístico</a></li> 
        </ul>
    </body>
</html>
