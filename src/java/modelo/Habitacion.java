/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.util.ArrayList;

/**
 * La clase abstracta Habitacion que representa una habitación en un 
 * sistema de reservas.Incluye información básica como el número de 
 * habitación, tipo, disponibilidad y precio.
 * 
 * <p>Esta clase también incluye un método abstracto para calcular el 
 * precio total de la habitación basado en los servicios adicionales.
 * 
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 * @version 2024/09/30
 */
public abstract class Habitacion {
    private int idHabitacion;
    private String numHabitacion;
    private String tipoHabitacion;
    private boolean disponibilidad;
    private double precio;
    private double precioTotalTipoHabitacion;

    /**
     * Constructor vacío de la clase utilizado para crear 
     * instancias sin inicializar los atributos.
     */
    public Habitacion() {
    }

    /**
     * Constructor de la clase Habitacion que inicializa todos los 
     * atributos excepto el ID.
     * 
     * @param numHabitacion el número de la habitación
     * @param tipoHabitacion el tipo de habitación (ej. Sencilla, Doble, Suite)
     * @param disponibilidad la disponibilidad de la habitación 
     * (true si está disponible, false si no)
     * @param precio el precio base de la habitación
     * @param precioTotalTipoHabitacion el precio total calculado según el 
     * tipo de habitación y servicios
     */
    public Habitacion(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio, double precioTotalTipoHabitacion) {
        this.numHabitacion = numHabitacion;
        this.tipoHabitacion = tipoHabitacion;
        this.disponibilidad = disponibilidad;
        this.precio = precio;
        this.precioTotalTipoHabitacion = precioTotalTipoHabitacion;
    }

    /**
     * Obtiene el ID de la habitación.
     * 
     * @return el ID de la habitación
     */
    public int getIdHabitacion() {
        return idHabitacion;
    }

   
    /**
     * Establece el ID de la habitación.
     * 
     * @param idHabitacion el nuevo ID de la habitación
     */
    public void setIdHabitacion(int idHabitacion) {
        this.idHabitacion = idHabitacion;
    }

    /**
     * Obtiene el número de la habitación.
     * 
     * @return el número de la habitación
     */
    public String getNumHabitacion() {
        return numHabitacion;
    }

    /**
     * Establece el número de la habitación.
     * 
     * @param numHabitacion el nuevo número de la habitación
     */
    public void setNumHabitacion(String numHabitacion) {
        this.numHabitacion = numHabitacion;
    }

    /**
     * Obtiene el tipo de la habitación.
     * 
     * @return el tipo de la habitación
     */
    public String getTipoHabitacion() {
        return tipoHabitacion;
    }

    /**
     * Establece el tipo de la habitación.
     * 
     * @param tipoHabitacion el nuevo tipo de la habitación
     */
    public void setTipoHabitacion(String tipoHabitacion) {
        this.tipoHabitacion = tipoHabitacion;
    }

    /**
     * Obtiene la disponibilidad de la habitación.
     * 
     * @return true si la habitación está disponible, false si no
     */
    public boolean isDisponibilidad() {
        return disponibilidad;
    }

    /**
     * Establece la disponibilidad de la habitación.
     * 
     * @param disponibilidad true si la habitación está disponible, false si no
     */
    public void setDisponibilidad(boolean disponibilidad) {
        this.disponibilidad = disponibilidad;
    }

    /**
     * Obtiene el precio base de la habitación.
     * 
     * @return el precio de la habitación
     */
    public double getPrecio() {
        return precio;
    }

    /**
     * Establece el precio de la habitación.
     * 
     * @param precio el nuevo precio de la habitación
     */
    public void setPrecio(double precio) {
        this.precio = precio;
    }

    /**
     * Obtiene el precio total calculado para la habitación en función 
     * de los servicios adicionales.
     * 
     * @return el precio total de la habitación
     */
    public double getPrecioTotalTipoHabitacion() {
        return precioTotalTipoHabitacion;
    }

    /**
     * Establece el precio total calculado para la habitación.
     * 
     * @param precioTotalTipoHabitacion el nuevo precio total de la habitación
     */
    public void setPrecioTotalTipoHabitacion(double precioTotalTipoHabitacion) {
        this.precioTotalTipoHabitacion = precioTotalTipoHabitacion;
    }
    
    /**
     * Firma de un método abstracto para calcular el precio total de la 
     * habitación.
     * 
     * @param precio el precio base de la habitación
     * @return el precio total calculado
     */
    public abstract double calcularPrecioTotal(double precio);
    
    /**
     * Busca una habitación por su ID dentro de una lista de habitaciones.
     * 
     * @param habitaciones un {@code ArrayList<Habitacion>} de habitaciones 
     * a buscar
     * @param id el ID de la habitación a buscar
     * @return la habitación con el ID especificado, o null si no se encuentra
     */
    public Habitacion bucarHabitacionporID(ArrayList<Habitacion>habitaciones,int id){
        for(Habitacion habitacion : habitaciones){
            if(habitacion.getIdHabitacion()==id){
                return habitacion; // Si el id coincide, devolver la habitación
            }
        }
        return null; // Si no se encuentra, devolver null
    }
    
    /**
     * Sobreescribe el metodo toString para la Clase Habitación.
     * @return el estado de la Habitación.
     */
   @Override
    public String toString() {
        return "Habitacion" + " ID: " + idHabitacion + ", Numero de habitacion: " + numHabitacion + " " + 
                ", Tipo de habitacion: " + tipoHabitacion + ", Disponibilidad: " + disponibilidad 
                + ", Precio: " + precio;
    } 
    
}
