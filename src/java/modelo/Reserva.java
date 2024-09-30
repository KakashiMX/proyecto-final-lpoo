/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import datos.ControladorBD;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
/**
 *
 * @author kakashi
 */
public class Reserva {
    private int idReserva;
    private Date fechaEntrada;
    private Date fechaSalida;
    private double valor;
    private String formaPago;
    private int idHabitacion;
    private int idCliente;

    public Reserva() {
    }

    public Reserva(Date fechaEntrada, Date fechaSalida, double valor, String formaPago, int idHabitacion, int idCliente) {
        this.fechaEntrada = fechaEntrada;
        this.fechaSalida = fechaSalida;
        this.valor = valor;
        this.formaPago = formaPago;
        this.idHabitacion = idHabitacion;
        this.idCliente = idCliente;
    }

    public int getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(int idReserva) {
        this.idReserva = idReserva;
    }

    public Date getFechaEntrada() {
        return fechaEntrada;
    }

    public void setFechaEntrada(Date fechaEntrada) {
        this.fechaEntrada = fechaEntrada;
    }

    public Date getFechaSalida() {
        return fechaSalida;
    }

    public void setFechaSalida(Date fechaSalida) {
        this.fechaSalida = fechaSalida;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public String getFormaPago() {
        return formaPago;
    }

    public void setFormaPago(String formaPago) {
        this.formaPago = formaPago;
    }

    public int getIdHabitacion() {
        return idHabitacion;
    }

    public void setIdHabitacion(int idHabitacion) {
        this.idHabitacion = idHabitacion;
    }
    
    public int getIdCliente() {
        return idHabitacion;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }
    
    public String buscarPorId( ArrayList<Reserva> reservas, int idABuscar){
        // Buscar la matrícula usando búsqueda binaria
        int encontrado = busquedaBinaria(reservas, idABuscar);
        
        if (encontrado != -1) {
            return reservas.get(encontrado).toString();
        } else {
            return "No se encontro un registro con ese ID";
        }
    }
    
    private int busquedaBinaria(ArrayList<Reserva> reservas, int idABuscar) {
        int inicio = 0;
        int fin = reservas.size() - 1;

        while (inicio <= fin) {
            int medio = inicio + (fin - inicio) / 2;

            // Verificar si la matrícula está en el medio
            if (reservas.get(medio).getIdReserva() == idABuscar) {
                return medio;
            }

            // Si la matrícula es mayor, ignorar la mitad izquierda
            if (reservas.get(medio).getIdReserva() < idABuscar) {
                inicio = medio + 1;
            }
            // Si la matrícula es menor, ignorar la mitad derecha
            else {
                fin = medio - 1;
            }
        }

        // Si la reserva no está presente en el arreglo
        return -1;
    }
    
    public ArrayList<Reserva> ordenarPorFechaEntrada(ArrayList<Reserva> reservas){
        reservas = quickSort(reservas, 0, reservas.size()-1);
        return reservas;
    }
    
    // Función para particionar el arreglo de cadenas
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
    
    // Función para ordenar el arreglo usando QuickSort
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
    
    public String promedioFormaDePago(ArrayList<Reserva> reservas){
        int contadorTarjeta = 0, contadorEfectivo = 0;
        for( Reserva reserva: reservas){
            if( reserva.getFormaPago().equalsIgnoreCase("tarjeta") ){
                contadorTarjeta++;
            }else if( reserva.getFormaPago().equalsIgnoreCase("efectivo")){
                contadorEfectivo++;
            }
        }
        float promedioTarjeta = ((float) contadorTarjeta / reservas.size()) * 100;
        float promedioEfectivo = ((float)  contadorEfectivo / reservas.size()) * 100;
        return "De tus " + reservas.size() + " reservas, el " + 
                promedioTarjeta + "% prefiere pagar con tarjeta y el otro " + 
                promedioEfectivo + "% prefiere el pago en efectivo";
    }
    
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
        
        return "Los huespedes estan en nuestro hotel en un promedio de " + promedioEstadia + " dias";
    }
    
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
                " pesos de ganancias, por lo tanto en un dia se obtienen $" + String.format("%.2f", promedioPorDia) + " pesos de ganancia";
    }

    @Override
    public String toString() {
        return "Reserva " + "ID: " + idReserva + "<br>Fecha de entrada: " + fechaEntrada + "<br>Fecha de salida: " + fechaSalida
                +"<br>Costo por noche: " + valor + "<br>Forma de pago: " + formaPago + "<br>ID habitacion: " + idHabitacion
                + "<br>ID cliente: " + idCliente;
    }
    
}
