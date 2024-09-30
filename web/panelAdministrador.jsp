<%-- 
    Document   : panelAdministrador
    Created on : 26 sept 2024, 16:49:33
    Author     : kakashi
--%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="styles/test.css"/>
        <title>Hotel CRM Palace </title>
    </head>
    <body>
         <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Logo -->
                <img src="./assets/images/logo.jpeg" alt="Hotel Logo">
                <ul>
                    <li><a href="vistaHuesped/huespedes.jsp" class="menu-link"><i class="fas fa-user-plus"></i>Registro de Huéspedes</a></li> 
                </ul>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="header">
                    <div>Sistema de reservas Hotel CRB Palace</div>
                    <div class="date"><%out.print("Hoy es " + LocalDate.now());%></div>
                </div>

                <h1 class="title">Bienvenido</h1>

                <div class="welcome-text">
                    <p>Sistema del hotel. Controle y administre de forma óptima y fácil el flujo de reservas y de huéspedes del hotel.</p>
                    <p>Esta herramienta le permitirá llevar un control completo y detallado de sus reservas y huéspedes, teniendo acceso a herramientas especiales para tareas específicas como lo son:</p>
                    <ul>
                        <li>Registro de Reservas y Huéspedes</li>
                        <li>Edición de Reservas y Huéspedes existentes</li>
                        <li>Eliminar todo tipo de registros</li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
