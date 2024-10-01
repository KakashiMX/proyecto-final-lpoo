/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
/**
 * La clase Huésped representa a un huésped de un hotel con atributos como
 * nombre, apellido, fecha de nacimiento, nacionalidad y teléfono. También
 * incluye métodos para realizar diversas operaciones, como contar huéspedes por
 * nacionalidad, buscar por ID, calcular la edad promedio, clasificar por rangos
 * de edad, buscar los nombres y apellidos mas comunes entre los huéspedes.
 *
 * <p>
 * Esta clase incluye varias sobrecargas de constructores para crear objetos
 * Huesped, tanto con o sin ID y otros atributos.
 * </p>
 *
 * @author Nava Ricardo
 * @author Ceron Cristian
 * @author Hernández Monserrath
 *
 * @version 2024/09/30
 */
public class Huesped {

    private Integer id;
    private String nombre;
    private String apellido;
    private LocalDate fechaNacimiento;
    private String nacionalidad;
    private String telefono;

    /**
     * Constructor vacío para crear un objeto Huesped sin inicializar sus
     * atributos.
     */
    public Huesped() {
    }

    /**
     * Constructor para crear un objeto Huesped con los atributos especificados.
     *
     * @param nombre el nombre del huésped
     * @param apellido el apellido del huésped
     * @param fechaNacimiento la fecha de nacimiento del huésped
     * @param nacionalidad la nacionalidad del huésped
     * @param telefono el teléfono del huésped
     */
    public Huesped(String nombre, String apellido, LocalDate fechaNacimiento, String nacionalidad, String telefono) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.nacionalidad = nacionalidad;
        this.telefono = telefono;
    }

    /**
     * Constructor para crear un objeto Huesped con ID y atributos adicionales.
     *
     * @param id el identificador único del huésped
     * @param nombre el nombre del huésped
     * @param apellido el apellido del huésped
     * @param fechaNacimiento la fecha de nacimiento del huésped
     * @param nacionalidad la nacionalidad del huésped
     * @param telefono el teléfono del huésped
     */
    public Huesped(Integer id, String nombre, String apellido, LocalDate fechaNacimiento, String nacionalidad,
            String telefono) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fechaNacimiento = fechaNacimiento;
        this.nacionalidad = nacionalidad;
        this.telefono = telefono;
    }

    // Métodos getter y setter
    /**
     * Obtiene el identificador del huésped.
     *
     * @return el ID del huésped
     */
    public int getId() {
        return id;
    }

    /**
     * Establece el identificador del huésped.
     *
     * @param id el ID del huésped
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Obtiene el nombre del huésped.
     *
     * @return el nombre del huésped
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Establece el nombre del huésped.
     *
     * @param nombre el nombre del huésped
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * Obtiene el apellido del huésped.
     *
     * @return el apellido del huésped
     */
    public String getApellido() {
        return apellido;
    }

    /**
     * Establece el apellido del huésped.
     *
     * @param apellido el apellido del huésped
     */
    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    /**
     * Obtiene la fecha de nacimiento del huésped.
     *
     * @return la fecha de nacimiento del huésped
     */
    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    /**
     * Establece la fecha de nacimiento del huésped.
     *
     * @param fechaNacimiento la fecha de nacimiento del huésped
     */
    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    /**
     * Obtiene la nacionalidad del huésped.
     *
     * @return la nacionalidad del huésped
     */
    public String getNacionalidad() {
        return nacionalidad;
    }

    /**
     * Establece la nacionalidad del huésped.
     *
     * @param nacionalidad la nacionalidad del huésped
     */
    public void setNacionalidad(String nacionalidad) {
        this.nacionalidad = nacionalidad;
    }

    /**
     * Obtiene el teléfono del huésped.
     *
     * @return el teléfono del huésped
     */
    public String getTelefono() {
        return telefono;
    }

    /**
     * Establece el teléfono del huésped.
     *
     * @param telefono el teléfono del huésped
     */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    // Métodos estáticos
    /**
     * Cuenta el número de huéspedes por nacionalidad.
     *
     * @param huespedes la lista de huéspedes a analizar 
     * {@code ArrayList<Huesped>}
     * @return un {@code Map<String,Integer>} con el conteo por nacionalidad
     */
    public static Map<String, Integer> contarHuespedesPorNacionalidad(ArrayList<Huesped> huespedes) {
        Map<String, Integer> nacionalidadesCount = new HashMap<>();
        for (Huesped huesped : huespedes) {
            String nacionalidad = huesped.getNacionalidad();
            nacionalidadesCount.put(nacionalidad, nacionalidadesCount.getOrDefault(nacionalidad, 0) + 1);
        }
        return nacionalidadesCount;
    }

    /**
     * Busca un huésped por su identificador.
     *
     * @param huespedes la lista de huéspedes a buscar 
     * {@code ArrayList<Huesped>}
     * @param id el identificador a buscar
     * @return el Huesped encontrado o null si no se encuentra
     */
    public static Huesped buscarHuespedPorId(ArrayList<Huesped> huespedes, int id) {
        for (Huesped huesped : huespedes) {
            if (huesped.getId() == id) {
                return huesped;
            }
        }
        return null;
    }

    /**
     * Calcula la edad promedio de los huéspedes.
     *
     * @param huespedes la lista de huéspedes {@code ArrayList<Huesped>}
     * @return la edad promedio
     */
    public static int calcularEdadPromedio(ArrayList<Huesped> huespedes) {
        if (huespedes.isEmpty()) {
            return 0;
        }
        int sumaEdades = 0;
        for (Huesped huesped : huespedes) {
            sumaEdades += calcularEdad(huesped.getFechaNacimiento());
        }
        return sumaEdades / huespedes.size();
    }

    /**
     * Cuenta el número de huéspedes por rangos de edad.
     *
     * @param huespedes la lista de huéspedes {@code ArrayList<Huesped>}
     * @return Un {@code Map<String,Integer>} con el conteo de huéspedes por 
     * rangos de edad
     */
    public static Map<String, Integer> contarPorRangosDeEdad(ArrayList<Huesped> huespedes) {
        Map<String, Integer> rangosDeEdad = new HashMap<>();
        rangosDeEdad.put("18-30", 0);
        rangosDeEdad.put("31-50", 0);
        rangosDeEdad.put("51+", 0);
        for (Huesped huesped : huespedes) {
            int edad = calcularEdad(huesped.getFechaNacimiento());
            if (edad >= 18 && edad <= 30) {
                rangosDeEdad.put("18-30", rangosDeEdad.get("18-30") + 1);
            } else if (edad >= 31 && edad <= 50) {
                rangosDeEdad.put("31-50", rangosDeEdad.get("31-50") + 1);
            } else if (edad > 50) {
                rangosDeEdad.put("51+", rangosDeEdad.get("51+") + 1);
            }
        }
        return rangosDeEdad;
    }

    /**
     * Calcula la edad de un huésped a partir de su fecha de nacimiento.
     *
     * @param fechaNacimiento la fecha de nacimiento del huésped
     * {@code ArrayList<Huesped>}
     * @return la edad del huésped en años
     */
    private static int calcularEdad(LocalDate fechaNacimiento) {
        return Period.between(fechaNacimiento, LocalDate.now()).getYears();
    }

    /**
     * Encuentra los nombres más comunes entre los huéspedes.
     *
     * @param huespedes la lista de huéspedes {@code ArrayList<Huesped>}
     * @return Un {@code Map<String,Integer>} con el conteo de nombres más 
     * comunes
     */
    public static Map<String, Integer> nombresMasComunes(ArrayList<Huesped> huespedes) {
        Map<String, Integer> conteoNombres = new HashMap<>();
        for (Huesped huesped : huespedes) {
            String nombre = huesped.getNombre();
            conteoNombres.put(nombre, conteoNombres.getOrDefault(nombre, 0) + 1);
        }
        return conteoNombres;
    }

    /**
     * Encuentra los apellidos más comunes entre los huéspedes.
     *
     * @param huespedes la lista de huéspedes {@code ArrayList<Huesped>}
     * @return Un {@code Map<String,Integer>} con el conteo de apellidos más 
     * comunes
     */
    public static Map<String, Integer> apellidosMasComunes(ArrayList<Huesped> huespedes) {
        Map<String, Integer> conteoApellidos = new HashMap<>();

        // Contar la cantidad de veces que aparece cada apellido
        for (Huesped huesped : huespedes) {
            String apellido = huesped.getApellido();
            conteoApellidos.put(apellido, conteoApellidos.getOrDefault(apellido, 0) + 1);
        }

        return conteoApellidos;
    }

    /**
     * Obtiene una lista de nacionalidades fijas.
     *
     * <p>
     * Esta función devuelve un {@code ArrayList} que contiene nombres de
     * diferentes países del mundo como nacionalidades. La lista es estática y
     * contiene una colección predefinida de nacionalidades. Puede ser utilizada
     * para proporcionar opciones en formularios o interfaces donde se requiera
     * seleccionar una nacionalidad.</p>
     *
     * @return Un {@code ArrayList<String>} que contiene los nombres de
     * nacionalidades.
     */
    public static ArrayList<String> obtenerNacionalidadesFijas() {
        ArrayList<String> nacionalidades = new ArrayList<>();

        nacionalidades.add("Afganistán");
        nacionalidades.add("Albania");
        nacionalidades.add("Alemania");
        nacionalidades.add("Andorra");
        nacionalidades.add("Angola");
        nacionalidades.add("Antigua y Barbuda");
        nacionalidades.add("Arabia Saudita");
        nacionalidades.add("Argelia");
        nacionalidades.add("Argentina");
        nacionalidades.add("Armenia");
        nacionalidades.add("Australia");
        nacionalidades.add("Austria");
        nacionalidades.add("Azerbaiyán");
        nacionalidades.add("Bahamas");
        nacionalidades.add("Bangladés");
        nacionalidades.add("Barbados");
        nacionalidades.add("Baréin");
        nacionalidades.add("Bélgica");
        nacionalidades.add("Belice");
        nacionalidades.add("Benín");
        nacionalidades.add("Bielorrusia");
        nacionalidades.add("Birmania");
        nacionalidades.add("Bolivia");
        nacionalidades.add("Bosnia y Herzegovina");
        nacionalidades.add("Botsuana");
        nacionalidades.add("Brasil");
        nacionalidades.add("Brunéi");
        nacionalidades.add("Bulgaria");
        nacionalidades.add("Burkina Faso");
        nacionalidades.add("Burundi");
        nacionalidades.add("Bután");
        nacionalidades.add("Cabo Verde");
        nacionalidades.add("Camboya");
        nacionalidades.add("Camerún");
        nacionalidades.add("Canadá");
        nacionalidades.add("Catar");
        nacionalidades.add("Chad");
        nacionalidades.add("Chile");
        nacionalidades.add("China");
        nacionalidades.add("Chipre");
        nacionalidades.add("Colombia");
        nacionalidades.add("Comoras");
        nacionalidades.add("Congo");
        nacionalidades.add("Corea del Norte");
        nacionalidades.add("Corea del Sur");
        nacionalidades.add("Costa de Marfil");
        nacionalidades.add("Costa Rica");
        nacionalidades.add("Croacia");
        nacionalidades.add("Cuba");
        nacionalidades.add("Dinamarca");
        nacionalidades.add("Dominica");
        nacionalidades.add("Ecuador");
        nacionalidades.add("Egipto");
        nacionalidades.add("El Salvador");
        nacionalidades.add("Emiratos Árabes Unidos");
        nacionalidades.add("Eritrea");
        nacionalidades.add("Eslovaquia");
        nacionalidades.add("Eslovenia");
        nacionalidades.add("España");
        nacionalidades.add("Estados Unidos");
        nacionalidades.add("Estonia");
        nacionalidades.add("Esuatini");
        nacionalidades.add("Etiopía");
        nacionalidades.add("Filipinas");
        nacionalidades.add("Finlandia");
        nacionalidades.add("Fiyi");
        nacionalidades.add("Francia");
        nacionalidades.add("Gabón");
        nacionalidades.add("Gambia");
        nacionalidades.add("Georgia");
        nacionalidades.add("Ghana");
        nacionalidades.add("Granada");
        nacionalidades.add("Grecia");
        nacionalidades.add("Guatemala");
        nacionalidades.add("Guinea");
        nacionalidades.add("Guinea-Bisáu");
        nacionalidades.add("Guinea Ecuatorial");
        nacionalidades.add("Guyana");
        nacionalidades.add("Haití");
        nacionalidades.add("Honduras");
        nacionalidades.add("Hungría");
        nacionalidades.add("India");
        nacionalidades.add("Indonesia");
        nacionalidades.add("Irak");
        nacionalidades.add("Irán");
        nacionalidades.add("Irlanda");
        nacionalidades.add("Islandia");
        nacionalidades.add("Islas Marshall");
        nacionalidades.add("Islas Salomón");
        nacionalidades.add("Israel");
        nacionalidades.add("Italia");
        nacionalidades.add("Jamaica");
        nacionalidades.add("Japón");
        nacionalidades.add("Jordania");
        nacionalidades.add("Kazajistán");
        nacionalidades.add("Kenia");
        nacionalidades.add("Kirguistán");
        nacionalidades.add("Kiribati");
        nacionalidades.add("Kuwait");
        nacionalidades.add("Laos");
        nacionalidades.add("Lesoto");
        nacionalidades.add("Letonia");
        nacionalidades.add("Líbano");
        nacionalidades.add("Liberia");
        nacionalidades.add("Libia");
        nacionalidades.add("Liechtenstein");
        nacionalidades.add("Lituania");
        nacionalidades.add("Luxemburgo");
        nacionalidades.add("Madagascar");
        nacionalidades.add("Malasia");
        nacionalidades.add("Malaui");
        nacionalidades.add("Maldivas");
        nacionalidades.add("Malí");
        nacionalidades.add("Malta");
        nacionalidades.add("Marruecos");
        nacionalidades.add("Mauricio");
        nacionalidades.add("Mauritania");
        nacionalidades.add("México");
        nacionalidades.add("Micronesia");
        nacionalidades.add("Moldavia");
        nacionalidades.add("Mónaco");
        nacionalidades.add("Mongolia");
        nacionalidades.add("Montenegro");
        nacionalidades.add("Mozambique");
        nacionalidades.add("Namibia");
        nacionalidades.add("Nauru");
        nacionalidades.add("Nepal");
        nacionalidades.add("Nicaragua");
        nacionalidades.add("Níger");
        nacionalidades.add("Nigeria");
        nacionalidades.add("Noruega");
        nacionalidades.add("Nueva Zelanda");
        nacionalidades.add("Omán");
        nacionalidades.add("Países Bajos");
        nacionalidades.add("Pakistán");
        nacionalidades.add("Palaos");
        nacionalidades.add("Panamá");
        nacionalidades.add("Papúa Nueva Guinea");
        nacionalidades.add("Paraguay");
        nacionalidades.add("Perú");
        nacionalidades.add("Polonia");
        nacionalidades.add("Portugal");
        nacionalidades.add("Reino Unido");
        nacionalidades.add("República Centroafricana");
        nacionalidades.add("República Checa");
        nacionalidades.add("República Democrática del Congo");
        nacionalidades.add("República Dominicana");
        nacionalidades.add("Ruanda");
        nacionalidades.add("Rumania");
        nacionalidades.add("Rusia");
        nacionalidades.add("Samoa");
        nacionalidades.add("San Cristóbal y Nieves");
        nacionalidades.add("San Marino");
        nacionalidades.add("San Vicente y las Granadinas");
        nacionalidades.add("Santa Lucía");
        nacionalidades.add("Santo Tomé y Príncipe");
        nacionalidades.add("Senegal");
        nacionalidades.add("Serbia");
        nacionalidades.add("Seychelles");
        nacionalidades.add("Sierra Leona");
        nacionalidades.add("Singapur");
        nacionalidades.add("Siria");
        nacionalidades.add("Somalia");
        nacionalidades.add("Sri Lanka");
        nacionalidades.add("Sudáfrica");
        nacionalidades.add("Sudán");
        nacionalidades.add("Sudán del Sur");
        nacionalidades.add("Suecia");
        nacionalidades.add("Suiza");
        nacionalidades.add("Surinam");
        nacionalidades.add("Tailandia");
        nacionalidades.add("Tanzania");
        nacionalidades.add("Tayikistán");
        nacionalidades.add("Timor Oriental");
        nacionalidades.add("Togo");
        nacionalidades.add("Tonga");
        nacionalidades.add("Trinidad y Tobago");
        nacionalidades.add("Túnez");
        nacionalidades.add("Turkmenistán");
        nacionalidades.add("Turquía");
        nacionalidades.add("Tuvalu");
        nacionalidades.add("Ucrania");
        nacionalidades.add("Uganda");
        nacionalidades.add("Uruguay");
        nacionalidades.add("Uzbekistán");
        nacionalidades.add("Vanuatu");
        nacionalidades.add("Vaticano");
        nacionalidades.add("Venezuela");
        nacionalidades.add("Vietnam");
        nacionalidades.add("Yemen");
        nacionalidades.add("Yibuti");
        nacionalidades.add("Zambia");
        nacionalidades.add("Zimbabue");

        return nacionalidades;
    }

    /**
     * Sobreescribe el metodo toString para la Clase Huesped.
     * @return el estado del Huesped
     */
    @Override
    public String toString() {
        return "Huesped " + "ID: " + id + ", Nombre completo: " + nombre + " " + apellido + ", Fecha de nacimiento: " + fechaNacimiento
                + ", Nacionalidad: " + nacionalidad + ", Telefono: " + telefono;
    }

}