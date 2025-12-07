package codigo;

import java.util.ArrayList;
import java.util.HashMap;
import codigo.EntradaFuncion;

public class TablaSimbolos {
    private HashMap<String, String> tabla = new HashMap<>();
    private HashMap<String, EntradaFuncion> tablaFunciones = new HashMap<>();

    public boolean existe(String id) {
        return tabla.containsKey(id);
    }

    public boolean insertar(String id, String tipo) {
        if (existe(id)) return false;
        tabla.put(id, tipo);
        return true;
    }

    public String tipoDe(String id) {
        return tabla.get(id);
    }

    public void insertarFuncion(String nombre, String tipoRetorno, ArrayList<String> tiposParam) {
        EntradaFuncion ef = new EntradaFuncion();
        ef.tipoRetorno = tipoRetorno;
        ef.tiposParametros = tiposParam;
        ef.numParametros = tiposParam.size();
        tablaFunciones.put(nombre, ef);
    }
    
    public EntradaFuncion obtenerFuncion(String nombre) {
        return tablaFunciones.get(nombre);
    }
}
