<%-- 
    Document   : reservas
    Created on : 26 sept 2024, 16:48:51
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
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
        <script src="../javascript/script.js"></script>
        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <%@ include file="sideBarReserva.jsp" %>
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
