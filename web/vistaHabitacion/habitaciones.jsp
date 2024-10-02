<%-- 
    Document   : habitaciones
    Created on : 30 sep 2024, 6:34:26 p.m.
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name ="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Habitaciones</title>
    </head>
    <body>
        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <%@ include file="sideBarHabitacion.jsp" %>
            </div>
            <div class="main-content">
                <h1 class="form-title">Gestión de Habitaciones</h1>
                
                <div class="welcome-text">
                    <p>Sistema de habitaciones del hotel. Controle y administre de forma óptima y fácil el flujo de habitaciones del hotel.</p>
                    <p>Esta herramienta le permitirá llevar un control completo y detallado de sus habitaciones, teniendo acceso a herramientas especiales para tareas específicas como lo son:</p>
                    <ul>
                        <li>Registro de Habitaciones</li>
                        <li>Edición de Habitaciones existentes</li>
                        <li>Eliminar Habitaciones</li>
                        <li>Consultar las Habitaciones</li>
                        <li>Consultar el Modulo Estadistico de las Habitaciones</li>
                      </ul>
                </div>
            </div>
        </div>
    </body>
</html>
