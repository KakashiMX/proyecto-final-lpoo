/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.Timestamp;
import org.mindrot.jbcrypt.BCrypt;
/**
 * La clase Administrador representa un administrador del sistema con sus credenciales
 * y fecha de creación. Proporciona métodos para gestionar las credenciales, incluidas
 * funcionalidades para hashear la contraseña antes de almacenarla.
 * 
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 * @version 2024/09/30
 */
public class Administrador {
    private int idAdministrador;
    private String administrador;
    private String contrasena;
    private Timestamp fechaCreacion;

    /**
     * Constructor por defecto. Crea una instancia vacía de la clase Administrador.
     */
    public Administrador() {
    }

    /**
     * Constructor con parámetros que crea un administrador con un nombre de usuario
     * y una contraseña. La contraseña es automáticamente hasheada para mayor seguridad.
     * 
     * @param usuario Nombre de usuario del administrador.
     * @param contrasena Contraseña del administrador, que será hasheada antes de almacenarse.
     */
    public Administrador(String usuario, String contrasena) {
        this.administrador = usuario;
        // hashea la contraseña del administrador para ser almacenada en la DB
        this.contrasena = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        this.fechaCreacion = new Timestamp(System.currentTimeMillis());
    }

    /**
     * Obtiene el ID del administrador.
     * 
     * @return ID del administrador.
     */
    public int getIdAdministrador() {
        return idAdministrador;
    }

    /**
     * Establece el ID del administrador.
     * 
     * @param idAdministrador El nuevo ID del administrador.
     */
    public void setIdAdministrador(int idAdministrador) {
        this.idAdministrador = idAdministrador;
    }

    /**
     * Obtiene el nombre de usuario del administrador.
     * 
     * @return Nombre de usuario del administrador.
     */
    public String getAdministrador() {
        return administrador;
    }

    /**
     * Establece el nombre de usuario del administrador.
     * 
     * @param administrador El nuevo nombre de usuario del administrador.
     */
    public void setAdministrador(String administrador) {
        this.administrador = administrador;
    }

    /**
     * Obtiene la contraseña hasheada del administrador.
     * 
     * @return Contraseña hasheada del administrador.
     */
    public String getContrasena() {
        return contrasena;
    }

    /**
     * Establece la contraseña del administrador. La contraseña se hashea automáticamente
     * antes de almacenarse para mayor seguridad.
     * 
     * @param contrasena La nueva contraseña del administrador.
     */
    public void setContrasena(String contrasena) {
        // método para hashear la contraseña antes de guardarla en la DB
        String contrasenaHasheada = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        this.contrasena = contrasenaHasheada;
    }

    /**
     * Obtiene la fecha de creación del administrador.
     * 
     * @return La fecha de creación del administrador.
     */
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    /**
     * Establece la fecha de creación del administrador.
     * 
     * @param fechaCreacion La nueva fecha de creación.
     */
    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    /**
     * Hashea una contraseña utilizando la biblioteca BCrypt.
     * 
     * @param contrasena La contraseña que será hasheada.
     * @return La contraseña hasheada.
     * @see <a href="https://github.com/jeremyh/jBCrypt">jBCrypt GitHub</a>
     */
    public static String hashearContrasena(String contrasena){
        String contrasenaHasheada = BCrypt.hashpw(contrasena, BCrypt.gensalt());
        return contrasenaHasheada;
    }
    
    /**
     * Sobreescribe el metodo toString para la Clase Administrador.
     * 
     * @return el estado del Administrador.
     */
    @Override
    public String toString() {
        return "Usuario " + "ID: " + idAdministrador + ", Usuario: " + administrador 
                + ", Contrasena: " + contrasena + ", Fecha de creacion: " + fechaCreacion;
    }
}
