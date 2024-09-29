/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.Date;
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

    public Reserva(Date fechaEntrada, Date fechaSalida, double valor, String formaPago, int idHabitacion) {
        this.fechaEntrada = fechaEntrada;
        this.fechaSalida = fechaSalida;
        this.valor = valor;
        this.formaPago = formaPago;
        this.idHabitacion = idHabitacion;
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

    @Override
    public String toString() {
        return "Reserva " + "ID : " + idReserva + ", Fecha de entrada: " + fechaEntrada + ", Fecha de salida: " + fechaSalida
                +", Costo de la habitacion: " + valor + ", Formato de pago: " + formaPago + "ID habitacion: " + idHabitacion
                + ", ID cliente: " + idCliente;
    }
    
}
