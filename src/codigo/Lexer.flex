package codigo;
import static codigo.Tokens.*;

%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ \t\r\n]+

%{
    public String lexeme;
%}

%%

// ignorar los comentarios 
\{([^}]|\n)*\}     { /*ignorar*/ }
\(\*([^*]|(\*[^)])|\n)*\*\) { /*ignorar*/ }

// palabras reservadas
ABSOLUTE|AND|ARRAY|BEGIN|CASE|
CONST|CONSTRUCTOR|DESTRUCTOR|EXTERNAL|
DIV|DO|DOWNTO|ELSE|END|FILE|FOR|FORWARD|
FUNCTION|GOTO|IF|IMPLEMENTATION|IN|INLINE|
INTERFACE|INTERRUPT|LABEL|MOD|NIL|NOT|
OBJECT|OF|OR|PACKED|PRIVATE|PROCEDURE|
RECORD|REPEAT|SET|SHL|SHR|STRING|
THEN|TO|TYPE|UNIT|UNTIL|USES|
VAR|VIRTUAL|WHILE|WITH|XOR {
    lexeme = yytext();
    return PALABRARESERVADA;
}

// literales
\"[^\"\n]*\" {
    lexeme = yytext();
    return STRING;
}

// Char: un solo carácter entre comillas simples
'[^'\n]' {
    lexeme = yytext();
    return CHAR;
}

// números reales con opcional exponente
({D}+\.{D}+|\.{D}+)([Ee][+-]?{D}+)? {
    lexeme = yytext();
    return REAL;
}

// operadores
("+"|"-"|"*"|"/"|"DIV"|"MOD"|"NOT"|"AND"|"OR"|"="|"<>"
|"<"|">"|"<="|">="|"IN"|","|";"|"++"|"--"|"("|")"
|"["|"]"|":"|"."|"^"|"**") {
    lexeme = yytext();
    return OPERADORES;
}

// identificadores
{L}({L}|{D}){0,126} {
    lexeme = yytext();
    return IDENTIFICADOR;
}

// enteros
{D}+ {
    lexeme = yytext();
    return ENTERO;
}

// ignorar espacios
{espacio} { /*ignorar*/ }

// cualquier otro caracter => ERROR
. {
    lexeme = yytext();
    return ERROR;
}
