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
        <title>Reservas</title>
    </head>
    <body>
        <h1>Reservas</h1>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Reserva> reservas = new ArrayList<>();
            ArrayList<Habitacion> habitaciones = new ArrayList<>();
            ArrayList<Usuario> clientes = new ArrayList<>();
            controlador.conectar();
            
            habitaciones = controlador.consultarHabitaciones();
            reservas = controlador.consultarReservas();
            clientes = controlador.consultarUsuarios();
            
            controlador.desconectar();

        %>
        
         <table border=1, width="800">
            <tr>
                <th>Id Reserva</th>
                <th>Fecha entrada</th>
                <th>Fecha Salida</th>
                <th>Forma de pago</th>
                <th>Id Habitacion</th>
                <th>costo por noche</th>
                <th>Id cliente</th>
            </tr>
            <%
                for (Reserva reserva : reservas) {
                    out.print("<tr><td>" + reserva.getIdReserva() + "</td>");
                    out.print("<td>" + reserva.getFechaEntrada() + "</td>");
                    out.print("<td>" + reserva.getFechaSalida() + "</td>");
                    out.print("<td>" + reserva.getFormaPago()+ "</td>");
                    out.print("<td>" + reserva.getIdHabitacion() + "</td>");
                    out.print("<td>" + reserva.getValor() + "</td>");
                    out.print("<td>" + reserva.getIdCliente()+ "</td></tr>");
                }
            %>            
        </table>
        <ul>
            <li><button id="openAgregarReserva">agregar Reserva</button></li>
            <li><button id="openActualizarReserva">Actualizar Reserva</button></li>
            <li><button id="openBorrarReserva">Borrar Reserva</button></li>
            <li><button id="openConsultarReserva">Consultar reserva por ID</button></li>
            <li><button id="openOrdenarReservas">Mostrar reservas por fecha de entrada</button></li>
            <li><button id="openFormaDePago">Ver forma de pago preferida por los clientes</button></li>
            <li><button id="openPromedioDeEstadia">Ver promedio de estadia de los clientes</button></li>
            <li><button id="openPromedioGananciaPorDia">Ver promedio de ganancias diarias de acuerdo al tiempo de estadia de los clientes</button></li>
        </ul>
        
            <jsp:include page="formularioAgregarReserva.jsp" />
            <jsp:include page="formularioActualizarReserva.jsp" />
            <jsp:include page="formularioEliminarReserva.jsp" />
            <jsp:include page="formularioBuscarReservaId.jsp" />
            <jsp:include page="ordenarReservas.jsp" />
            <jsp:include page="formaPagoPreferida.jsp" />
            <jsp:include page="promedioEstadia.jsp" />
            <jsp:include page="promedioGananciaPorDia.jsp" />
    </body>
</html>
