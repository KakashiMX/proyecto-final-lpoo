/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.util.ArrayList;

/**
 * La clase {@code HabitacionSuite} representa una habitación de tipo suite en el sistema de reservas.
 * Los precios de las habitaciones suite varían entre $7,000 y $16,000 pesos, dependiendo de los servicios incluidos
 * como jacuzzi, minibar y servicio a la habitación, así como el tipo de vista (ciudad, mar, montaña o jardín).
 * 
 * <p>Esta clase extiende la clase {@code Habitacion} y sobrescribe el método {@code calcularPrecioTotal}
 * para ajustar el precio según los servicios adicionales y la vista de la habitación.
 * 
 * @see Habitacion
 * 
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 * @version 2024/09/30
 */
public class HabitacionSuite extends Habitacion {
    
    // Indica si la habitación tiene servicio a la habitación las 24 horas
    private boolean servicioHabitacion;
    // Tipo de vista de la habitación (ciudad, mar, montaña o jardín)
    private String vista;

    /**
     * Constructor vacío de {@code HabitacionSuite}.
     * Utilizado para crear instancias sin inicializar atributos específicos.
     */
    public HabitacionSuite() {
    }

    /**
     * Constructor que inicializa los atributos relacionados con el servicio a la habitación y la vista.
     * 
     * @param servicioHabitacion indica si la habitación tiene servicio a la habitación (true si lo tiene, false si no)
     * @param vista el tipo de vista de la habitación (ciudad, mar, montaña o jardín)
     */
    public HabitacionSuite(boolean servicioHabitacion, String vista) {
        this.servicioHabitacion = servicioHabitacion;
        this.vista = vista;
    }

    /**
     * Constructor que inicializa todos los atributos de {@code HabitacionSuite}, incluidos los heredados de {@code Habitacion}.
     * 
     * @param numHabitacion el número de la habitación
     * @param tipoHabitacion el tipo de habitación (en este caso, suite)
     * @param disponibilidad la disponibilidad de la habitación
     * @param precio el precio base de la habitación
     * @param precioTotalTipoHabitacion el precio total de la habitación
     * @param servicioHabitacion indica si la habitación tiene servicio a la habitación (true si lo tiene, false si no)
     * @param vista el tipo de vista de la habitación (ciudad, mar, montaña o jardín)
     */
    public HabitacionSuite(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio, double precioTotalTipoHabitacion, 
                           boolean servicioHabitacion, String vista) {
        super(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalTipoHabitacion);
        this.servicioHabitacion = servicioHabitacion;
        this.vista = vista;
    }

    /**
     * Indica si la habitación tiene servicio a la habitación.
     * 
     * @return true si la habitación tiene servicio a la habitación, false si no
     */
    public boolean isServicioHabitacion() {
        return servicioHabitacion;
    }

    /**
     * Establece si la habitación tiene servicio a la habitación.
     * 
     * @param servicioHabitacion true si la habitación tiene servicio a la habitación, false si no
     */
    public void setServicioHabitacion(boolean servicioHabitacion) {
        this.servicioHabitacion = servicioHabitacion;
    }

    /**
     * Obtiene el tipo de vista de la habitación.
     * 
     * @return la vista de la habitación (ciudad, mar, montaña o jardín)
     */
    public String getVista() {
        return vista;
    }

    /**
     * Establece el tipo de vista de la habitación.
     * 
     * @param vista el tipo de vista (ciudad, mar, montaña o jardín)
     */
    public void setVista(String vista) {
        this.vista = vista;
    }

     /**
     * Calcula el precio total de la habitación suite basándose en los
     * servicios adicionales y el tipo de vista.
     * 
     * El precio se ajusta dependiendo de si la habitación incluye 
     * servicio a la habitación y el tipo de vista:
     * Si tiene servicio a la habitación, se incrementa el precio en $3,850.
     * Si la vista es a la ciudad, se incrementa en $1,799.
     * Si la vista es al mar, se incrementa en $3,590.
     * Si la vista es a las montañas, se incrementa en $2,720.
     * Si la vista es al jardín, se incrementa en $1,000.
     * 
     * 
     * @param precio el precio base de la habitación
     * @return el precio total de la habitación con los ajustes correspondientes
     */
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
    
     /**
     * Muestra una lista de habitaciones suite que tienen servicio de habitación.
     * @param habitaciones La lista de habitaciones suite a evaluar.
     * @return Una lista de habitaciones suite que tienen servicio de habitación.
     */
    public ArrayList<HabitacionSuite> mostrarHabitacionConServicio (ArrayList<HabitacionSuite>habitaciones){
        ArrayList <HabitacionSuite> habitacionesServi = new ArrayList<>();
        for (HabitacionSuite hbServ: habitaciones){
            if(hbServ.isServicioHabitacion()){
             habitacionesServi.add(hbServ);
            }    
        }
        return habitacionesServi;
              
    }
    
}
