/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author kakashi
 */

// los precios de la habitación familiar varian entre $4,000 y $7,000 pesos
public class HabitacionFamiliar extends Habitacion{
    // de tres a 6 personas
    private int capacidadMaxima;
    private boolean tieneSala;
    private boolean tieneCocina;

    public HabitacionFamiliar() {
    }

    public HabitacionFamiliar(int capacidadMaxima,boolean tieneSala, boolean tieneCocina) {
        this.capacidadMaxima = capacidadMaxima;
        this.tieneSala = tieneSala;
        this.tieneCocina = tieneCocina;
    }

    public HabitacionFamiliar(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio, double precioTotalTipoHabitacion, int capacidadMaxima,
                                boolean tieneSala, boolean tieneCocina) {
        super(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalTipoHabitacion);
        this.capacidadMaxima = capacidadMaxima;
        this.tieneSala = tieneSala;
        this.tieneCocina = tieneCocina;
    }

    public int getCapacidadMaxima() {
        return capacidadMaxima;
    }

    public void setCapacidadMaxima(int capacidadMaxima) {
        this.capacidadMaxima = capacidadMaxima;
    }

    public boolean isTieneSala() {
        return tieneSala;
    }

    public void setTieneSala(boolean tieneSala) {
        this.tieneSala = tieneSala;
    }

    public boolean isTieneCocina() {
        return tieneCocina;
    }

    public void setTieneCocina(boolean tieneCocina) {
        this.tieneCocina = tieneCocina;
    }

    @Override
    public double calcularPrecioTotal( double precio) {
        double precioBase = precio;

        // Ajuste de precio por tener sala
        if (tieneSala) {
            precioBase += 1250;
        }

        // Ajuste de precio por tener cocina
        if (tieneCocina) {
            precioBase += 1250;
        }
        return precioBase;
    }
    
    
}
