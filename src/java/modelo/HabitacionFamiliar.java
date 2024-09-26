/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author kakashi
 */
// lo mismo, estos campos no estan en la DB, faltan crearlos
public class HabitacionFamiliar extends Habitacion{
    private int numCamas = 4;
    private boolean admiteVisitas = true;

    public HabitacionFamiliar() {
    }

    public HabitacionFamiliar(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio) {
        super(numHabitacion, tipoHabitacion, disponibilidad, precio);
    }

    public int getNumCamas() {
        return numCamas;
    }

    public void setNumCamas(int numCamas) {
        this.numCamas = numCamas;
    }

    public boolean isAdminteVisitas() {
        return admiteVisitas;
    }

    public void setAdminteVisitas(boolean adminteVisitas) {
        this.admiteVisitas = adminteVisitas;
    }
    
    
}
