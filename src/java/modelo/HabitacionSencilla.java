/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author kakashi
 */
// cómo el proyecto pide de a fuerza aplicar herencia, se me ocurrio aplicarla a las habitaciones
    // Sólo que en la DB faltaria agregar estos campos
public class HabitacionSencilla extends Habitacion{
    private String tipoCama = "individual";    

    public HabitacionSencilla() {
    }

    public HabitacionSencilla(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio) {
        super(numHabitacion, tipoHabitacion, disponibilidad, precio);
    }

    public String getTipoCama() {
        return tipoCama;
    }

    public void setTipoCama(String tipoCama) {
        this.tipoCama = tipoCama;
    }
    
}
