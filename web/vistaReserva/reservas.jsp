<%-- 
    Document   : reservas
    Created on : 26 sept 2024, 16:48:51
    Author     : kakashi
--%>

<%@page import="modelo.Usuario"%>
<%@page import="modelo.Habitacion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Reserva"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Reservas</title>
    </head>
    <body>
        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Logo -->
                <img src="../assets/images/logo.jpeg" alt="Hotel Logo">
                <ul>
                    <li><a href="agregarReserva.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Registrar Reservas</a></li>    
                    <li><a href="actualizarReserva.jsp" class="menu-link"><i class="fas fa-user-edit"></i> Modificar Reservas</a></li> 
                    <li><a href="eliminarReserva.jsp" class="menu-link"><i class="fas fa-user-times"></i> Borrar Reservas</a></li>
                    <li><a href="consultarReservas.jsp" class="menu-link"><i class="fas fa-users"></i> Consultar Reservas</a></li>
                    <li><a href="moduloEstadisticoReserva.jsp" class="menu-link"><i class="fas fa-chart-bar"></i> Módulo Estadístico</a></li> 
                </ul>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <h1 class="form-title">Gestión de Reservas</h1>


                <div class="welcome-text">
                    <p>Sistema de reservas del hotel. Controle y administre de forma óptima y fácil el flujo de reservas del hotel.</p>
                    <p>Esta herramienta le permitirá llevar un control completo y detallado de sus reservas, teniendo acceso a herramientas especiales para tareas específicas como lo son:</p>
                    <ul>
                        <li>Registro de Reservas</li>
                        <li>Edición de reservas existentes</li>
                        <li>Eliminar Reservas</li>
                        <li>Consultar las Reservas</li>
                        <li>Consultar el Modulo Estadistico de Reservas</li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
