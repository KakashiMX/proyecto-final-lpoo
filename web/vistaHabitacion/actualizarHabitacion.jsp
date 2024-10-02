<%-- 
    Document   : actualizarHabitacion
    Created on : 30 sep 2024, 5:52:02 p.m.
    Author     : Nava Ricardo
    Author     : Ceron Cristian
    Author     : Hernández Monserrath
--%>

<%@page import="modelo.HabitacionFamiliar"%>
<%@page import="modelo.HabitacionSencilla"%>
<%@page import="modelo.HabitacionSuite"%>
<%@page import="modelo.Habitacion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="datos.ControladorBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
        <link rel="stylesheet" type="text/css" href="../styles/test.css"/>
        <title>Actualizar Habitacion</title>
    </head>
    <body>
        <div class="container">
            <div class="sidebar">
                <%@include file="sideBarHabitacion.jsp" %>
            </div>
            <div class="main-content">
                <h1 class="form-title">Actualizar Habitación</h1>
                <div>
        <%
            ControladorBD controlador = new ControladorBD();
            ArrayList<Habitacion> habitaciones = new ArrayList<>();
            
            controlador.conectar();
            habitaciones=controlador.consultarHabitaciones(); 
            %>
            
            <div class="form-container">
                    <form class="form" method="post" accept-charset="UTF-8">
                        <div>
                            <%
                                request.setCharacterEncoding("UTF-8");
                                if ("POST".equalsIgnoreCase(request.getMethod())) {
                                    // habitacion sencilla
                                int idHabitacion = Integer.parseInt(request.getParameter("idHabitacion"));
                                String numHabitacion = request.getParameter("nuevoNumHabitacion");
                                String tipoHabitacion = request.getParameter("nuevoTipoHabitacion");
                                boolean disponibilidad = Boolean.parseBoolean(request.getParameter("nuevaDisponibilidad"));
                                double precio = Double.parseDouble(request.getParameter("nuevoPrecio"));
                                
                                // variables habitacion familiar
                                int capacidadMaxima;
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
                                                capacidadMaxima = Integer.parseInt(request.getParameter("nuevaCapacidadMaxima"));
                                                tieneSala = Boolean.parseBoolean(request.getParameter("nuevaTieneSala"));
                                                tieneCocina = Boolean.parseBoolean(request.getParameter("nuevaTieneCocina"));
                                                HabitacionFamiliar habitacionFamiliar = new HabitacionFamiliar(capacidadMaxima, tieneSala, tieneCocina);
                                                
                                                double precioTotalFamiliar = habitacionFamiliar.calcularPrecioTotal(precio);
                                                habitacionFamiliar = new HabitacionFamiliar(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalFamiliar, 
                                                capacidadMaxima, tieneSala, tieneCocina);
                                                habitacionFamiliar.setIdHabitacion(idHabitacion);
                                                controlador.actualizarHabitacionFamiliar(habitacionFamiliar);
                                                break;
                                            case "Suite":
                                                servicios = Boolean.parseBoolean(request.getParameter("nuevoServicios"));
                                                vista = request.getParameter("nuevaVista");
                                                HabitacionSuite habitacionSuite = new HabitacionSuite(servicios, vista);
                                                double precioTotalSuite = habitacionSuite.calcularPrecioTotal(precio);
                                                habitacionSuite = new HabitacionSuite(numHabitacion, tipoHabitacion, disponibilidad, precio, 
                                                precioTotalSuite, servicios, vista);
                                                habitacionSuite.setIdHabitacion(idHabitacion);
                                                controlador.actualizarHabitacionSuite(habitacionSuite);
                                                break;
                                            default:
                                                HabitacionSencilla habitacionSencilla = new HabitacionSencilla();
                                                double precioTotalSencilla = habitacionSencilla.calcularPrecioTotal(precio);
                                                habitacionSencilla = new HabitacionSencilla(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalSencilla);
                                                controlador.actualizarHabitacion(idHabitacion, numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalSencilla);
                                                
                                        }
                                    controlador.desconectar();

                                    response.sendRedirect("actualizarHabitacion.jsp");
                                }
                                
                                controlador.desconectar();
                                }
             
                                %>
                                </div>
                        
                        <div class="form-group">
                            <label class="form-label">ID de habitación </label>
                            <input type="number" name='idHabitacion' class="form-input" required="true" placeholder="Ingrese el valor a actualizar (ej: 1, 8)"/>
                        </div>
                                
                        <div class="form-group">
                            Número de Habitación: <input 
                                type="texto" 
                                class="form-input"
                                placeholder="Numero"
                                name="nuevoNumHabitacion"
                                required="true"
                                />
                        </div>
                     
                        <div class="form-group">
                            <label class="form-label">Tipo de Habitación: </label>
                            <select id="nuevoTipoHabitacion" name="nuevoTipoHabitacion" class="form-input" required="true">
                                <option value="">---Seleccionar---</option>
                                <option value="Sencilla">Sencilla</option>
                                <option value="Familiar">Familiar</option>
                                <option value="Suite">Suite</option>
                            </select>
                        </div>
                                
                         <div id="tipoFamiliar" style="display: none">
                            <div class="form-group">
                                <label class="form-label">Capacidad Máxima:</label>
                                <select name="nuevaCapacidadMaxima" class="form-input">
                                    <option value="3">Tres personas</option>
                                    <option value="4">Cuatro personas</option>
                                    <option value="5">Cinco personas</option>
                                    <option value="6">Seis personas</option>
                                </select>
                            </div>
                                    
                            <div class="form-group">
                                <label class="form-label">¿Tiene sala?</label>

                                <label>Sí</label>
                                <input type="radio" name="nuevaTieneSala" value='true'/>
                                <label>No</label>
                                <input type="radio" name="nuevaTieneSala" value='false'/>
                            </div>
                                    
                            <div class="form-group">
                                <label class="form-label">¿Tiene Cocina?</label>

                                <label>Sí</label>
                                <input type="radio" name="nuevaTieneCocina" value='true'/>
                                <label>No</label>
                                <input type="radio" name="nuevaTieneCocina" value='false'/>
                            </div>
                        </div>
                                
                        <div id="tipoSuite" style="display: none">
                            <div class="form-group">
                                <label class="form-label">¿Servicios?(Jacuzzi, Minibar, servicio 24 horas):</label>
                                <label>Sí</label>
                                <input type="radio" name="nuevoServicios" value='true'/>
                                <label>No</label>
                                <input type="radio" name="nuevoServicios" value='false'/>
                            </div>
                                    
                            <div class="form-group">
                                <label class="form-label">Vista</label>
                                <select name="nuevaVista" class="form-input">
                                    <option value="Jardin">Jardín</option>
                                    <option value="Ciudad">Ciudad</option>
                                    <option value="Montañas">Montañas</option>
                                    <option value="Mar">Mar</option>
                                </select>
                            </div>                                          
                        </div>  
                        <div class="form-group">
                            <label class="form-label">Disponibilidad: </label>
                            <select name="nuevaDisponibilidad" class="form-input" required="true">
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
                                name="nuevoPrecio"
                                required="true"
                                />
                        </div>
            
                        <button
                            type="submit" 
                            class="form-submit"
                            >Actualizar</button>
                    </form>
                </div>
                    <table class="result-table">
                        <tr>
                            <th>Id Hábitación</th>
                            <th>Número de habitación</th>
                            <th>Tipo</th>
                            <th>Servicios extra</th>
                            <th>Disponibilidad</th>
                            <th>Precio</th>
                            <th>Precio con servicios extra</th>
                        </tr>
                        <%
                            controlador.conectar();
                            habitaciones = controlador.consultarHabitaciones();
                            controlador.desconectar();

                            // Iterar sobre todas las habitaciones y mostrarlas en la tabla
                            for (Habitacion hb : habitaciones) {
                                out.print("<tr>");
                                out.print("<td>" + hb.getIdHabitacion() + "</td>");
                                out.print("<td>" + hb.getNumHabitacion() + "</td>");
                                out.print("<td>" + hb.getTipoHabitacion() + "</td>");

                                // Comprobar el tipo de habitación y mostrar los atributos adicionales
                                if (hb instanceof HabitacionFamiliar) {
                                    HabitacionFamiliar familiar = (HabitacionFamiliar) hb;
                                    out.print("<td>Capacidad máxima: " + familiar.getCapacidadMaxima() +
                                              ", Cocina: " + (familiar.isTieneCocina() ? "Sí" : "No") +
                                              ", Sala: " + (familiar.isTieneSala() ? "Sí" : "No") + "</td>");
                                } else if (hb instanceof HabitacionSuite) {
                                    HabitacionSuite suite = (HabitacionSuite) hb;
                                    out.print("<td>Servicio a la habitación: " + (suite.isServicioHabitacion() ? "Sí" : "No") +
                                              ", Vista: " + suite.getVista() + "</td>");
                                } else {
                                    out.print("<td>No aplica</td>"); // HabitacionSencilla no tiene servicios extra
                                }

                                // Mostrar disponibilidad
                                if (hb.isDisponibilidad()) {
                                    out.print("<td>Disponible</td>");
                                } else {
                                    out.print("<td>No disponible</td>");
                                }

                                // Mostrar precios
                                out.print("<td>" + hb.getPrecio() + "</td>");
                                out.print("<td>" + hb.getPrecioTotalTipoHabitacion() + "</td>");
                                out.print("</tr>");
                            }
                        %>            
                    </table> 
                    <br><br>
                </div>
                    
                </div>
        </div>
                        
        <script>
                const tipoHabitacion = document.getElementById("nuevoTipoHabitacion");
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
