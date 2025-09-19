package codigo;

import jflex.Main;

public class Principal {
    public static void main(String[] args) {
        String ruta = "src/codigo/Lexer.flex";
        generarLexer(ruta);
    }
    
    public static void generarLexer(String ruta) {
        try {
            Main.generate(new String[]{ruta});
            System.out.println("Lexer generado correctamente.");
        } catch (jflex.exceptions.SilentExit e) {
            System.err.println("Error al generar el lexer: " + e.getMessage());
        }
    }
}
