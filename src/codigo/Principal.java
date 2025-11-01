package codigo;

import java.io.FileReader;
import java_cup.runtime.Symbol;

public class Principal {
    public static void main(String[] args) {
        try {
            // Análisis léxico y sintáctico
            Lexer lexer = new Lexer(new FileReader("archivo.txt"));
            Parser parser = new Parser(lexer);
            
            // Ejecutar el parser
            parser.parse();
            
            System.out.println("Análisis completado exitosamente!");
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}