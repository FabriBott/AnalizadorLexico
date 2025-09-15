package codigo;
import static codigo.Tokens.*;

%%
%class Lexer
%type Tokens
L=[a-zA-Z_]+
D=[0-9]+
espacio=[ \t\r\n]+
%%

// ignorar los comentarios 
\{([^}]|\n)*\} {/*ignorar*/}
\(\*([^*]|(\*[^)])|\n)*\*\) {/*ignorar*/}

//definir palabras reservadas
ABSOLUTE|AND|ARRAY|BEGIN|CASE|
CONST|CONSTRUCTOR|DESTRUCTOR|EXTERNAL|
DIV|DO|DOWNTO|ELSE|END|FILE|FOR|FORWARD|
FUNCTION|GOTO|IF|IMPLEMENTATION|IN|INLINE|
INTERFACE|INTERRUPT|LABEL|MOD|NIL|NOT|
OBJECT|OF|OR|PACKED|PRIVATE|PROCEDURE|
RECORD|REPEAT|SET|SHL|SHR|STRING|
THEN|TO|TYPE|UNIT|UNTIL|USES|
VAR|VIRTUAL|WHILE|WITH|XOR  {return new Symbol(sym.PALABRARESERVADA, yytext());}

//definir literales
//strings
\"[^\n"]*\" { return new Symbol(sym.STRING, yytext()); }
//chars
\'[^']\' {return new Symbol(sym.CHAR, yytext());}
//numero real
({D}+\.{D}+|\.{D}+)([Ee][+-]?{D}+)? { return new Symbol(sym.REAL, yytext()); }

//definir operadores
"+"
|"-"
|"*"
|"/"
|"DIV"
|"MOD"
|"NOT"
|"AND"
|"OR"
|"="
|"<>"
|"<"
|">"
|"<="
|">="
|"IN"
|","
|";"
|"++"
|"--"
|"("
|")"
|"["
|"]"
|":"
|"."
|"^"
|"**"
  {return new Symbol(sym.OPERADORES, yytext());}

//definir identificadores
{L}({L}|{D}){0,126} { 
    String id = yytext().toUpperCase();
    return new Symbol(sym.IDENTIFICADOR, id); 
}