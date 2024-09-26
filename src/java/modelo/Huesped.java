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
public class Huesped {
    private int idHuesped;
    private String nombre;
    private String apellido;
    private Date fechaNacimiento;
    private String nacionalidad;
    private String telefono;
    private Reserva reserva;
    private int idReserva;

    public Huesped() {
    }

    public Huesped(String nombre, String apellido, Date fechaNacimiento, String nacionalidad, String telefono, Reserva reserva) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.nacionalidad = nacionalidad;
        this.telefono = telefono;
        this.reserva = reserva;
    }

    public int getIdHuesped() {
        return idHuesped;
    }

    public void setIdHuesped(int idHuesped) {
        this.idHuesped = idHuesped;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public Date getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(Date fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getNacionalidad() {
        return nacionalidad;
    }

    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Reserva getReserva() {
        return reserva;
    }

    public void setReserva(Reserva reserva) {
        this.reserva = reserva;
    }

    public int getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(int idReserva) {
        this.idReserva = idReserva;
    }

    
   
    
    @Override
    public String toString() {
        return "Huesped " + "ID: " + idHuesped + ", Nombre completo: " + nombre + " " + apellido + ", Fecha de nacimiento: " + fechaNacimiento
                + ", Nacionalidad: " + nacionalidad + ", Telefono: " + telefono + ", ID de reserva: " + idReserva;
    }
    
}
