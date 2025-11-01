package codigo;

import java_cup.runtime.*;

%%
%class Lexer
%unicode 
%cup    
%line
%column

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline + 1, yycolumn + 1, yytext());
    }
    
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline + 1, yycolumn + 1, value);
    }
    
    private Symbol keywordOr(String lex, int defaultType) {
        String up = lex.toUpperCase();
        switch (up) {
            case "PROGRAM":   return symbol(sym.PROGRAM);
            case "BEGIN":     return symbol(sym.BEGIN);
            case "END":       return symbol(sym.END);
            case "VAR":       return symbol(sym.VAR);
            case "INT":       return symbol(sym.INT);
            case "REAL":      return symbol(sym.REAL);
            case "CHAR":      return symbol(sym.CHAR);
            case "STRING":    return symbol(sym.STRING);
            case "FUNCTION":  return symbol(sym.FUNCTION);
            case "PROCEDURE": return symbol(sym.PROCEDURE);
            case "RETURN":    return symbol(sym.RETURN);
            case "IF":        return symbol(sym.IF);
            case "THEN":      return symbol(sym.THEN);
            case "ELSE":      return symbol(sym.ELSE);
            case "WHILE":     return symbol(sym.WHILE);
            case "DO":        return symbol(sym.DO);
            case "FOR":       return symbol(sym.FOR);
            case "TO":        return symbol(sym.TO);
            case "READ":      return symbol(sym.READ);
            case "WRITE":     return symbol(sym.WRITE);
            case "AND":       return symbol(sym.AND);
            case "OR":        return symbol(sym.OR);
            case "NOT":       return symbol(sym.NOT);
            case "DIV":       return symbol(sym.DIV);
            case "MOD":       return symbol(sym.MOD);
            default:          return symbol(defaultType, lex);
        }
    }
%}

D               = [0-9]
LineTerminator  = \r|\n|\r\n
WhiteSpace      = {LineTerminator} | [ \t\f]

/* Identificadores */
Identifier      = [a-zA-Z][a-zA-Z0-9_]*

/* Literales numéricos */
IntegerLiteral  = {D}+
RealLiteral     = ( {D}+\.{D}+ | {D}+\. | \.{D}+ ) ([Ee][+-]?{D}+)? | {D}+[Ee][+-]?{D}+

/* Otros literales */
CharLiteral     = \'([^\\\']|\\.)\'
StringLiteral   = \"([^\\\"]|\\.)*\"

/* Comentarios (3 estilos) */
LineComment     = "//" [^\r\n]*
BraceComment    = "{" [^}]* "}"
StarComment     = "(*" ([^*]|\*+[^)])* "*)"

%%
/* --- Ignorar comentarios y espacios --- */
{LineComment}  { /* Ignorar */ }
{BraceComment} { /* Ignorar */ }
{StarComment}  { /* Ignorar */ }
{WhiteSpace}   { /* Ignorar */ }

/* id seguido de ':=' -> asignación; NO es una declaración */
{Identifier}([ \t\f\r\n])*:= {
    String t   = yytext();
    String lex = t.substring(0, t.length()-2).trim(); // quita ':='
    yypushback(2);
    return keywordOr(lex, sym.ID);
}

{Identifier} {
    String lex = yytext();
    String up = lex.toUpperCase();
    switch (up) {
        case "PROGRAM": return symbol(sym.PROGRAM);
        case "BEGIN": return symbol(sym.BEGIN);
        case "END": return symbol(sym.END);
        case "VAR": return symbol(sym.VAR);
        case "INT": return symbol(sym.INT);
        case "REAL": return symbol(sym.REAL);
        case "CHAR": return symbol(sym.CHAR);
        case "STRING": return symbol(sym.STRING);
        case "FUNCTION": return symbol(sym.FUNCTION);
        case "PROCEDURE": return symbol(sym.PROCEDURE);
        case "RETURN": return symbol(sym.RETURN);
        case "IF": return symbol(sym.IF);
        case "THEN": return symbol(sym.THEN);
        case "ELSE": return symbol(sym.ELSE);
        case "WHILE": return symbol(sym.WHILE);
        case "DO": return symbol(sym.DO);
        case "FOR": return symbol(sym.FOR);
        case "TO": return symbol(sym.TO);
        case "READ": return symbol(sym.READ);
        case "WRITE": return symbol(sym.WRITE);
        case "AND": return symbol(sym.AND);
        case "OR": return symbol(sym.OR);
        case "NOT": return symbol(sym.NOT);
        case "DIV": return symbol(sym.DIV);
        case "MOD": return symbol(sym.MOD);
        default: return symbol(sym.ID, lex);
    }
}

/* Operadores y signos de puntuación */
":="          { return symbol(sym.ASSIGN); }
";"           { return symbol(sym.SEMI); }
","           { return symbol(sym.COMMA); }
"("           { return symbol(sym.LPAREN); }
")"           { return symbol(sym.RPAREN); }
"="           { return symbol(sym.EQ); }
"<>"          { return symbol(sym.NEQ); }
"<"           { return symbol(sym.LT); }
"<="          { return symbol(sym.LE); }
">"           { return symbol(sym.GT); }
">="          { return symbol(sym.GE); }
"+"           { return symbol(sym.PLUS); }
"-"           { return symbol(sym.MINUS); }
"*"           { return symbol(sym.TIMES); }
"/"           { return symbol(sym.SLASH); }
":"           { return symbol(sym.COLON); }
"++"          { return symbol(sym.INC); }
"--"          { return symbol(sym.DEC); }

/* Literales */
{RealLiteral}    { return symbol(sym.REAL_LIT, yytext()); }
{IntegerLiteral} { return symbol(sym.INT_LIT, yytext()); }
{CharLiteral}    { return symbol(sym.CHAR_LIT, yytext()); }
{StringLiteral}  { return symbol(sym.STRING_LIT, yytext()); }

/* Error léxico */
.             { return symbol(sym.ERROR, yytext()); }
<<EOF>>       { return symbol(sym.EOF); }