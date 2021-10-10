package src;
%% //Options of the scanner

%class LexicalAnalyzer //Name
%unicode
%line  //Use line counter (yyline variable)
%column // Use column counter (yycolumn variable)
%standalone //JFlex do not need a parser
%type Symbol 

%xstate YYINITIAL, DECIMAL_SN, C99_VAR, REL_OPE, CONDITION_STATEMENT
%{ //start the java code
    
%}
%eofval{
	return new Symbol(LexicalUnit.END_OF_STREAM, yyline, yycolumn);
%eofval}
%eof{

%eof}



//Extended RegEx
//whitespace = [\t\n]+

Digit = [0-9]

AlphaLower = [a-z]
AlphaUpper = [A-Z]
Alpha = {AlphaLower} | {AlphaUpper}
AlphaNum = {Alpha} | {Digit}

VarName = {Alpha} {AlphaNum}*
Number = {Digit}+
BigCom = "CO"~"CO"
SmallCom = "co".*

%% //identification of tokens

    {VarName} //todo
    {Number} //todo
    {BigCom} //todo
    {SmallCom} //todo
    "begin" //todo
    "end" //todo

    ";" //todo
    ":=" //todo

    "(" //todo
    ")" //todo

    //Arithmetic Operators
    "-" //todo
    "+" //todo
    "*" //todo
    "/" //todo

    
    //If
    "if" {System.out.println("IF: "+ yytext()); return new Symbol(LexicalUnit.IF, yyline, yycolumn);}
    "then" {System.out.println("THEN: "+ yytext()); return new Symbol(LexicalUnit.THEN, yyline, yycolumn);}
    "endif" {System.out.println("ENDIF: "+ yytext()); return new Symbol(LexicalUnit.ENDIF, yyline, yycolumn);}
    "else" {System.out.println("ELSE: "+ yytext()); return new Symbol(LexicalUnit.ELSE, yyline, yycolumn);}

    //Comparaison operators
    "!" {System.out.println("NOT: " + yytext());return new Symbol(LexicalUnit.NOT, yyline, yycolumn);}
    "=" {System.out.println("EQUAL: "+ yytext()); return new Symbol(LexicalUnit.EQUAL, yyline, yycolumn);}
    ">" {System.out.println("GREATER: "+ yytext()); return new Symbol(LexicalUnit.GREATER, yyline, yycolumn);}
    "<" {System.out.println("SMALLER: "+ yytext()); return new Symbol(LexicalUnit.SMALLER, yyline, yycolumn);}

    //While
    "while" //todo
    "do" //todo
    "endwhile" //todo

    //For
    "for"  //todo
    "from" //todo
    "by" //todo
    "to" //todo
    "endfor"

    //IO
    "print" //todo
    "read" //todo

    . {}
