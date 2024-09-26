/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package datos;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Date;
import java.util.ArrayList;
import modelo.Habitacion;
import modelo.Reserva;
import modelo.Usuario;
import org.mindrot.jbcrypt.BCrypt;
/**
 *
 * @author kakashi
 */
public class ControladorBD {
    private static final String USUARIO="root";
    private static final String PASSWORD="Protegee7-Deceit-Harmful";
    private static final String URL="jdbc:mysql://localhost:3306/";
    private static final String BD="hotel";
    
    private Connection conexion;
    
    public boolean conectar(){
        boolean estado = false;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion =  DriverManager.getConnection(URL+BD, USUARIO, PASSWORD);
            
            if( conexion != null){
                System.out.println("Conectado a la DB");
                estado = true;
            }
        } catch (ClassNotFoundException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        } catch (SQLException ex1) {
            System.out.println("Excepcion: " + ex1.getMessage());
        }
        
        return estado;
    }
    
    public boolean desconectar(){
        boolean estado = false;
        
        try {
            conexion.close();
            estado = true;
            System.out.println("Desconectado de la DB");
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        
        return estado;
    }
    
    
    /*
        CRUD para USUARIO
    
    */
    
    
    // Agrega un usuario a la DB
    public boolean agregarUsuario(Usuario usuario){
        boolean estado = false;
        
        PreparedStatement ps;
         String query = "INSERT INTO usuarios (usuario, contrasena, rol, fecha_creacion) VALUES(?, ?, ?, ?)";
        
        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, usuario.getUsuario());
            ps.setString(2, usuario.getContrasena());
            ps.setString(3, usuario.getRol());
            ps.setTimestamp(4, usuario.getFechaCreacion());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        return estado;
    }
    
    // Obtiene los registros de la DB
    public ArrayList<Usuario> consultarUsuarios(){
        ArrayList <Usuario> usuarios = new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        String query="SELECT * FROM usuarios";
        
        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);
            
            while( rs.next() ){
                Usuario usu = new Usuario();
                usu.setIdUsuario(rs.getInt(1));
                usu.setUsuario(rs.getString(2));
                usu.setContrasena(rs.getString(3));
                usu.setRol(rs.getString(4));
                usu.setFechaCreacion(rs.getTimestamp(5));
                usuarios.add(usu);
            }
            
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        
        return usuarios;
    }
    
    // Actualiza un usuario de la DB de acuerdo a su nombre de usuario
    public boolean actualizarNombreUsuario(String usuarioAnterior, String usuarioNuevo){
        boolean estado=false;
        PreparedStatement ps;
        String query = "UPDATE usuarios SET usuario = ? WHERE usuario =?";
        
        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, usuarioNuevo);
            ps.setString(2, usuarioAnterior);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        return estado;
    }
    
    // método para actualizar la contraseña del usuario
    public boolean actualizarContrasenaUsuario(String usuario,String contrasenaAnterior, String nuevaContra){
        boolean estado=false;
        PreparedStatement ps;
        String query = "UPDATE usuarios SET contrasena = ? WHERE usuario =?";
        boolean compararContrasena = verificarContrasena(usuario, contrasenaAnterior);
        
        if( compararContrasena ){
            try {
                String contrasenaHasheada = Usuario.hashearContrasena(nuevaContra);
                ps = conexion.prepareStatement(query);
                ps.setString(1, contrasenaHasheada);
                ps.setString(2, usuario);
                ps.execute();
                estado = true;
            } catch (SQLException ex) {
                System.out.println("Excepcion: " + ex.getMessage() );
            }
        }
        
        return estado;
    }
    
    // Elimina un usuario de la DB
    public boolean eliminarUsuario(String nombreUsuario){
      boolean estado=false;
        Statement st;
        String query = "DELETE FROM usuarios WHERE usuario ='" + nombreUsuario + "'";
        
        try {
            st = conexion.createStatement();
            st.executeUpdate(query);
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        
        return estado;
    }
    
    // Método para verificar la contrasena del usuario al iniciar sesión o actualizar su contraseña
    public boolean verificarContrasena(String usuario, String contrasenaIngresada) {
        boolean coincidencia = false;
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT contrasena FROM usuarios WHERE usuario = ?";
        
        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, usuario);
            rs = ps.executeQuery();

            if (rs.next()) {
                String contrasenaAlmacenada = rs.getString("contrasena");
                
                // Verificar si la contraseña ingresada (en texto plano) coincide con el hash almacenado
                if (BCrypt.checkpw(contrasenaIngresada, contrasenaAlmacenada)) {
                    coincidencia = true;  // La contraseña es correcta
                }
            }
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        
        return coincidencia;
    }
    
    /*
        CRUD para HABITACION
    
    */
    
    // Agrega una habitación a la DB
    public boolean agregarHabitacion(Habitacion habitacion){
        boolean estado = false;
        
        PreparedStatement ps;
         String query = "INSERT INTO habitaciones (numero_habitacion, tipo_habitacion, estado_disponibilidad, precio) VALUES(?, ?, ?, ?)";
        
        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, habitacion.getNumHabitacion());
            ps.setString(2, habitacion.getTipoHabitacion());
            ps.setBoolean(3, habitacion.isDisponibilidad());
            ps.setDouble(4, habitacion.getPrecio());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        return estado;
    }
    
    // Obtiene los registros de la DB
    public ArrayList<Habitacion> consultarHabitaciones(){
        ArrayList <Habitacion> habitaciones = new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        String query="SELECT * FROM habitaciones";
        
        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);
            
            while( rs.next() ){
                Habitacion habitacion = new Habitacion();
                habitacion.setIdHabitacion(rs.getInt(1));
                habitacion.setNumHabitacion(rs.getString(2));
                habitacion.setTipoHabitacion(rs.getString(3));
                habitacion.setDisponibilidad(rs.getBoolean(4));
                habitacion.setPrecio(rs.getDouble(5));
                habitaciones.add(habitacion);
            }
            
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        
        return habitaciones;
    }
    
    // Actualiza información de una habitación
        //Pueden agregar más atributos a actualizar, yo sólo agregue estos
    public boolean actualizarHabitacion(int idHabitacion, boolean disponibilidad, double precio){
        boolean estado=false;
        PreparedStatement ps;
        String query = "UPDATE habitaciones SET estado_disponibilidad = ?, precio = ? WHERE id=?";
        
        try {
            ps = conexion.prepareStatement(query);
            ps.setBoolean(1, disponibilidad);
            ps.setDouble(2, precio);
            ps.setInt(3, idHabitacion);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        return estado;
    }
    
    // Elimina un registro de la DB
    public boolean eliminarHabitacion(int idHabitacion){
      boolean estado=false;
        Statement st;
        String query = "DELETE FROM habitaciones WHERE id='" + idHabitacion + "'";
        
        try {
            st = conexion.createStatement();
            st.executeUpdate(query);
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        
        return estado;
    }
    
    /*
        CRUD para RESERVA
    
    */
    
    // Agrega una reserva a la DB
    public boolean agregarReserva(Reserva reserva){
        boolean estado = false;
        
        PreparedStatement ps;
         String query = "INSERT INTO reservas (fecha_entrada, fecha_salida,"+ 
                 "valor, forma_pago, habitacion_id) VALUES(?, ?, ?, ?, ?)";
        
        try {
            ps = conexion.prepareStatement(query);
            ps.setDate(1, reserva.getFechaEntrada());
            ps.setDate(2, reserva.getFechaSalida());
            ps.setDouble(3, reserva.getValor());
            ps.setString(4, reserva.getFormaPago());
            ps.setInt(5, reserva.getIdHabitacion());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        return estado;
    }
    
    // Obtiene los registros de la DB
    public ArrayList<Reserva> consultarReservas(){
        ArrayList <Reserva> reservas = new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        String query="SELECT * FROM habitaciones";
        
        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);
            
            while( rs.next() ){
                Reserva reserva = new Reserva();
                reserva.setIdReserva(rs.getInt(1));
                reserva.setFechaEntrada(rs.getDate(2));
                reserva.setFechaSalida(rs.getDate(3));
                reserva.setValor(rs.getDouble(4));
                reserva.setFormaPago(rs.getString(5));
                reserva.setIdHabitacion(rs.getInt(6));
                reservas.add(reserva);
            }
            
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        
        return reservas;
    }
    
    // Actualiza un usuario de la DB de acuerdo a su nombre de usuario
    public boolean actualizarReserva(int idReserva, Date fechaEntrada, Date fechaSalida){
        boolean estado=false;
        PreparedStatement ps;
        String query = "UPDATE reseravas SET fecha_entrada= ?, fecha_salida = ? WHERE id=?";
        
        try {
            ps = conexion.prepareStatement(query);
            ps.setDate(1, fechaEntrada);
            ps.setDate(2, fechaSalida);
            ps.setInt(3, idReserva);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        return estado;
    }
    
    public boolean eliminarReserva(int idReserva){
      boolean estado=false;
        Statement st;
        String query = "DELETE FROM reservas WHERE id='" + idReserva + "'";
        
        try {
            st = conexion.createStatement();
            st.executeUpdate(query);
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage() );
        }
        
        return estado;
    }
    
    /*
        CRUD para HUESPED
    
    */
}
