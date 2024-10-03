/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
 * @see Habitacion
 * 
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 * @version 2024/09/30
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
    
    /**
      * Obtiene el tipo de habitación más solicitada de una lista de habitaciones.
      * @param habitaciones La lista de habitaciones a evaluar.
      * @return El tipo de habitación más solicitada: "sencilla", "familiar", "suit" o "empate" si hay un empate.
      */

    public String obtenerHabitacionMasSolicitada(ArrayList<Habitacion> habitaciones) {
        int contaSencilla = 0, contaFamiliar = 0, contaSuite = 0;

        // Contamos las habitaciones no disponibles (solicitadas)
        for (Habitacion habitacion : habitaciones) {
            if (!habitacion.isDisponibilidad()) { // Si la habitación no está disponible
                if (habitacion.getTipoHabitacion().equalsIgnoreCase("sencilla")) {
                    contaSencilla++;
                } else if (habitacion.getTipoHabitacion().equalsIgnoreCase("familiar")) {
                    contaFamiliar++;
                } else if (habitacion.getTipoHabitacion().equalsIgnoreCase("suite")) {
                    contaSuite++;
                }
            }
        }

        // Evaluamos cuál tipo de habitación tiene más solicitudes
        if (contaSencilla > contaFamiliar && contaSencilla > contaSuite) {
            return "Sencilla";
        } else if (contaFamiliar > contaSencilla && contaFamiliar > contaSuite) {
            return "Familiar";
        } else if (contaSuite > contaSencilla && contaSuite > contaFamiliar) {
            return "Suite";
        } else if (contaSencilla == contaFamiliar && contaSencilla > contaSuite) {
            return "Sencilla y Familiar";
        } else if (contaSencilla == contaSuite && contaSencilla > contaFamiliar) {
            return "Sencilla y Suite";
        } else if (contaFamiliar == contaSuite && contaFamiliar > contaSencilla) {
            return "Familiar y Suite";
        } else {
            return "Sencilla, Familiar y Suite"; // Cuando todas son iguales
        }
    }

     /**
      * Muestra una lista de habitaciones disponibles.
      * @param habitaciones La lista de habitaciones a evaluar.
      * @return  Una lista de habitaciones disponibles.
      */

    public ArrayList<Habitacion> mostrarHabitacionDisponible (ArrayList<Habitacion>habitaciones){
        ArrayList <Habitacion> habitacionesDisponibles = new ArrayList<>();
        for (Habitacion hb: habitaciones){
            if(hb.isDisponibilidad()){
             habitacionesDisponibles.add(hb);  
            }    
        }
        return habitacionesDisponibles;
              
    }
    /**
     * Muestra una lista de habitaciones no disponibles.
     * @param habitaciones La lista de habitaciones a evaluar.
     * @return Una lista de habitaciones no disponibles.
     */
    
    public ArrayList<Habitacion> mostrarHabitacionNoDisponible (ArrayList<Habitacion>habitaciones){
        ArrayList <Habitacion> habitacionesNoDisponibles = new ArrayList<>();
        for (Habitacion hbt: habitaciones){
            if(!hbt.isDisponibilidad()){
             habitacionesNoDisponibles.add(hbt);   
            } 
        }
        return habitacionesNoDisponibles;
    }
}
