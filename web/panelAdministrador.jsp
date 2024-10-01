<%-- 
    Document   : panelAdministrador
    Created on : 26 sept 2024, 16:49:33
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
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
        <script src="./javascript/script.js"></script>
         <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Logo -->
                <img src="./assets/images/logo.jpeg" alt="Hotel Logo">
                <ul>
                    <li><a href="vistaHuesped/huespedes.jsp" class="menu-link"><i class="fas fa-users"></i>Huéspedes</a></li> 
                    <li><a href="./vistaReserva/reservas.jsp" class="menu-link"><i class="fas fa-scroll"></i>Reservas</a></li> 
                    <li id="cerrarSesion"><a href="./index.jsp" class="menu-link"><i class="fas fa-sign-out-alt"></i>Cerrar Sesión</a></li> 
                </ul>
            </div>

           <div class="admin-panel">
               <h1 id="bienvenida"></h1>

                <p>
                    Este sistema le permite gestionar de manera eficiente las reservas y huéspedes del hotel. A continuación, se describen las principales funciones que puede realizar desde este panel:
                </p>

                <h2>Funciones Disponibles</h2>
                <ul>
                    <li>Registrar nuevas reservas</li>
                    <li>Registrar nuevos huéspedes</li>
                    <li>Editar reservas y huéspedes existentes</li>
                    <li>Eliminar registros de reservas y huéspedes</li>
                    <li>Consultar el historial de reservas</li>
                    <li>Ver estadísticas básicas de ocupación y ventas</li>
                </ul>

                <h2>Instrucciones de Uso</h2>
                <ul>
                    <li>Utilice el menú de navegación en la parte lateral para acceder a las diferentes secciones del sistema</li>
                    <li>Vea estadisticas para cada entidad (Huéspedes, Habitaciones y Reservas)</li>
                </ul>
            </div>
        </div>
        
        <script>
            const nombreUsuario = localStorage.getItem("Usuario");
            const btnCerrarSesion = document.getElementById("cerrarSesion");
            document.getElementById('bienvenida').textContent = "Bienvenido '" + nombreUsuario + "'";
            btnCerrarSesion.addEventListener('click', () => {
                localStorage.removeItem("Usuario");
            });
        </script>
    </body>
</html>
