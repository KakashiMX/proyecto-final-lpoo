/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 * La clase HabitacionFamiliar representa una habitación familiar en el 
 * sistema de reservas. Esta habitación puede tener sala, cocina y su 
 * capacidad máxima varía entre 3 y 6 personas.
 * 
 * <p>Los precios de la habitación familiar varían entre $4,000 y $7,000 pesos, 
 * dependiendo de los servicios adicionales incluidos.
 * 
 * <p>Esta clase extiende la clase Habitacion y sobrescribe el método 
 * calcularPrecioTotal para ajustar el precio según las características 
 * de la habitación.
 * 
 * @see Habitacion
 * 
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 * @version 2024/09/30
 * 
 */

// los precios de la habitación familiar varian entre $4,000 y $7,000 pesos
public class HabitacionFamiliar extends Habitacion{
    // de tres a 6 personas
    private int capacidadMaxima;
    private boolean tieneSala;
    private boolean tieneCocina;

     /**
     * Constructor vacío de HabitacionFamiliar utilizado para crear
     * instancias sin inicializar atributos específicos.
     */
    public HabitacionFamiliar() {
    }

    /**
     * Constructor que inicializa los atributos relacionados con la 
     * capacidad, sala y cocina de la habitación familiar.
     * 
     * @param capacidadMaxima la capacidad máxima de personas que puede 
     * alojar la habitación
     * @param tieneSala indica si la habitación tiene sala (true si la tiene, 
     * false si no)
     * @param tieneCocina indica si la habitación tiene cocina (true si la 
     * tiene, false si no)
     */
    public HabitacionFamiliar(int capacidadMaxima,boolean tieneSala, boolean tieneCocina) {
        this.capacidadMaxima = capacidadMaxima;
        this.tieneSala = tieneSala;
        this.tieneCocina = tieneCocina;
    }

    /**
     * Constructor que inicializa todos los atributos de HabitacionFamiliar}, 
     * incluidos los heredados de Habitacion.
     * 
     * @param numHabitacion el número de la habitación
     * @param tipoHabitacion el tipo de habitación
     * @param disponibilidad la disponibilidad de la habitación
     * @param precio el precio base de la habitación
     * @param precioTotalTipoHabitacion el precio total de la habitación
     * @param capacidadMaxima la capacidad máxima de personas que puede 
     * alojar la habitación
     * @param tieneSala indica si la habitación tiene sala (true si la tiene, 
     * false si no)
     * @param tieneCocina indica si la habitación tiene cocina (true si la 
     * tiene, false si no)
     */
    public HabitacionFamiliar(String numHabitacion, String tipoHabitacion, boolean disponibilidad, double precio, double precioTotalTipoHabitacion, int capacidadMaxima,
                                boolean tieneSala, boolean tieneCocina) {
        super(numHabitacion, tipoHabitacion, disponibilidad, precio, precioTotalTipoHabitacion);
        this.capacidadMaxima = capacidadMaxima;
        this.tieneSala = tieneSala;
        this.tieneCocina = tieneCocina;
    }

    /**
     * Obtiene la capacidad máxima de la habitación.
     * 
     * @return la capacidad máxima de la habitación
     */
    public int getCapacidadMaxima() {
        return capacidadMaxima;
    }

    /**
     * Establece la capacidad máxima de la habitación.
     * 
     * @param capacidadMaxima la nueva capacidad máxima de la habitación
     */
    public void setCapacidadMaxima(int capacidadMaxima) {
        this.capacidadMaxima = capacidadMaxima;
    }

    /**
     * Indica si la habitación tiene sala.
     * 
     * @return true si la habitación tiene sala, false si no
     */
    public boolean isTieneSala() {
        return tieneSala;
    }

    /**
     * Establece si la habitación tiene sala.
     * 
     * @param tieneSala true si la habitación tiene sala, false si no
     */
    public void setTieneSala(boolean tieneSala) {
        this.tieneSala = tieneSala;
    }

    /**
     * Indica si la habitación tiene cocina.
     * 
     * @return true si la habitación tiene cocina, false si no
     */
    public boolean isTieneCocina() {
        return tieneCocina;
    }

    /**
     * Establece si la habitación tiene cocina.
     * 
     * @param tieneCocina true si la habitación tiene cocina, false si no
     */
    public void setTieneCocina(boolean tieneCocina) {
        this.tieneCocina = tieneCocina;
    }

    /**
     * Calcula el precio total de la habitación familiar basándose en los 
     * servicios adicionales.
     * El precio se ajusta dependiendo de si la habitación tiene sala y/o cocina.
     * 
     * @param precio el precio base de la habitación
     * @return el precio total ajustado de la habitación
     */
    @Override
    public double calcularPrecioTotal(double precio) {
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
