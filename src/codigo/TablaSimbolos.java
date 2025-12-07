package codigo;

import java.util.*;

public class TablaSimbolos {

    public static class Variable {
        public String nombre;
        public String tipo;
        public String ambito;

        public Variable(String nombre, String tipo, String ambito) {
            this.nombre = nombre;
            this.tipo = tipo;
            this.ambito = ambito;
        }
    }

    public static class Funcion {
        public String nombre;
        public String tipoRetorno;
        public List<String> tiposParametros;

        public Funcion(String nombre, String tipoRetorno, List<String> tiposParametros) {
            this.nombre = nombre;
            this.tipoRetorno = tipoRetorno;
            this.tiposParametros = tiposParametros;
        }
    }

    private HashMap<String, Variable> variables = new HashMap<>();
    private HashMap<String, Funcion> funciones = new HashMap<>();

    // ================= VARIABLES =================

    public boolean existe(String id) {
        return variables.containsKey(id);
    }

    public boolean insertar(String id, String tipo, String ambito) {
        if (variables.containsKey(id + "@" + ambito)) return false;
        variables.put(id + "@" + ambito, new Variable(id, tipo, ambito));
        return true;
    }

    public void limpiarLocales() {
        variables.entrySet().removeIf(e -> e.getValue().ambito.equals("local"));
    }

    // ================= FUNCIONES =================

    public boolean existeFuncion(String nombre) {
        return funciones.containsKey(nombre);
    }

    public boolean insertarFuncion(String nombre, String tipoRetorno, List<String> tiposParams) {
        if (funciones.containsKey(nombre)) return false;
        funciones.put(nombre, new Funcion(nombre, tipoRetorno, new ArrayList<>(tiposParams)));
        return true;
    }

    public boolean validarCantidadParametros(String nombre, int cantidadReal) {
        return funciones.get(nombre).tiposParametros.size() == cantidadReal;
    }

    public boolean validarTiposParametros(String nombre, List<String> tiposReales) {
        List<String> tipos = funciones.get(nombre).tiposParametros;
        if (tipos.size() != tiposReales.size()) return false;

        for (int i = 0; i < tipos.size(); i++) {
            if (!tipos.get(i).equals(tiposReales.get(i))) return false;
        }
        return true;
    }

    //PUNTO 4
    public void imprimir() {
        System.out.println("\n========== TABLA DE SÍMBOLOS ==========");

        System.out.println("\n--- VARIABLES ---");
        for (Variable v : variables.values()) {
            System.out.println("Nombre: " + v.nombre +
                    " | Tipo: " + v.tipo +
                    " | Ámbito: " + v.ambito);
        }

        System.out.println("\n--- FUNCIONES ---");
        for (Funcion f : funciones.values()) {
            System.out.println("Nombre: " + f.nombre +
                    " | Retorno: " + f.tipoRetorno +
                    " | Parámetros: " + f.tiposParametros);
        }

        System.out.println("======================================\n");
    }
}
