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
import java.util.List;
import modelo.Habitacion;
import modelo.Huesped;
import modelo.Reserva;
import modelo.Usuario;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author kakashi
 */
public class ControladorBD {

    private static final String USUARIO = "root";
    private static final String PASSWORD = "Protegee7-Deceit-Harmful";
    private static final String URL = "jdbc:mysql://localhost:3306/";
    private static final String BD = "hotel";

    private Connection conexion;

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
    // Agrega un usuario a la DB
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

    // Obtiene los registros de la DB
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

    // método para obtener los datos del usuario al iniciar sesión
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

    // Actualiza un usuario de la DB de acuerdo a su nombre de usuario
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

    // método para actualizar la contraseña del usuario
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

    // Elimina un usuario de la DB
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

    // Método para verificar la contrasena del usuario al iniciar sesión o actualizar su contraseña
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
    // Agrega una habitación a la DB
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

    // Obtiene los registros de la DB
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

    // Actualiza información de una habitación
    //Pueden agregar más atributos a actualizar, yo sólo agregue estos
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

    // Elimina un registro de la DB
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
    // Agrega una reserva a la DB
    public boolean agregarReserva(Reserva reserva) {
        boolean estado = false;

        PreparedStatement ps;
        String query = "INSERT INTO reserva (fecha_entrada, fecha_salida,"
                + "valor, forma_pago, habitacion_id) VALUES(?, ?, ?, ?, ?)";

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
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    // Obtiene los registros de la DB
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
                reservas.add(reserva);
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return reservas;
    }

    // Actualiza un usuario de la DB de acuerdo a su nombre de usuario
    public boolean actualizarReserva(int idReserva, Date fechaEntrada, Date fechaSalida) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE reserva SET fecha_entrada= ?, fecha_salida = ? WHERE id=?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setDate(1, fechaEntrada);
            ps.setDate(2, fechaSalida);
            ps.setInt(3, idReserva);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

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
    public void agregarHuesped(Huesped huesped) {
    	try {
    		String sql = "INSERT INTO huesped(nombre, apellido, fecha_nacimiento, nacionalidad, telefono)"
    				+ "VALUES(?, ?, ?, ?, ?)";
    		final PreparedStatement statement = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    		try(statement) {
    			statement.setString(1, huesped.getNombre());
    			statement.setString(2, huesped.getApellido());
    			statement.setObject(3, huesped.getFechaNacimiento());
    			statement.setString(4, huesped.getNacionalidad());
    			statement.setString(5, huesped.getTelefono());
    			
    			//statement.executeUpdate();
    			statement.execute();
    			
    			final ResultSet resultSet = statement.getGeneratedKeys();
    			
    			try (resultSet) {
    				while (resultSet.next()) {
    					huesped.setId(resultSet.getInt(1));
                    }
    			}
    		}
		} catch (SQLException e) {
			throw new RuntimeException("Exception: " + e.getMessage() +e);
		}
    }
    
    public ArrayList<Huesped> consultarHuspedes() {
    	ArrayList<Huesped> huespedes = new ArrayList<>();
    	
    	try {
            String sql = "SELECT * FROM huesped";
            
            //System.out.println(sql);
            
            final PreparedStatement statement = conexion.prepareStatement(sql);

            try (statement) {
                statement.execute();
                tranformarResultado(huespedes, statement);
                }
            return huespedes;
        } catch (SQLException e) {
            throw new RuntimeException("Exception: " + e.getMessage() +e);
        }
    }
    
   public int actualizarHuesped(String nombre, String apellido, LocalDate fechaNacimiento, String nacionalidad,
			String telefono, Integer id) {
        try {
          
			String sql = "UPDATE huesped SET nombre = ?, apellido = ?, fecha_nacimiento = ?, nacionalidad = ?, " 
			+ "telefono = ? WHERE id = ?";
        	
        	final PreparedStatement statement = conexion.prepareStatement(sql);

            try (statement) {
            	statement.setString(1, nombre);
            	statement.setString(2, apellido);
                statement.setObject(3, java.sql.Date.valueOf(fechaNacimiento));
            	//statement.setObject(3, fechaNacimiento);
                statement.setString(4, nacionalidad);
                statement.setString(5, telefono);
                statement.setInt(6, id);
                statement.execute();
                //System.out.println("entrando a la base");
                int updateCount = statement.getUpdateCount();

                return updateCount;
                
            } 
		} catch (SQLException e) {
			throw new RuntimeException("Exception: " + e.getMessage() +e);
		}
    }
    
    public void eliminarHuesped(Integer id) {
		try {
			String sql = "DELETE FROM huesped WHERE id = ?";
			PreparedStatement statement = conexion.prepareStatement(sql);
        	try (statement) {
        		//java.sql.Statement state = con.createStatement();
        		//state.execute("SET FOREIGN_KEY_CHECKS=0");
        		
                statement.setInt(1, id);
                statement.execute();
                //state.execute("SET FOREIGN_KEY_CHECKS=1");
                //System.out.println("entrando a la base");
        		
			} 
		} catch (SQLException e) {
			throw new RuntimeException("Exception: " + e.getMessage() +e);
		}
	}
    
    private void tranformarResultado(ArrayList<Huesped> huespedes, PreparedStatement statement) throws SQLException {
    	final ResultSet resultSet = statement.executeQuery();

        try (resultSet) {
            while (resultSet.next()) {
            	int idHuesped = resultSet.getInt("id");
            	String nombre = resultSet.getString("nombre");
            	String apellido = resultSet.getString("apellido");
            	LocalDate fechaNacimiento = resultSet.getDate("fecha_nacimiento").toLocalDate().plusDays(0);
            	String nacionalidad = resultSet.getString("nacionalidad");
            	String telefono = resultSet.getString("telefono");
            	
            	Huesped producto = new Huesped(idHuesped, nombre, apellido, fechaNacimiento, nacionalidad, telefono);
            	huespedes.add(producto);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e); 
        }
    }
    
    public ArrayList<Huesped> buscarHuespedPorId(String id) {
    	ArrayList<Huesped> huespedes = new ArrayList<>();
    	
    	try {
            String sql = "SELECT * FROM huespedes WHERE id = ?";
            
            //System.out.println(sql);
            
            final PreparedStatement statement = conexion.prepareStatement(sql);

            try (statement) {
            	statement.setString(1, id);
                statement.execute();
                tranformarResultado(huespedes, statement);
                }
            return huespedes;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
