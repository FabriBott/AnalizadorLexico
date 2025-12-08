package codigo;

import java.util.ArrayList;
import java.util.List;
import java.io.FileWriter;
import java.io.IOException;

public class Codigo {

    // Sección de datos (.DATA) y de código (.CODE)
    private List<String> data = new ArrayList<>();
    private List<String> code = new ArrayList<>();

    private int tempCount = 0;
    private int labelCount = 0;

    /* ========= TEMPORALES Y ETIQUETAS ========= */

    public String nuevoTemporal() {
        return "t" + (tempCount++);
    }

    public String nuevaEtiqueta() {
        return "L" + (labelCount++);
    }

    /* ========= EMISIÓN DE INSTRUCCIONES ========= */

    // Para código (sección .CODE)
    public void emit(String inst) {
        code.add(inst);
    }

    // Para variables globales (sección .DATA)
    public void declararVarGlobal(String nombre, String tipo) {
        // Versión simple: todo INT -> DD ?
        // Si quisieras, aquí podrías diferenciar por tipo.
        data.add(nombre + " DD ?");
    }

    /* ========= GENERACIÓN DE CÓDIGO DE ALTO NIVEL ========= */

    // Asignación: id := expr;
    public void genAsignacion(String id, Object val) {
        // Convertimos el valor de la expresión a texto
        String src;
        if (val instanceof Integer || val instanceof Double) {
            src = val.toString();
        } else if (val instanceof String) {
            src = (String) val;
        } else {
            src = String.valueOf(val);
        }

        // Versión simple: usamos un temporal y luego lo copiamos
        String t = nuevoTemporal();
        emit(t + " = " + src);
        emit(id + " = " + t);
    }

    // WRITE(x)  ->  PRINT x  (pseudo-instrucción)
    public void genWrite(List<String> nombres) {
        for(String n : nombres){
            emit("PRINT " + n);
        }
    }


    /* ========= SALIDA A ARCHIVO ========= */

    public String getCodigo() {
        StringBuilder sb = new StringBuilder();
        sb.append(".DATA\n");
        for (String d : data) {
            sb.append(d).append("\n");
        }
        sb.append("\n.CODE\n");
        for (String c : code) {
            sb.append(c).append("\n");
        }
        sb.append("end\n");
        return sb.toString();
    }

    public void generarArchivo(String nombreArchivo) {
        try (FileWriter fw = new FileWriter(nombreArchivo)) {
            fw.write(".DATA\n");
            for (String d : data) {
                fw.write(d + "\n");
            }
            fw.write("\n.CODE\n");
            for (String c : code) {
                fw.write(c + "\n");
            }
            fw.write("end\n");
            System.out.println("Archivo ensamblador generado: " + nombreArchivo);
        } catch (IOException e) {
            System.out.println("Error al generar archivo ASM: " + e.getMessage());
        }
    }
}
