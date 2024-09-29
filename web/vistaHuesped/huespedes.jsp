<%-- 
    Document   : huespedes
    Created on : 28 sept 2024, 14:30:10
    Author     : Usuario
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Huesped"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Huespedes</title>
    </head>
    <body>
        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Logo -->
                <img src="../assets/images/logo.jpeg" alt="Hotel Logo">
                <ul>
                    <li><a href="agregarHuesped.jsp" class="menu-link"><i class="fas fa-user-plus"></i> Registrar Huéspedes</a></li>    
                    <li><a href="actualizarHuesped.jsp" class="menu-link"><i class="fas fa-user-edit"></i> Modificar Huéspedes</a></li> 
                    <li><a href="eliminarHuesped.jsp" class="menu-link"><i class="fas fa-user-times"></i> Borrar Huéspedes</a></li>
                    <li><a href="consultarHuespedes.jsp" class="menu-link"><i class="fas fa-users"></i> Consultar Huéspedes</a></li>
                    <li><a href="moduloEstadisticoHuesped.jsp" class="menu-link"><i class="fas fa-chart-bar"></i> Módulo Estadístico</a></li> 
                </ul>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <h1 class="form-title">Gestión de Huéspedes</h1>


                <div class="welcome-text">
                    <p>Sistema de huespedes del hotel. Controle y administre de forma óptima y fácil el flujo de huéspedes del hotel.</p>
                    <p>Esta herramienta le permitirá llevar un control completo y detallado de sus huéspedes, teniendo acceso a herramientas especiales para tareas específicas como lo son:</p>
                    <ul>
                        <li>Registro de Huéspedes</li>
                        <li>Edición de Huéspedes existentes</li>
                        <li>Eliminar Huéspedes</li>
                        <li>Consultar los Huéspedes</li>
                        <li>Consultar el Modulo Estadistico de los Huéspedes</li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
