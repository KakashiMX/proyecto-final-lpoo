/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author kakashi
 */

// los precios de habitacion sencilla varian entre $800 y $1,500 pesos
public class HabitacionSencilla extends Habitacion{
    
    public HabitacionSencilla() {
    }

    public HabitacionSencilla(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio, double precioTotalTipoHabitacion) {
        super(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalTipoHabitacion);
    }

    @Override
    public double calcularPrecioTotal(double precio) {
        return precio;
    }   
}
