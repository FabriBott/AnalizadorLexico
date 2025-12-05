package codigo;

import java.util.ArrayList;

public class Codigo {
    public ArrayList<String> instrucciones = new ArrayList<>();
    private int tempCount = 0;
    private int labelCount = 0;

    public String nuevoTemporal() {
        return "t" + (tempCount++);
    }

    public String nuevaEtiqueta() {
        return "L" + (labelCount++);
    }

    public void emit(String inst) {
        instrucciones.add(inst);
    }

    public String getCodigo() {
        StringBuilder sb = new StringBuilder();
        for (String i : instrucciones) sb.append(i).append("\n");
        return sb.toString();
    }
}
