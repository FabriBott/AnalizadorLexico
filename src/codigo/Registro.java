package codigo;

import java.util.ArrayList;

public class Registro {
    public String tipo; // INT, REAL, PROCEDURE, FUNCTION_INT, etc
    public String lexema; // nombre de variable/función
    public String valor; // para constantes (Constant Folding)
    public String lugar; // nombre del temporal generado (t1, t2...)
    public String codigo; // código intermedio generado por este nodo

    // **NUEVO:** Almacena los tipos de los parámetros formales de una
    // función/procedimiento
    public ArrayList<String> tiposParametros;

    public Registro() {
        this.tiposParametros = new ArrayList<>();
    }
}