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
public class Usuario {
    private int idUsuario;
    private String usuario;
    private String contrasena;
    private String rol;
    private Timestamp fechaCreacion;

    public Usuario() {
    }

    public Usuario(String usuario, String contrasena, String rol) {
        this.usuario = usuario;
        // hashea la contraseña del usuario para ser almacenada en la DB
        this.contrasena = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        this.rol = rol;
        this.fechaCreacion = new Timestamp(System.currentTimeMillis());
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        // método para hashear la contraseña antes de guardarla en la DB
        String contrasenaHasheada = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        this.contrasena = contrasenaHasheada;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    // método que hashea la contrasena de un usuario
    public static String hashearContrasena(String contrasena){
        String contrasenaHasheada = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        return contrasenaHasheada;
    }
    
    
    @Override
    public String toString() {
        return "Usuario " + "ID: " + idUsuario + ", Usuario: " + usuario + ", Contrasena: " + contrasena + ", Rol: " + rol + ", Fecha de creacion: " + fechaCreacion;
    }
}
