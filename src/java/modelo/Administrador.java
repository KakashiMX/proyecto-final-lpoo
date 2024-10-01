/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.Timestamp;
import org.mindrot.jbcrypt.BCrypt;
/**
 *
 * @author kakashi
 */
public class Administrador {
    private int idAdministrador;
    private String administrador;
    private String contrasena;
    private Timestamp fechaCreacion;

    public Administrador() {
    }

    public Administrador(String usuario, String contrasena) {
        this.administrador = usuario;
        // hashea la contraseña del administrador para ser almacenada en la DB
        this.contrasena = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        this.fechaCreacion = new Timestamp(System.currentTimeMillis());
    }

    public int getIdAdministrador() {
        return idAdministrador;
    }

    public void setIdAdministrador(int idAdministrador) {
        this.idAdministrador = idAdministrador;
    }

    public String getAdministrador() {
        return administrador;
    }

    public void setAdministrador(String administrador) {
        this.administrador = administrador;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        // método para hashear la contraseña antes de guardarla en la DB
        String contrasenaHasheada = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        this.contrasena = contrasenaHasheada;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    // método que hashea la contrasena de un administrador
    public static String hashearContrasena(String contrasena){
        String contrasenaHasheada = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        return contrasenaHasheada;
    }
    
    
    @Override
    public String toString() {
        return "Usuario " + "ID: " + idAdministrador + ", Usuario: " + administrador + ", Contrasena: " + contrasena + ", Fecha de creacion: " + fechaCreacion;
    }
}
