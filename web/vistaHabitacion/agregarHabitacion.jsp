<%-- 
    Document   : agregarHabitacion
    Created on : 1 oct 2024, 6:56:15 a.m.
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="modelo.HabitacionSencilla"%>
<%@page import="modelo.HabitacionSuite"%>
<%@page import="modelo.HabitacionFamiliar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Habitacion"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Agregar Habitación</title>
    </head>
    <body>
        <%
            ControladorBD controlador = new ControladorBD();
            controlador.conectar();
            
            %>
        <div class="container">
            <div class="sidebar">
            <%@ include file="sideBarHabitacion.jsp" %> 
        </div>
        <div class="main-content">
                <div class="form-container">
                    <form class="form" method="post" accept-charset="UTF-8">
                        <!-- Título -->
                        <h1 class="form-title">Registro de Habitacion</h1>
                        <div>
                            <% 
                            request.setCharacterEncoding("UTF-8");
                            if ("POST".equalsIgnoreCase(request.getMethod())){
                                // habitacion sencilla
                                String numHabitacion = request.getParameter("numHabitacion");
                                String tipoHabitacion = request.getParameter("tipoHabitacion");
                                boolean disponibilidad = Boolean.parseBoolean(request.getParameter("disponibilidad"));
                                double precio = Double.parseDouble(request.getParameter("precio"));
                                
                                // variables habitacion familiar
                                int capacidadMaxima;
                                // de dos a 5
                                int numCamas;
                                boolean tieneSala;
                                boolean tieneCocina;
                                
                                // variables habitacion familiar
                                boolean servicios;
                                String vista;
                                

                                if(numHabitacion==null || tipoHabitacion==null){
                                    out.println("<p style='color:red;'>Todos los campos son obligatorios</p>");
                                }else {   
                                
                                    switch (tipoHabitacion) {
                                            case "Familiar":
                                                capacidadMaxima = Integer.parseInt(request.getParameter("capacidadMaxima"));
                                                tieneSala = Boolean.parseBoolean(request.getParameter("tieneSala"));
                                                tieneCocina = Boolean.parseBoolean(request.getParameter("tieneCocina"));
                                                HabitacionFamiliar habitacionFamiliar = new HabitacionFamiliar(capacidadMaxima, tieneSala, tieneCocina);
                                                double precioTotalFamiliar = habitacionFamiliar.calcularPrecioTotal(precio);
                                                habitacionFamiliar = new HabitacionFamiliar(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalFamiliar, 
                                                capacidadMaxima, tieneSala, tieneCocina);
                                                controlador.agregarHabitacionFamiliar(habitacionFamiliar);
                                                break;
                                            case "Suite":
                                                servicios = Boolean.parseBoolean(request.getParameter("servicios"));
                                                vista = request.getParameter("vista");
                                                HabitacionSuite habitacionSuite = new HabitacionSuite(servicios, vista);
                                                double precioTotalSuite = habitacionSuite.calcularPrecioTotal(precio);
                                                habitacionSuite = new HabitacionSuite(numHabitacion, tipoHabitacion, disponibilidad, precio, 
                                                precioTotalSuite, servicios, vista);
                                                controlador.agregarHabitacionSuite(habitacionSuite);
                                                break;
                                            default:
                                                HabitacionSencilla habitacionSencilla = new HabitacionSencilla();
                                                double precioTotalSencilla = habitacionSencilla.calcularPrecioTotal(precio);
                                                habitacionSencilla = new HabitacionSencilla(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalSencilla);
                                                controlador.agregarHabitacion(habitacionSencilla);
                                                
                                        }
                                    controlador.desconectar();

                                    response.sendRedirect("agregarHabitacion.jsp");
                                }
                                
                                controlador.desconectar();
                            }
                                
                                %>

                        <div class="form-group">
                            Número de habitación: <input 
                                type="text" 
                                class="form-input"
                                placeholder="Número de habitación"
                                name="numHabitacion"
                                required="true"
                                />
                        </div>
                          <div class="form-group">
                            <label class="form-label">Tipo de Habitación: </label>
                            <select id="tipoHabitacion" name="tipoHabitacion" class="form-input" required="true">
                                <option value="">---Seleccionar---</option>
                                <option value="Sencilla">Sencilla</option>
                                <option value="Familiar">Familiar</option>
                                <option value="Suite">Suite</option>
                            </select>
                        </div>
                                    
                        <div id="tipoFamiliar" style="display: none">
                            <div class="form-group">
                                <label class="form-label">Capacidad Máxima:</label>
                                <select name="capacidadMaxima" class="form-input">
                                    <option value="3">Tres personas</option>
                                    <option value="4">Cuatro personas</option>
                                    <option value="5">Cinco personas</option>
                                    <option value="6">Seis personas</option>
                                </select>
                            </div>
                                    
                            <div class="form-group">
                                <label class="form-label">¿Tiene sala?</label>

                                <label>Sí</label>
                                <input type="radio" name="tieneSala" value='true'/>
                                <label>No</label>
                                <input type="radio" name="tieneSala" value='false'/>
                            </div>
                                    
                            <div class="form-group">
                                <label class="form-label">¿Tiene Cocina?</label>

                                <label>Sí</label>
                                <input type="radio" name="tieneCocina" value='true'/>
                                <label>No</label>
                                <input type="radio" name="tieneCocina" value='false'/>
                            </div>
                        </div>
                                
                        <div id="tipoSuite" style="display: none">
                            <div class="form-group">
                                <label class="form-label">¿Servicios?(Jacuzzi, Minibar, servicio 24 horas):</label>
                                <label>Sí</label>
                                <input type="radio" name="servicios" value='true'/>
                                <label>No</label>
                                <input type="radio" name="servicios" value='false'/>
                            </div>
                                    
                            <div class="form-group">
                                <label class="form-label">Vista</label>
                                <select name="vista" class="form-input">
                                    <option value="Jardin">Jardín</option>
                                    <option value="Ciudad">Ciudad</option>
                                    <option value="Montañas">Montañas</option>
                                    <option value="Mar">Mar</option>
                                </select>
                            </div>                                          
                        </div>     
                        <div class="form-group">
                            <label class="form-label">Disponibilidad: </label>
                            <select name="disponibilidad" class="form-input" required="true">
                                <option value="">---Seleccionar---</option>
                                <option value=true>Disponible</option>
                                <option value=false>No disponible</option>
                            </select>
                        </div>
                        <div class="form-group">
                            Precio: <input 
                                type="texto" 
                                class="form-input"
                                placeholder="Precio"
                                name="precio"
                                required="true"
                                />
                        </div>
              
   
                        <!-- Botón de envío -->
                        <button
                            type="submit" 
                            class="form-submit"
                            >Agregar</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
                const tipoHabitacion = document.getElementById("tipoHabitacion");
                const tipoFamiliar = document.getElementById("tipoFamiliar");
                const tipoSuite = document.getElementById("tipoSuite");
                
                // Función que actualiza el select de habitaciones disponibles
                tipoHabitacion.addEventListener('change', () => {
                   if( tipoHabitacion.value === 'Familiar'){
                       tipoFamiliar.style.display="block";
                       tipoSuite.style.display="none";
                   }else if(tipoHabitacion.value === 'Suite'){
                       tipoSuite.style.display="block";
                       tipoFamiliar.style.display="none";
                   }
                });
        </script>
    </body>
</html>
