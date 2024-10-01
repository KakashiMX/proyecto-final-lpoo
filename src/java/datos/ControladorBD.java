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
import java.time.LocalDate;
import java.util.ArrayList;
import modelo.Habitacion;
import modelo.Huesped;
import modelo.Reserva;
import modelo.Usuario;
import org.mindrot.jbcrypt.BCrypt;

/**
 * Clase que gestiona la conexión y operaciones con la base de datos hotel.
 * Proporciona métodos para conectar, desconectar, y realizar operaciones CRUD
 * para usuario, habitación, reserva y huésped.
 *
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 *
 * @version 2024/09/30
 */
public class ControladorBD {

    private static final String USUARIO = "root";
    private static final String PASSWORD = "Protegee7-Deceit-Harmful";
    private static final String URL = "jdbc:mysql://localhost:3306/";
    private static final String BD = "hotel";

    private Connection conexion;

    /**
     * Establece una conexión con la base de datos.
     *
     * @return true si la conexión fue exitosa, false si hubo algún error.
     */
    public boolean conectar() {
        boolean estado = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL + BD, USUARIO, PASSWORD);

            if (conexion != null) {
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

    /**
     * Cierra la conexión actual con la base de datos.
     *
     * @return true si se cerró la conexión correctamente, false si hubo algún
     * error.
     */
    public boolean desconectar() {
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
    /**
     * Agrega un usuario a la base de datos.
     *
     * @param usuario Objeto Usuario que representa al usuario a agregar.
     * @return true si el usuario fue agregado correctamente, false si hubo
     * algún error.
     */
    public boolean agregarUsuario(Usuario usuario) {
        boolean estado = false;

        PreparedStatement ps;
        String query = "INSERT INTO usuario (usuario, contrasena, rol, fecha_creacion) VALUES(?, ?, ?, ?)";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, usuario.getUsuario());
            ps.setString(2, usuario.getContrasena());
            ps.setString(3, usuario.getRol());
            ps.setTimestamp(4, usuario.getFechaCreacion());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Consulta todos los usuarios registrados en la base de datos.
     *
     * @return {@code ArrayList<Usuario>} de Usuario con todos los usuarios 
     * registrados.
     */
    public ArrayList<Usuario> consultarUsuarios() {
        ArrayList<Usuario> usuarios = new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        String query = "SELECT * FROM usuario";

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);

            while (rs.next()) {
                Usuario usu = new Usuario();
                usu.setIdUsuario(rs.getInt(1));
                usu.setUsuario(rs.getString(2));
                usu.setContrasena(rs.getString(3));
                usu.setRol(rs.getString(4));
                usu.setFechaCreacion(rs.getTimestamp(5));
                usuarios.add(usu);
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return usuarios;
    }

    /**
     * Consulta un usuario específico en la base de datos.
     *
     * @param nombreUsuario Nombre de usuario del usuario a consultar.
     * @param contrasena Contraseña del usuario a consultar.
     * @return Objeto Usuario si se encuentra en la base de datos, o un Usuario
     * vacío si no se encuentra.
     */
    public Usuario consultarUsuario(String nombreUsuario, String contrasena) {
        Usuario usuario = new Usuario();
        Statement sentenciaSQL;
        ResultSet rs;
        String query = "SELECT * FROM usuario WHERE usuario='" + nombreUsuario + "'";

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);

            while (rs.next()) {
                usuario.setIdUsuario(rs.getInt(1));
                usuario.setUsuario(rs.getString(2));
                usuario.setContrasena(rs.getString(3));
                usuario.setRol(rs.getString(4));
                usuario.setFechaCreacion(rs.getTimestamp(5));
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return usuario;
    }

    /**
     * Verifica si ya existe un usuario con el nombre especificado en la base de
     * datos.
     *
     * @param nombreUsuario Nombre de usuario a verificar.
     * @return true si el usuario ya existe, false si no existe.
     */
    public boolean yaExisteUsuario(String nombreUsuario) {
        boolean yaExiste = false;
        Usuario usuario = new Usuario();
        Statement sentenciaSQL;
        ResultSet rs;
        String query = "SELECT * FROM usuario WHERE usuario='" + nombreUsuario + "'";

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);

            while (rs.next()) {
                usuario.setIdUsuario(rs.getInt(1));
                usuario.setUsuario(rs.getString(2));
                usuario.setContrasena(rs.getString(3));
                usuario.setRol(rs.getString(4));
                usuario.setFechaCreacion(rs.getTimestamp(5));
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        if (usuario.getUsuario() != null) {
            yaExiste = true;
        }
        return yaExiste;
    }

    /**
     * Actualiza el nombre de usuario en la base de datos.
     *
     * @param usuarioAnterior Nombre de usuario anterior.
     * @param usuarioNuevo Nuevo nombre de usuario.
     * @return true si se actualizó correctamente, false si hubo algún error.
     */
    public boolean actualizarNombreUsuario(String usuarioAnterior, String usuarioNuevo) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE usuario SET usuario = ? WHERE usuario =?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, usuarioNuevo);
            ps.setString(2, usuarioAnterior);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Actualiza la contraseña de un usuario en la base de datos.
     *
     * @param usuario Nombre de usuario.
     * @param contrasenaAnterior Contraseña anterior del usuario.
     * @param nuevaContra Nueva contraseña a establecer.
     * @return true si se actualizó correctamente, false si hubo algún error.
     */
    public boolean actualizarContrasenaUsuario(String usuario, String contrasenaAnterior, String nuevaContra) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE usuario SET contrasena = ? WHERE usuario =?";
        boolean compararContrasena = verificarContrasena(usuario, contrasenaAnterior);

        if (compararContrasena) {
            try {
                String contrasenaHasheada = Usuario.hashearContrasena(nuevaContra);
                ps = conexion.prepareStatement(query);
                ps.setString(1, contrasenaHasheada);
                ps.setString(2, usuario);
                ps.execute();
                estado = true;
            } catch (SQLException ex) {
                System.out.println("Excepcion: " + ex.getMessage());
            }
        }

        return estado;
    }

    /**
     * Elimina un usuario de la base de datos.
     *
     * @param nombreUsuario Nombre de usuario a eliminar.
     * @return true si se eliminó correctamente, false si hubo algún error.
     */
    public boolean eliminarUsuario(String nombreUsuario) {
        boolean estado = false;
        Statement st;
        String query = "DELETE FROM usuario WHERE usuario ='" + nombreUsuario + "'";

        try {
            st = conexion.createStatement();
            st.executeUpdate(query);
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return estado;
    }

    /**
     * Verifica si la contraseña ingresada coincide con la almacenada en la base
     * de datos para el usuario especificado.
     *
     * @param usuario Nombre de usuario.
     * @param contrasenaIngresada Contraseña a verificar
     * @return true si la contraseña concide con el hash almacenado, false si
     * hubo algún error.
     */
    public boolean verificarContrasena(String usuario, String contrasenaIngresada) {
        boolean coincidencia = false;
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT contrasena FROM usuario WHERE usuario = ?";

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
    /**
     * Agrega una habitación a la base de datos.
     *
     * @param habitacion La habitación que se va a agregar.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean agregarHabitacion(Habitacion habitacion) {
        boolean estado = false;

        PreparedStatement ps;
        String query = "INSERT INTO habitacion (numero_habitacion, tipo_habitacion, estado_disponibilidad, precio) VALUES(?, ?, ?, ?)";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, habitacion.getNumHabitacion());
            ps.setString(2, habitacion.getTipoHabitacion());
            ps.setBoolean(3, habitacion.isDisponibilidad());
            ps.setDouble(4, habitacion.getPrecio());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Consulta todas las habitaciones almacenadas en la base de datos.
     *
     * @return Un {@code ArrayList<Habitacion>} de objetos Habitacion 
     * con todas las habitaciones almacenadas.
     */
    public ArrayList<Habitacion> consultarHabitaciones() {
        ArrayList<Habitacion> habitaciones = new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        String query = "SELECT * FROM habitacion";

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);

            while (rs.next()) {
                Habitacion habitacion = new Habitacion();
                habitacion.setIdHabitacion(rs.getInt(1));
                habitacion.setNumHabitacion(rs.getString(2));
                habitacion.setTipoHabitacion(rs.getString(3));
                habitacion.setDisponibilidad(rs.getBoolean(4));
                habitacion.setPrecio(rs.getDouble(5));
                habitaciones.add(habitacion);
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return habitaciones;
    }

    /**
     * Actualiza la información de una habitación en la base de datos.
     *
     * @param idHabitacion El ID de la habitación que se va a actualizar.
     * @param disponibilidad La nueva disponibilidad de la habitación.
     * @param precio El nuevo precio de la habitación.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean actualizarHabitacion(int idHabitacion, boolean disponibilidad, double precio) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE habitacion SET estado_disponibilidad = ?, precio = ? WHERE id=?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setBoolean(1, disponibilidad);
            ps.setDouble(2, precio);
            ps.setInt(3, idHabitacion);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Elimina una habitación de la base de datos.
     *
     * @param idHabitacion El ID de la habitación que se va a eliminar.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean eliminarHabitacion(int idHabitacion) {
        boolean estado = false;
        Statement st;
        String query = "DELETE FROM habitacion WHERE id='" + idHabitacion + "'";

        try {
            st = conexion.createStatement();
            st.executeUpdate(query);
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return estado;
    }

    /*
        CRUD para RESERVA
    
     */
    /**
     * Agrega una reserva a la base de datos.
     *
     * @param reserva La reserva que se va a agregar.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean agregarReserva(Reserva reserva) {
        boolean estado = false;

        PreparedStatement ps;
        String query = "INSERT INTO reserva (fecha_entrada, fecha_salida,"
                + "valor, forma_pago, habitacion_id, id_huesped) VALUES(?, ?, ?, ?, ?, ?)";

        try {
            ps = conexion.prepareStatement(query);
            ps.setDate(1, reserva.getFechaEntrada());
            ps.setDate(2, reserva.getFechaSalida());
            ps.setDouble(3, reserva.getValor());
            ps.setString(4, reserva.getFormaPago());
            ps.setInt(5, reserva.getIdHabitacion());
            ps.setInt(6, reserva.getIdCliente());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Consulta todas las reservas almacenadas en la base de datos.
     *
     * @return Un {@code ArrayList<Reserva>} de objetos Reserva con 
     * todas las reservas almacenadas.
     */
    public ArrayList<Reserva> consultarReservas() {
        ArrayList<Reserva> reservas = new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        String query = "SELECT * FROM reserva";

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);

            while (rs.next()) {
                Reserva reserva = new Reserva();
                reserva.setIdReserva(rs.getInt(1));
                reserva.setFechaEntrada(rs.getDate(2));
                reserva.setFechaSalida(rs.getDate(3));
                reserva.setValor(rs.getDouble(4));
                reserva.setFormaPago(rs.getString(5));
                reserva.setIdHabitacion(rs.getInt(6));
                reserva.setIdCliente(rs.getInt(7));
                reservas.add(reserva);
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return reservas;
    }

    /**
     * Actualiza la información de una reserva en la base de datos.
     *
     * @param idReserva El ID de la reserva que se va a actualizar.
     * @param fechaEntrada La nueva fecha de entrada de la reserva.
     * @param fechaSalida La nueva fecha de salida de la reserva.
     * @param valor El nuevo valor de la reserva.
     * @param formaPago La nueva forma de pago de la reserva.
     * @param idHabitacion El nuevo ID de la habitación de la reserva.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean actualizarReserva(int idReserva, Date fechaEntrada, Date fechaSalida, float valor, String formaPago, int idHabitacion) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE reserva SET fecha_entrada= ?, fecha_salida = ?,"
                + " valor= ?, forma_pago = ?, habitacion_id = ? WHERE id=?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setDate(1, fechaEntrada);
            ps.setDate(2, fechaSalida);
            ps.setFloat(3, valor);
            ps.setString(4, formaPago);
            ps.setInt(5, idHabitacion);
            ps.setInt(6, idReserva);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Elimina una reserva de la base de datos.
     *
     * @param idReserva El ID de la reserva que se va a eliminar.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean eliminarReserva(int idReserva) {
        boolean estado = false;
        Statement st;
        String query = "DELETE FROM reserva WHERE id='" + idReserva + "'";

        try {
            st = conexion.createStatement();
            st.executeUpdate(query);
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return estado;
    }

    /*
        CRUD para HUESPED
    
     */
    /**
     * Agrega un nuevo huésped a la base de datos.
     *
     * @param huesped Objeto Huesped a ser agregado.
     * @return true si la operación de inserción fue exitosa, false si falló.
     */
    public boolean agregarHuesped(Huesped huesped) {
        boolean estado = false;
        PreparedStatement statement;
        String sql = "INSERT INTO huesped(nombre, apellido, fecha_nacimiento, nacionalidad, telefono)"
                + "VALUES(?, ?, ?, ?, ?)";

        try {
            statement = conexion.prepareStatement(sql);
            statement.setString(1, huesped.getNombre());
            statement.setString(2, huesped.getApellido());
            statement.setObject(3, huesped.getFechaNacimiento());
            statement.setString(4, huesped.getNacionalidad());
            statement.setString(5, huesped.getTelefono());
            statement.execute();

            estado = true;

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());

        }
        return estado;
    }

    /**
     * Consulta todos los huéspedes almacenados en la base de datos.
     *
     * @return Un {@code ArrayList<Huesped>} de objetos Huesped que contiene
     * todos los huéspedes almacenados.
     */
    public ArrayList<Huesped> consultarHuspedes() {
        ArrayList<Huesped> huespedes = new ArrayList<>();
        String sql = "SELECT * FROM huesped";
        Statement statement;
        ResultSet rs;

        try {
            statement = conexion.createStatement();
            rs = statement.executeQuery(sql);

            while (rs.next()) {
                Huesped huesped = new Huesped();
                huesped.setId(rs.getInt(1));
                huesped.setNombre(rs.getString(2));
                huesped.setApellido(rs.getString(3));
                huesped.setFechaNacimiento(rs.getDate(4).toLocalDate().plusDays(0));
                huesped.setNacionalidad(rs.getString(5));
                huesped.setTelefono(rs.getString(6));
                huespedes.add(huesped);
            }
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return huespedes;
    }

    /**
     * Actualiza la información de un huésped en la base de datos.
     *
     * @param nombre Nuevo nombre del huésped.
     * @param apellido Nuevo apellido del huésped.
     * @param fechaNacimiento Nueva fecha de nacimiento del huésped.
     * @param nacionalidad Nueva nacionalidad del huésped.
     * @param telefono Nuevo número de teléfono del huésped.
     * @param id ID del huésped a actualizar.
     * @return true si la actualización fue exitosa, false si falló.
     */
    public boolean actualizarHuesped(String nombre, String apellido, LocalDate fechaNacimiento, String nacionalidad,
            String telefono, Integer id) {
        boolean estado = false;

        String sql = "UPDATE huesped SET nombre = ?, apellido = ?, fecha_nacimiento = ?, nacionalidad = ?, "
                + "telefono = ? WHERE id = ?";

        PreparedStatement statement;

        try {

            statement = conexion.prepareStatement(sql);
            statement.setString(1, nombre);
            statement.setString(2, apellido);
            statement.setObject(3, java.sql.Date.valueOf(fechaNacimiento));
            statement.setString(4, nacionalidad);
            statement.setString(5, telefono);
            statement.setInt(6, id);
            statement.execute();

            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Elimina un huésped de la base de datos dado su ID.
     *
     * @param id ID del huésped a ser eliminado.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean eliminarHuesped(Integer id) {
        boolean estado = false;
        String sql = "DELETE FROM huesped WHERE id = ?";
        PreparedStatement statement;
        try {
            statement = conexion.prepareStatement(sql);
            statement.setInt(1, id);
            statement.execute();
            
            estado = true;

        } catch (SQLException e) {
            throw new RuntimeException("Exception: " + e.getMessage() + e);
        }
        return estado;
    }
}
