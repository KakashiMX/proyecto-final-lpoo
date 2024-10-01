/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import datos.ControladorBD;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Clase que representa una reserva de hotel.
 * 
 * Esta clase contiene información sobre una reserva, incluyendo las fechas de entrada y salida, el valor, 
 * la forma de pago, el ID de la habitación y el ID del cliente. También proporciona métodos para 
 * ordenar reservas, calcular promedios y obtener estadísticas.
 *
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 * @version 2024/09/30
 */
public class Reserva {
    private int idReserva;
    private Date fechaEntrada;
    private Date fechaSalida;
    private double valor;
    private String formaPago;
    private int idHabitacion;
    private int idCliente;

    /**
     * Constructor por defecto.
     */
    public Reserva() {
    }

    /**
     * Constructor que inicializa una reserva con los datos proporcionados.
     *
     * @param fechaEntrada la fecha de entrada de la reserva.
     * @param fechaSalida la fecha de salida de la reserva.
     * @param valor el costo por noche de la reserva.
     * @param formaPago la forma de pago utilizada para la reserva.
     * @param idHabitacion el ID de la habitación reservada.
     * @param idCliente el ID del cliente que realiza la reserva.
     */
    public Reserva(Date fechaEntrada, Date fechaSalida, double valor, String formaPago, int idHabitacion, int idCliente) {
        this.fechaEntrada = fechaEntrada;
        this.fechaSalida = fechaSalida;
        this.valor = valor;
        this.formaPago = formaPago;
        this.idHabitacion = idHabitacion;
        this.idCliente = idCliente;
    }
    
    /**
     * Obtiene el ID de la reserva.
     *
     * @return el ID de la reserva.
     */
    public int getIdReserva() {
        return idReserva;
    }

    /**
     * Establece el ID de la reserva.
     *
     * @param idReserva el nuevo ID de la reserva.
     */
    public void setIdReserva(int idReserva) {
        this.idReserva = idReserva;
    }

    /**
     * Obtiene la fecha de entrada de la reserva.
     *
     * @return la fecha de entrada.
     */
    public Date getFechaEntrada() {
        return fechaEntrada;
    }

    /**
     * Establece la fecha de entrada de la reserva.
     *
     * @param fechaEntrada la nueva fecha de entrada.
     */
    public void setFechaEntrada(Date fechaEntrada) {
        this.fechaEntrada = fechaEntrada;
    }

    /**
     * Obtiene la fecha de salida de la reserva.
     *
     * @return la fecha de salida.
     */
    public Date getFechaSalida() {
        return fechaSalida;
    }

    /**
     * Establece la fecha de salida de la reserva.
     *
     * @param fechaSalida la nueva fecha de salida.
     */
    public void setFechaSalida(Date fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    /**
     * Obtiene el valor de la reserva.
     *
     * @return el valor de la reserva.
     */
    public double getValor() {
        return valor;
    }

    /**
     * Establece el valor de la reserva.
     *
     * @param valor el nuevo valor de la reserva.
     */
    public void setValor(double valor) {
        this.valor = valor;
    }

    /**
     * Obtiene la forma de pago utilizada en la reserva.
     *
     * @return la forma de pago.
     */
    public String getFormaPago() {
        return formaPago;
    }

    /**
     * Establece la forma de pago de la reserva.
     *
     * @param formaPago la nueva forma de pago.
     */
    public void setFormaPago(String formaPago) {
        this.formaPago = formaPago;
    }

    /**
     * Obtiene el ID de la habitación asociada a la reserva.
     *
     * @return el ID de la habitación.
     */
    public int getIdHabitacion() {
        return idHabitacion;
    }

    /**
     * Establece el ID de la habitación asociada a la reserva.
     *
     * @param idHabitacion el nuevo ID de la habitación.
     */
    public void setIdHabitacion(int idHabitacion) {
        this.idHabitacion = idHabitacion;
    }

    /**
     * Obtiene el ID del cliente que realizó la reserva.
     *
     * @return el ID del cliente.
     */
    public int getIdCliente() {
        return idCliente;
    }

    /**
     * Establece el ID del cliente que realizó la reserva.
     *
     * @param idCliente el nuevo ID del cliente.
     */
    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }
    
    /**
     * Ordena una lista de reservas por fecha de entrada usando el algoritmo 
     * QuickSort.
     *
     * @param reservas la lista de reservas a ordenar 
     * {@code ArrayList<Reserva>}.
     * @return Un {@code ArrayList<Reserva>} de reservas ordenada 
     * por fecha de entrada.
     */
    public ArrayList<Reserva> ordenarPorFechaEntrada(ArrayList<Reserva> reservas){
        reservas = quickSort(reservas, 0, reservas.size()-1);
        return reservas;
    }
    
    /**
     * Particiona el arreglo de reservas para el algoritmo QuickSort.
     *
     * @param reservas la lista de reservas a particionar 
     * {@code ArrayList<Reserva>}.
     * @param bajo el índice inferior.
     * @param alto el índice superior.
     * @return el índice de partición.
     */
    int particion(ArrayList<Reserva> reservas, int bajo, int alto) {
        // Elegir el último elemento como pivote
        Date pivote = reservas.get(alto).getFechaEntrada();
        int i = (bajo - 1);

        for (int j = bajo; j < alto; j++) {
            // Si la cadena actual es menor o igual al pivote (lexicográficamente)
            if (reservas.get(j).getFechaEntrada().compareTo(pivote) <= 0) {
                i++;
                // Intercambiamos elementos
                Reserva temp = reservas.get(i);
                reservas.set(i, reservas.get(j));
                reservas.set(j, temp);
            }
        }

        // Colocamos el pivote en su posición final
        Reserva temp = reservas.get(i + 1);
        reservas.set(i + 1, reservas.get(alto));
        reservas.set(alto, temp);

        return (i + 1);
    }
    
    /**
     * Ordena la lista de reservas usando el algoritmo QuickSort.
     *
     * @param reservas la lista de reservas a ordenar.
     * @param bajo el índice inferior.
     * @param alto el índice superior.
     * @return Un {@code ArrayList<Reserva>} de reservas ordenada.
     */
    private ArrayList<Reserva> quickSort(ArrayList<Reserva> reservas, int bajo, int alto) {
      if (bajo < alto) {
        // pi es el índice de partición, arreglo[pi] ahora está en su posición correcta
        int pi = particion(reservas, bajo, alto);

        // Ordenar recursivamente los subarreglos antes y después de la partición
        quickSort(reservas, bajo, pi - 1);
        quickSort(reservas, pi + 1, alto);
      }
      return reservas;
    }
    
    /**
     * Calcula el promedio de formas de pago en una lista de reservas.
     *
     * @param reservas la lista de reservas {@code ArrayList<Reserva>}.
     * @return un mensaje con los promedios de formas de pago.
     */
    public String promedioFormaDePago(ArrayList<Reserva> reservas){
        int contadorEfectivo = 0, contadorTarjetaCredito = 0, contadorTarjetaDebito = 0, contadorPaypal = 0;
        for( Reserva reserva: reservas){
            if( reserva.getFormaPago().equalsIgnoreCase("tarjeta de crédito") ){
                contadorTarjetaCredito++;
            }else if( reserva.getFormaPago().equalsIgnoreCase("efectivo")){
                contadorEfectivo++;
            }else if( reserva.getFormaPago().equalsIgnoreCase("tarjeta de débito")){
                contadorTarjetaDebito++;
            }else if( reserva.getFormaPago().equalsIgnoreCase("paypal")){
                contadorPaypal++;
            }
        }
        float promedioEfectivo = Math.round( ((float)  contadorEfectivo / reservas.size()) * 100);
        float promedioTarjetaCredito = Math.round( ((float) contadorTarjetaCredito / reservas.size()) * 100);
        float promedioTarjetaDebito = Math.round( ((float) contadorTarjetaDebito / reservas.size()) * 100);
        float promedioPaypal = Math.round( ((float)  contadorPaypal / reservas.size()) * 100);
        
        return "De tus " + reservas.size() + " reservas, el " + 
                promedioEfectivo + "% prefiere pagar en efectivo, un " + 
                promedioTarjetaCredito + "% prefiere el pago con tarjeta de crédito, otro " +
                promedioTarjetaDebito + "% paga con tarjeta de débito, mientras que el " +
                promedioPaypal + "% paga usando paypal";
    }
    
    /**
     * Calcula el promedio de días de estadía en el hotel.
     *
     * @param reservas la lista de reservas {@code ArrayList<Reserva>}.
     * @return un mensaje con el promedio de días de estadía.
     */
    public String promedioTiempoEstadia(ArrayList<Reserva> reservas){
        LocalDate fechaEntrada;
        LocalDate fechaSalida;
        int contadorDias = 0;
        for( Reserva reserva: reservas){
            fechaEntrada = reserva.getFechaEntrada().toLocalDate();
            fechaSalida = reserva.getFechaSalida().toLocalDate();
            contadorDias += ChronoUnit.DAYS.between(fechaEntrada, fechaSalida);
        }
        float promedioEstadia = contadorDias/reservas.size();
        
        return "Los huéspedes están en el hotel un promedio de " + promedioEstadia + " dias";
    }
    
    /**
     * Calcula el promedio de ganancias por día basado en las reservas.
     *
     * @param reservas la lista de reservas {@code ArrayList<Reserva>}.
     * @return un mensaje con el promedio de ganancias por día.
     */
    public String promedioGananciaPorDia(ArrayList<Reserva> reservas){
        LocalDate fechaEntrada = null;
        LocalDate fechaSalida = null;
        float precioTotalReservas=0;
        int contadorDias = 0;
        double costoTotalPorDia = 0;
        for( Reserva reserva: reservas){
            fechaEntrada = reserva.getFechaEntrada().toLocalDate();
            fechaSalida = reserva.getFechaSalida().toLocalDate();
            contadorDias += ChronoUnit.DAYS.between(fechaEntrada, fechaSalida);
            costoTotalPorDia = ChronoUnit.DAYS.between(fechaEntrada, fechaSalida) * reserva.getValor();
            precioTotalReservas += costoTotalPorDia;
        }
        double promedioPorDia = precioTotalReservas / contadorDias ;
        return "Tienes " + reservas.size() + " reservas, lo que equivale a $" + String.format("%.2f", precioTotalReservas) +
                " pesos netos, por lo tanto en un dia se obtienen $" + String.format("%.2f", promedioPorDia) + " pesos de ganancia";
    }
    
    /**
     * Obtiene un {@code Map<String,Integer>} con la cantidad de reservas 
     * por mes.
     *
     * @param reservas la lista de reservas {@code ArrayList<Reserva>}.
     * @return Un {@code Map<String,Integer>} con los meses y
     * la cantidad de reservas en cada uno.
     */
    public Map<String, Integer> obtenerReservasPorMes(List<Reserva> reservas) {
        Map<String, Integer> reservasPorMes = new HashMap<>();

        for (Reserva reserva : reservas) {
            LocalDate fechaEntrada = reserva.getFechaEntrada().toLocalDate();
            String mes = fechaEntrada.getMonth().toString();
            reservasPorMes.put(mes, reservasPorMes.getOrDefault(mes, 0) + 1);
        }
        return reservasPorMes;
    }
    
    /**
     * Obtiene un {@code Map<String,Double>} con el promedio de estadía 
     * por cliente.
     *
     * @param reservas la lista de reservas {@code ArrayList<Reserva>}.
     * @return un {@code Map<String,Double>} con el ID del cliente y 
     * su promedio de estadía.
     */
    public Map<Integer, Double> obtenerPromedioEstadiaPorCliente(List<Reserva> reservas) {
        Map<Integer, Long> totalDiasPorCliente = new HashMap<>();
        Map<Integer, Integer> reservasPorCliente = new HashMap<>();

        for (Reserva reserva : reservas) {
            int idCliente = reserva.getIdCliente();
            long diasEstadia = ChronoUnit.DAYS.between(reserva.getFechaEntrada().toLocalDate(), reserva.getFechaSalida().toLocalDate());

            totalDiasPorCliente.put(idCliente, totalDiasPorCliente.getOrDefault(idCliente, 0L) + diasEstadia);
            reservasPorCliente.put(idCliente, reservasPorCliente.getOrDefault(idCliente, 0) + 1);
        }

        // Calcular el promedio por cliente
        Map<Integer, Double> promedioEstadiaPorCliente = new HashMap<>();
        for (Map.Entry<Integer, Long> entry : totalDiasPorCliente.entrySet()) {
            int idCliente = entry.getKey();
            double promedio = (double) entry.getValue() / reservasPorCliente.get(idCliente);
            promedioEstadiaPorCliente.put(idCliente, promedio);
        }
        return promedioEstadiaPorCliente;
    }
    
    /**
     * Sobreescribe el metodo toString para la Clase Reserva.
     *
     * @return el estado de al Reserva.
     */
    @Override
    public String toString() {
        return "Reserva " + "ID: " + idReserva + "<br>Fecha de entrada: " + fechaEntrada + "<br>Fecha de salida: " + fechaSalida
                +"<br>Costo por noche: " + valor + "<br>Forma de pago: " + formaPago + "<br>ID habitacion: " + idHabitacion
                + "<br>ID cliente: " + idCliente;
    }
    
}
