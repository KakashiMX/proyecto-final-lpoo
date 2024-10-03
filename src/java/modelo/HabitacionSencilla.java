/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 * La clase HabitacionSencilla representa una habitación sencilla en el
 * sistema de reservas. Los precios de la habitación sencilla varían entre 
 * $800 y $1,500 pesos.
 * 
 * <p>Esta clase extiende la clase Habitacion y sobrescribe el método 
 * calcularPrecioTotal para devolver el precio base sin modificaciones, 
 * ya que las habitaciones sencillas no incluyen servicios adicionales.
 * 
 * <p>Utilizada cuando se desea representar una habitación de tipo sencilla, 
 * sin sala ni cocina.
 * 
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 * @version 2024/09/30
 * @see Habitacion
 */
public class HabitacionSencilla extends Habitacion {

    /**
     * Constructor vacío de HabitacionSencilla.
     * Utilizado para crear una instancia sin inicializar atributos específicos.
     */
    public HabitacionSencilla() {
    }

    /**
     * Constructor que inicializa los atributos heredados de Habitacion.
     * 
     * @param numHabitacion el número de la habitación
     * @param tipoHabitacion el tipo de la habitación (en este caso, Sencilla)
     * @param disponibilidad la disponibilidad de la habitación
     * @param precio el precio base de la habitación
     * @param precioTotalTipoHabitacion el precio total de la habitación 
     * (en este caso, igual al precio base)
     */
    public HabitacionSencilla(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio, double precioTotalTipoHabitacion) {
        super(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalTipoHabitacion);
    }

    /**
     * Calcula el precio total de la habitación sencilla.
     * En este caso, simplemente devuelve el precio base sin realizar ajustes, 
     * ya que no hay servicios adicionales en las habitaciones sencillas.
     * 
     * @param precio el precio base de la habitación
     * @return el precio total de la habitación, que es igual al precio base
     */
    @Override
    public double calcularPrecioTotal(double precio) {
        return precio;
    }   
}
