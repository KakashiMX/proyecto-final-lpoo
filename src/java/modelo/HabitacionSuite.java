/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author kakashi
 */

// los precios de las habitaciones suit varian entre $7,000 y $16,000
public class HabitacionSuite extends Habitacion{
    // servicios como jacuzzi, minibar, servicio 24 horas
    private boolean servicioHabitacion;
    // ciudad, mar, montaña o jardín
    private String vista;
    
    public HabitacionSuite(){
        
    }

    public HabitacionSuite(boolean servicioHabitacion, String vista) {
        this.servicioHabitacion = servicioHabitacion;
        this.vista = vista;
    }

    public HabitacionSuite(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio, double precioTotalTipoHabitacion, 
            boolean servicioHabitacion, String vista) {
        super(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalTipoHabitacion);
        this.servicioHabitacion = servicioHabitacion;
        this.vista = vista;
    }

    public boolean isServicioHabitacion() {
        return servicioHabitacion;
    }

    public void setServicioHabitacion(boolean servicioHabitacion) {
        this.servicioHabitacion = servicioHabitacion;
    }

    public String getVista() {
        return vista;
    }

    public void setVista(String vista) {
        this.vista = vista;
    }
    
    @Override
    public double calcularPrecioTotal(double precio) {
        double precioBase = precio;
        
        // Ajuste de precio por tener cocina
        if (servicioHabitacion) {
            precioBase += 3850;
        }
        System.out.println(this.vista);
        if( vista.equalsIgnoreCase("ciudad")){
            precioBase += 1799;
        }else if( vista.equalsIgnoreCase("mar")){
            precioBase += 3590;
        }else if( vista.equalsIgnoreCase("montañas")){
            precioBase += 2720;
        }else if( vista.equalsIgnoreCase("jardin")){
            precioBase+= 1000;
        }
        
        return precioBase;
    }
    
}
