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
import modelo.Administrador;
import modelo.HabitacionFamiliar;
import modelo.HabitacionSencilla;
import modelo.HabitacionSuite;
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
     * Agrega un administrador a la base de datos.
     *
     * @param usuario Objeto Administrador que representa al administrador 
     * a agregar.
     * @return true si el administrador fue agregado correctamente, false si 
     * hubo algún error.
     */
    public boolean agregarAdministrador(Administrador usuario) {
        boolean estado = false;

        PreparedStatement ps;
        String query = "INSERT INTO administrador (usuario, contrasena, fecha_creacion) VALUES(?, ?, ?)";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, usuario.getUsuario());
            ps.setString(2, usuario.getContrasena());
            ps.setTimestamp(3, usuario.getFechaCreacion());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Consulta todos los sdministradores registrados en la base de datos.
     *
     * @return {@code ArrayList<Administrador>} de Administrador con todos 
     * los sdministradores registrados.
     */
    public ArrayList<Administrador> consultarAdministradores() {
        ArrayList<Administrador> sdministradores = new ArrayList<>();
        Statement sentenciaSQL;
        ResultSet rs;
        String query = "SELECT * FROM administrador";

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);

            while (rs.next()) {
                Administrador admin = new Administrador();
                admin.setIdAdministrador(rs.getInt(1));
                admin.setUsuario(rs.getString(2));
                admin.setContrasena(rs.getString(3));
                admin.setFechaCreacion(rs.getTimestamp(4));
                sdministradores.add(admin);
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return sdministradores;
    }

    /**
     * Consulta un administrador específico en la base de datos.
     *
     * @param nombreAdministrador Nombre de administrador del administrador a consultar.
     * @param contrasena Contraseña del administrador a consultar.
     * @return Objeto Administrador si se encuentra en la base de datos, o un Administrador
 vacío si no se encuentra.
     */
    public Administrador consultarAdministrador(String nombreAdministrador, String contrasena) {
        Administrador administrador = new Administrador();
        Statement sentenciaSQL;
        ResultSet rs;
        String query = "SELECT * FROM administrador WHERE usuario='" + nombreAdministrador + "'";

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);

            while (rs.next()) {
                administrador.setIdAdministrador(rs.getInt(1));
                administrador.setUsuario(rs.getString(2));
                administrador.setContrasena(rs.getString(3));
                administrador.setFechaCreacion(rs.getTimestamp(4));
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        return administrador;
    }

    /**
     * Verifica si ya existe un administrador con el nombre especificado en la base de
 datos.
     *
     * @param nombreAdministrador Nombre de administrador a verificar.
     * @return true si el administrador ya existe, false si no existe.
     */
    public boolean yaExisteAdministrador(String nombreAdministrador) {
        boolean yaExiste = false;
        Administrador administrador = new Administrador();
        Statement sentenciaSQL;
        ResultSet rs;
        String query = "SELECT * FROM administrador WHERE usuario='" + nombreAdministrador + "'";

        try {
            sentenciaSQL = conexion.createStatement();
            rs = sentenciaSQL.executeQuery(query);

            while (rs.next()) {
                administrador.setIdAdministrador(rs.getInt(1));
                administrador.setUsuario(rs.getString(2));
                administrador.setContrasena(rs.getString(3));
                administrador.setFechaCreacion(rs.getTimestamp(4));
            }

        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }

        if (administrador.getUsuario() != null) {
            yaExiste = true;
        }
        return yaExiste;
    }

    /**
     * Actualiza el nombre de administrador en la base de datos.
     *
     * @param administradorAnterior Nombre de administrador anterior.
     * @param administradorNuevo Nuevo nombre de administrador.
     * @return true si se actualizó correctamente, false si hubo algún error.
     */
    public boolean actualizarNombreAdministrador(String administradorAnterior, String administradorNuevo) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE administrador SET usuario = ? WHERE usuario =?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, administradorNuevo);
            ps.setString(2, administradorAnterior);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }

    /**
     * Actualiza la contraseña de un administrador en la base de datos.
     *
     * @param usuario Nombre de administrador.
     * @param contrasenaAnterior Contraseña anterior del administrador.
     * @param nuevaContra Nueva contraseña a establecer.
     * @return true si se actualizó correctamente, false si hubo algún error.
     */
    public boolean actualizarContrasenaAdministrador(String usuario, String contrasenaAnterior, String nuevaContra) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE administrador SET contrasena = ? WHERE usuario =?";
        boolean compararContrasena = verificarContrasena(usuario, contrasenaAnterior);

        if (compararContrasena) {
            try {
                String contrasenaHasheada = Administrador.hashearContrasena(nuevaContra);
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
     * Elimina un administrador de la base de datos.
     *
     * @param nombreAdministrador Nombre de administrador a eliminar.
     * @return true si se eliminó correctamente, false si hubo algún error.
     */
    public boolean eliminarAdministrador(String nombreAdministrador) {
        boolean estado = false;
        Statement st;
        String query = "DELETE FROM administrador WHERE usuario ='" + nombreAdministrador + "'";

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
 de datos para el administrador especificado.
     *
     * @param usuario Nombre de administrador.
     * @param contrasenaIngresada Contraseña a verificar
     * @return true si la contraseña concide con el hash almacenado, false si
     * hubo algún error.
     */
    public boolean verificarContrasena(String usuario, String contrasenaIngresada) {
        boolean coincidencia = false;
        PreparedStatement ps;
        ResultSet rs;
        String query = "SELECT contrasena FROM administrador WHERE usuario = ?";

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
        String query = "INSERT INTO habitacion (numero_habitacion, tipo_habitacion, estado_disponibilidad, precio, precio_total) VALUES(?, ?, ?, ?, ?)";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, habitacion.getNumHabitacion());
            ps.setString(2, habitacion.getTipoHabitacion());
            ps.setBoolean(3, habitacion.isDisponibilidad());
            ps.setDouble(4, habitacion.getPrecio());
            ps.setDouble(5, habitacion.getPrecioTotalTipoHabitacion());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }
    
    /**
     * Agrega una habitación familiar a la base de datos.
     *
     * @param habitacionFamiliar La habitación que se va a agregar.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean agregarHabitacionFamiliar(HabitacionFamiliar habitacionFamiliar) {
        boolean estado = false;

        PreparedStatement ps;
        String query = "INSERT INTO habitacion (numero_habitacion, tipo_habitacion,capacidad_maxima,"
                +"tiene_sala, tiene_cocina, estado_disponibilidad, precio, precio_total) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, habitacionFamiliar.getNumHabitacion());
            ps.setString(2, habitacionFamiliar.getTipoHabitacion());
            ps.setInt(3, habitacionFamiliar.getCapacidadMaxima());
            ps.setBoolean(4, habitacionFamiliar.isTieneSala());
            ps.setBoolean(5, habitacionFamiliar.isTieneCocina());
            ps.setBoolean(6, habitacionFamiliar.isDisponibilidad());
            ps.setDouble(7, habitacionFamiliar.getPrecio());
            ps.setDouble(8, habitacionFamiliar.getPrecioTotalTipoHabitacion());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }
    
    /**
     * Agrega una habitación suite a la base de datos.
     * 
     * @param habitacionSuite
     * @return 
     */
    public boolean agregarHabitacionSuite(HabitacionSuite habitacionSuite) {
        boolean estado = false;

        PreparedStatement ps;
        String query = "INSERT INTO habitacion (numero_habitacion, tipo_habitacion,"
                +"servicio_habitacion, vista, estado_disponibilidad, precio, precio_total) VALUES(?, ?, ?, ?, ?, ?, ?)";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, habitacionSuite.getNumHabitacion());
            ps.setString(2, habitacionSuite.getTipoHabitacion());
            ps.setBoolean(3, habitacionSuite.isServicioHabitacion());
            ps.setString(4, habitacionSuite.getVista());
            ps.setBoolean(5, habitacionSuite.isDisponibilidad());
            ps.setDouble(6, habitacionSuite.getPrecio());
            ps.setDouble(7, habitacionSuite.getPrecioTotalTipoHabitacion());
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
            String tipoHabitacion = rs.getString(3);

            if (tipoHabitacion.equalsIgnoreCase("Familiar")) {
                HabitacionFamiliar habitacionFamiliar = new HabitacionFamiliar();
                habitacionFamiliar.setIdHabitacion(rs.getInt(1));
                habitacionFamiliar.setNumHabitacion(rs.getString(2));
                habitacionFamiliar.setTipoHabitacion(tipoHabitacion);
                habitacionFamiliar.setCapacidadMaxima(rs.getInt(4));
                habitacionFamiliar.setTieneSala(rs.getBoolean(5)); // Esto parece repetido, revisa los índices de las columnas
                habitacionFamiliar.setTieneCocina(rs.getBoolean(6)); // Esto parece repetido, revisa los índices de las columnas
                habitacionFamiliar.setDisponibilidad(rs.getBoolean(9));
                habitacionFamiliar.setPrecio(rs.getDouble(10));
                habitacionFamiliar.setPrecioTotalTipoHabitacion(rs.getDouble(11));
                
                habitaciones.add(habitacionFamiliar);

            } else if (tipoHabitacion.equalsIgnoreCase("Suite")) {
                HabitacionSuite habitacionSuite = new HabitacionSuite();
                habitacionSuite.setIdHabitacion(rs.getInt(1));
                habitacionSuite.setNumHabitacion(rs.getString(2));
                habitacionSuite.setTipoHabitacion(tipoHabitacion);
                habitacionSuite.setServicioHabitacion(rs.getBoolean(7)); 
                habitacionSuite.setVista(rs.getString(8));
                habitacionSuite.setDisponibilidad(rs.getBoolean(9));
                habitacionSuite.setPrecio(rs.getDouble(10));
                habitacionSuite.setPrecioTotalTipoHabitacion(rs.getDouble(11));

                habitaciones.add(habitacionSuite);

            } else {
                // Si es una habitación sencilla o por defecto
                Habitacion habitacionSencilla = new HabitacionSencilla();
                habitacionSencilla.setIdHabitacion(rs.getInt(1));
                habitacionSencilla.setNumHabitacion(rs.getString(2));
                habitacionSencilla.setTipoHabitacion(tipoHabitacion);
                habitacionSencilla.setDisponibilidad(rs.getBoolean(9));
                habitacionSencilla.setPrecio(rs.getDouble(10));
                habitacionSencilla.setPrecioTotalTipoHabitacion(rs.getDouble(11));

                habitaciones.add(habitacionSencilla);
            }
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
     * @param numHabitacion El nuevo número de la habitación.
     * @param tipoHabitacion El nuevo tipo de la habitación.
     * @param disponibilidad La nueva disponibilidad de la habitación.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    // Actualiza información de una habitación
    //Pueden agregar más atributos a actualizar, yo sólo agregue estos
    public boolean actualizarHabitacion(int idHabitacion, String numHabitacion, String tipoHabitacion, boolean disponibilidad) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE habitacion SET numero_habitacion=?, tipo_habitacion=?, estado_disponibilidad = ? WHERE id=?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, numHabitacion);
            ps.setString(2, tipoHabitacion);
            ps.setBoolean(3, disponibilidad);
            ps.setInt(4, idHabitacion);
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }
    
    /**
    * Actualiza los datos de una habitación familiar en la base de datos.
    *
    * Este método toma un objeto de tipo {@link HabitacionFamiliar} y actualiza
    * los campos correspondientes en la tabla de habitaciones. Los campos que se 
    * actualizan incluyen el número de habitación, tipo de habitación, 
    * capacidad máxima, estado de sala y cocina, disponibilidad, precio y 
    * precio total. 
    *
    * @param habitacionFamiliar El objeto {@link HabitacionFamiliar} que contiene
    *                           los nuevos datos para la actualización.
    * @return true si la actualización se realizó con éxito; false en caso
    *         contrario.
    */
    public boolean actualizarHabitacionFamiliar(HabitacionFamiliar habitacionFamiliar){
         boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE habitacion SET numero_habitacion=?, tipo_habitacion=?,"
                + "capacidad_maxima=?, tiene_sala=?,tiene_cocina=?, "
                +"estado_disponibilidad = ?, precio = ?, precio_total=? WHERE id=?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, habitacionFamiliar.getNumHabitacion());
            ps.setString(2, habitacionFamiliar.getTipoHabitacion());
            ps.setInt(3, habitacionFamiliar.getCapacidadMaxima());
            ps.setBoolean(4, habitacionFamiliar.isTieneSala());
            ps.setBoolean(5, habitacionFamiliar.isTieneSala());
            ps.setBoolean(6, habitacionFamiliar.isDisponibilidad());
            ps.setDouble(7, habitacionFamiliar.getPrecio());
            ps.setDouble(8, habitacionFamiliar.getPrecioTotalTipoHabitacion());
            ps.setInt(9, habitacionFamiliar.getIdHabitacion());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }
    
    /**
    * Actualiza los datos de una habitación suite en la base de datos.
    *
    * Este método toma un objeto de tipo {@link HabitacionSuite} y actualiza
    * los campos correspondientes en la tabla de habitaciones. Los campos que se 
    * actualizan incluyen el número de habitación, tipo de habitación, 
    * servicio a la habitación, vista, disponibilidad, precio y 
    * precio total. 
    *
    * @param habitacionSuite El objeto {@link HabitacionSuite} que contiene
    *                        los nuevos datos para la actualización.
    * @return true si la actualización se realizó con éxito; false en caso
    *         contrario.
    */
    public boolean actualizarHabitacionSuite(HabitacionSuite habitacionSuite){
        System.out.println(habitacionSuite.getIdHabitacion());
         boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE habitacion SET numero_habitacion=?, tipo_habitacion=?,"
                +"servicio_habitacion=?, vista=?, estado_disponibilidad = ?, precio = ?, precio_total=? WHERE id=?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setString(1, habitacionSuite.getNumHabitacion());
            ps.setString(2, habitacionSuite.getTipoHabitacion());
            ps.setBoolean(3, habitacionSuite.isServicioHabitacion());
            ps.setString(4, habitacionSuite.getVista());
            ps.setBoolean(5, habitacionSuite.isDisponibilidad());
            ps.setDouble(6, habitacionSuite.getPrecio());
            ps.setDouble(7, habitacionSuite.getPrecioTotalTipoHabitacion());
            ps.setInt(8, habitacionSuite.getIdHabitacion());
            ps.execute();
            estado = true;
        } catch (SQLException ex) {
            System.out.println("Excepcion: " + ex.getMessage());
        }
        return estado;
    }
    
     /**
     * Actualiza la información de una habitación en la base de datos.
     *
     * @param idHabitacion El ID de la habitación que se va a actualizar.
     * @param disponibilidad La nueva disponibilidad de la habitación.
     * @return true si la operación fue exitosa, false si ocurrió un error.
     */
    public boolean actualizarHabitacionReserva(int idHabitacion, boolean disponibilidad) {
        boolean estado = false;
        PreparedStatement ps;
        String query = "UPDATE habitacion SET estado_disponibilidad = ? WHERE id=?";

        try {
            ps = conexion.prepareStatement(query);
            ps.setBoolean(1, disponibilidad);
            ps.setInt(2, idHabitacion);
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
