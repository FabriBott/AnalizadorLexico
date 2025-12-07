package codigo;

import java.util.ArrayList;
import java.io.FileWriter;
import java.io.IOException;

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

    public void genAsignacion(String id, Object val) {
        String temp = nuevoTemporal();
        emit(temp + " = " + val);
        emit(id + " = " + temp);
    }

    public String getCodigo() {
        StringBuilder sb = new StringBuilder();
        for (String i : instrucciones) sb.append(i).append("\n");
        return sb.toString();
    }
    public void generarArchivo(String nombreArchivo) {
        try (FileWriter fw = new FileWriter(nombreArchivo)) {
            for (String i : instrucciones) {
                fw.write(i + "\n");
            }
            System.out.println("Archivo ensamblador generado: " + nombreArchivo);
        } catch (IOException e) {
            System.out.println("Error al generar archivo ASM: " + e.getMessage());
        }
    }

}
