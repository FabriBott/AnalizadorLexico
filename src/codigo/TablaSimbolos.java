package codigo;

import java.util.HashMap;

public class TablaSimbolos {
    private HashMap<String, String> tabla = new HashMap<>();

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
}
