<%-- 
    Document   : eliminarHuesped
    Created on : 28 sept 2024, 14:38:32
    Author     : Usuario
--%>

<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Huesped</title>
    </head>
    <body>
        <%
        ControladorBD controlador = new ControladorBD();
        
        controlador.conectar();
        
        Integer id=Integer.parseInt(request.getParameter("id"));
        
        controlador.eliminarHuesped(id);
        
        controlador.desconectar();
        
        response.sendRedirect("borrarHuespedes.jsp");
        
        %>
    </body>
</html>
