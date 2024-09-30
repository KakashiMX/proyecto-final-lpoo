/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.Arrays;
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
            String telefono, Integer id) {
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

    public static Map<String, Integer> contarHuespedesPorNacionalidad(ArrayList<Huesped> huespedes) {
        Map<String, Integer> nacionalidadesCount = new HashMap<>();

        for (Huesped huesped : huespedes) {
            String nacionalidad = huesped.getNacionalidad();

            // Si ya existe la nacionalidad en el mapa, se incrementa el contador
            nacionalidadesCount.put(nacionalidad, nacionalidadesCount.getOrDefault(nacionalidad, 0) + 1);
        }

        return nacionalidadesCount;
    }

    public static Huesped buscarHuespedPorId(ArrayList<Huesped> huespedes, int id) {
        for (Huesped huesped : huespedes) {
            if (huesped.getId() == id) {
                return huesped; // Si el id coincide, devolver el huésped
            }
        }
        return null; // Si no se encuentra, devolver null
    }

    // Método para calcular la edad promedio
    public static int calcularEdadPromedio(ArrayList<Huesped> huespedes) {
        if (huespedes.isEmpty()) {
            return 0; // Evitar división por cero
        }

        int sumaEdades = 0;

        for (Huesped huesped : huespedes) {
            sumaEdades += calcularEdad(huesped.getFechaNacimiento());
        }

        return sumaEdades / huespedes.size();
    }

    // Método para contar la cantidad de huéspedes por rangos de edad
    public static Map<String, Integer> contarPorRangosDeEdad(ArrayList<Huesped> huespedes) {
        // Inicializar un mapa para los rangos de edad
        Map<String, Integer> rangosDeEdad = new HashMap<>();
        rangosDeEdad.put("18-30", 0);
        rangosDeEdad.put("31-50", 0);
        rangosDeEdad.put("51+", 0);

        // Recorrer la lista de huéspedes y contar en función de su edad
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

    // Método para calcular la edad a partir de la fecha de nacimiento
    private static int calcularEdad(LocalDate fechaNacimiento) {
        return Period.between(fechaNacimiento, LocalDate.now()).getYears();
    }

    // Método para encontrar los nombres más comunes
    public static Map<String, Integer> nombresMasComunes(ArrayList<Huesped> huespedes) {
        Map<String, Integer> conteoNombres = new HashMap<>();

        // Contar la cantidad de veces que aparece cada nombre
        for (Huesped huesped : huespedes) {
            String nombre = huesped.getNombre();
            conteoNombres.put(nombre, conteoNombres.getOrDefault(nombre, 0) + 1);
        }

        return conteoNombres;
    }

    // Método para encontrar los apellidos más comunes
    public static Map<String, Integer> apellidosMasComunes(ArrayList<Huesped> huespedes) {
        Map<String, Integer> conteoApellidos = new HashMap<>();

        // Contar la cantidad de veces que aparece cada apellido
        for (Huesped huesped : huespedes) {
            String apellido = huesped.getApellido();
            conteoApellidos.put(apellido, conteoApellidos.getOrDefault(apellido, 0) + 1);
        }

        return conteoApellidos;
    }
    
     public static ArrayList<String> obtenerNacionalidadesFijas() {
        return new ArrayList<>(Arrays.asList(
            "Afganistán", "Albania", "Alemania", "Andorra", "Angola", "Antigua y Barbuda", 
            "Arabia Saudita", "Argelia", "Argentina", "Armenia", "Australia", "Austria", 
            "Azerbaiyán", "Bahamas", "Bangladés", "Barbados", "Baréin", "Bélgica", 
            "Belice", "Benín", "Bielorrusia", "Birmania", "Bolivia", "Bosnia y Herzegovina", 
            "Botsuana", "Brasil", "Brunéi", "Bulgaria", "Burkina Faso", "Burundi", 
            "Bután", "Cabo Verde", "Camboya", "Camerún", "Canadá", "Catar", 
            "Chad", "Chile", "China", "Chipre", "Colombia", "Comoras", 
            "Congo", "Corea del Norte", "Corea del Sur", "Costa de Marfil", "Costa Rica", "Croacia", 
            "Cuba", "Dinamarca", "Dominica", "Ecuador", "Egipto", "El Salvador", 
            "Emiratos Árabes Unidos", "Eritrea", "Eslovaquia", "Eslovenia", "España", "Estados Unidos", 
            "Estonia", "Esuatini", "Etiopía", "Filipinas", "Finlandia", "Fiyi", 
            "Francia", "Gabón", "Gambia", "Georgia", "Ghana", "Granada", 
            "Grecia", "Guatemala", "Guinea", "Guinea-Bisáu", "Guinea Ecuatorial", "Guyana", 
            "Haití", "Honduras", "Hungría", "India", "Indonesia", "Irak", 
            "Irán", "Irlanda", "Islandia", "Islas Marshall", "Islas Salomón", "Israel", 
            "Italia", "Jamaica", "Japón", "Jordania", "Kazajistán", "Kenia", 
            "Kirguistán", "Kiribati", "Kuwait", "Laos", "Lesoto", "Letonia", 
            "Líbano", "Liberia", "Libia", "Liechtenstein", "Lituania", "Luxemburgo", 
            "Madagascar", "Malasia", "Malaui", "Maldivas", "Malí", "Malta", 
            "Marruecos", "Mauricio", "Mauritania", "México", "Micronesia", "Moldavia", 
            "Mónaco", "Mongolia", "Montenegro", "Mozambique", "Namibia", "Nauru", 
            "Nepal", "Nicaragua", "Níger", "Nigeria", "Noruega", "Nueva Zelanda", 
            "Omán", "Países Bajos", "Pakistán", "Palaos", "Panamá", "Papúa Nueva Guinea", 
            "Paraguay", "Perú", "Polonia", "Portugal", "Reino Unido", "República Centroafricana", 
            "República Checa", "República Democrática del Congo", "República Dominicana", "Ruanda", "Rumania", "Rusia", 
            "Samoa", "San Cristóbal y Nieves", "San Marino", "San Vicente y las Granadinas", "Santa Lucía", "Santo Tomé y Príncipe", 
            "Senegal", "Serbia", "Seychelles", "Sierra Leona", "Singapur", "Siria", 
            "Somalia", "Sri Lanka", "Sudáfrica", "Sudán", "Sudán del Sur", "Suecia", 
            "Suiza", "Surinam", "Tailandia", "Tanzania", "Tayikistán", "Timor Oriental", 
            "Togo", "Tonga", "Trinidad y Tobago", "Túnez", "Turkmenistán", "Turquía", 
            "Tuvalu", "Ucrania", "Uganda", "Uruguay", "Uzbekistán", "Vanuatu", 
            "Vaticano", "Venezuela", "Vietnam", "Yemen", "Yibuti", "Zambia", 
            "Zimbabue"
        ));
    }

    @Override
    public String toString() {
        return "Huesped " + "ID: " + id + ", Nombre completo: " + nombre + " " + apellido + ", Fecha de nacimiento: " + fechaNacimiento
                + ", Nacionalidad: " + nacionalidad + ", Telefono: " + telefono;
    }

}
