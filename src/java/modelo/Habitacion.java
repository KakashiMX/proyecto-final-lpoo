/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.util.ArrayList;

/**
 *
 * @author kakashi
 */
public abstract class Habitacion {
    private int idHabitacion;
    private String numHabitacion;
    private String tipoHabitacion;
    private boolean disponibilidad;
    private double precio;
    private double precioTotalTipoHabitacion;

    public Habitacion() {
    }

    public Habitacion(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio, double precioTotalTipoHabitacion) {
        this.numHabitacion = numHabitacion;
        this.tipoHabitacion = tipoHabitacion;
        this.disponibilidad = disponibilidad;
        this.precio = precio;
        this.precioTotalTipoHabitacion = precioTotalTipoHabitacion;
    }

    public int getIdHabitacion() {
        return idHabitacion;
    }

    public void setIdHabitacion(int idHabitacion) {
        this.idHabitacion = idHabitacion;
    }

    public String getNumHabitacion() {
        return numHabitacion;
    }

    public void setNumHabitacion(String numHabitacion) {
        this.numHabitacion = numHabitacion;
    }

    public String getTipoHabitacion() {
        return tipoHabitacion;
    }

    public void setTipoHabitacion(String tipoHabitacion) {
        this.tipoHabitacion = tipoHabitacion;
    }

    public boolean isDisponibilidad() {
        return disponibilidad;
    }

    public void setDisponibilidad(boolean disponibilidad) {
        this.disponibilidad = disponibilidad;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public double getPrecioTotalTipoHabitacion() {
        return precioTotalTipoHabitacion;
    }

    public void setPrecioTotalTipoHabitacion(double precioTotalTipoHabitacion) {
        this.precioTotalTipoHabitacion = precioTotalTipoHabitacion;
    }
    
    // método que calcula el precio total de la habitación dependiendo de los servicios incluidos
    public abstract double calcularPrecioTotal(double precio);
    
    public Habitacion bucarHabitacionporID(ArrayList<Habitacion>habitaciones,int id){
        for(Habitacion habitacion : habitaciones){
            if(habitacion.getIdHabitacion()==id){
                return habitacion; // Si el id coincide, devolver la habitación
            }
        }
        return null; // Si no se encuentra, devolver null
    }
    
   @Override
    public String toString() {
        return "Habitacion" + " ID: " + idHabitacion + ", Numero de habitacion: " + numHabitacion + " " + 
                ", Tipo de habitacion: " + tipoHabitacion + ", Disponibilidad: " + disponibilidad 
                + ", Precio: " + precio;
    } 
    
}
