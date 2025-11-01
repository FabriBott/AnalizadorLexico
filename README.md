# Cómo ejecutar el compilador (JFlex + CUP + Java)
## Requisitos
- Java 8+
- JFlex (v1.9+)
- Java CUP (0.11b)

## Archivos importantes:
``` js

src/codigo/Lexer.flex
src/codigo/parser.cup
src/codigo/*.java
lib/java-cup-11b.jar
lib/jflex-full-1.9.1.jar
```

## Pasos
### 1. Generar el analizador léxico (Scanner)

``` js
java -jar lib/jflex-full-1.9.1.jar src/codigo/Lexer.flex
```

Esto genera:
``` js
src/codigo/Lexer.java
```

### 2. Generar el analizador sintáctico (Parser)

``` js
java -jar lib/java-cup-11b.jar -parser Parser -symbols sym -package codigo -destdir src/codigo src/codigo/parser.cup
```

Esto genera:
``` js
src/codigo/Parser.java
src/codigo/sym.java
```

### 3. Compilar el proyecto
``` js
javac -cp "lib/java-cup-11b.jar;src" src/codigo/*.java
```
### 4. Ejecutar el programa principal

```js
java -cp "lib/java-cup-11b.jar;src" codigo.FrmPrincipal
```
