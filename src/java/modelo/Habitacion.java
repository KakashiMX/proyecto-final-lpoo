/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author kakashi
 */
public class Habitacion {
    private int idHabitacion;
    private String numHabitacion;
    private String tipoHabitacion;
    private boolean disponibilidad;
    private double precio;

    public Habitacion() {
    }

    public Habitacion(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio) {
        this.numHabitacion = numHabitacion;
        this.tipoHabitacion = tipoHabitacion;
        this.disponibilidad = disponibilidad;
        this.precio = precio;
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
    
    
   @Override
    public String toString() {
        return "Habitacion" + " ID: " + idHabitacion + ", Numero de habitacion: " + numHabitacion + " " + 
                ", Tipo de habitacion: " + tipoHabitacion + ", Disponibilidad: " + disponibilidad 
                + ", Precio: " + precio;
    } 
    
}
