/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author kakashi
 */
public class Huesped {

    private int id;
    private String nombre;
    private String apellido;
    private LocalDate fechaNacimiento;
    private String nacionalidad;
    private String telefono;

    public Huesped() {
    }

    public Huesped(String nombre, String apellido, LocalDate fechaNacimiento, String nacionalidad, String telefono) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.nacionalidad = nacionalidad;
        this.telefono = telefono;
    }

    public Huesped(Integer id, String nombre, String apellido, LocalDate fechaNacimiento, String nacionalidad,
            String telefono) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.nacionalidad = nacionalidad;
        this.telefono = telefono;
    }
    
    public Huesped(String nombre, String apellido, LocalDate fechaNacimiento, String nacionalidad,
            String telefono,Integer id) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.nacionalidad = nacionalidad;
        this.telefono = telefono;
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
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

    
    public Map<String, Integer> contarHuespedesPorNacionalidad(ArrayList<Huesped> huespedes) {
        Map<String, Integer> nacionalidadesCount = new HashMap<>();

        for (Huesped huesped : huespedes) {
            String nacionalidad = huesped.getNacionalidad();
            
            // Si ya existe la nacionalidad en el mapa, se incrementa el contador
            nacionalidadesCount.put(nacionalidad, nacionalidadesCount.getOrDefault(nacionalidad, 0) + 1);
        }

        return nacionalidadesCount;
    }
    
    public Huesped buscarHuespedPorId(ArrayList<Huesped> huespedes, int id) {
    for (Huesped huesped : huespedes) {
        if (huesped.getId() == id) {
            return huesped; // Si el id coincide, devolver el huésped
        }
    }
    return null; // Si no se encuentra, devolver null
}
    
    @Override
    public String toString() {
        return "Huesped " + "ID: " + id + ", Nombre completo: " + nombre + " " + apellido + ", Fecha de nacimiento: " + fechaNacimiento
                + ", Nacionalidad: " + nacionalidad + ", Telefono: " + telefono;
    }

}
