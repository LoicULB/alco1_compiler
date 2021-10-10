%% //Options of the scanner

%class Lexer5 //Name
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

RelationnalOpe = \< | \> | "==" | "!=" | "<=" | ">=" | "!"
Digit = [0-9]
Integer = [0-9]+
DecimalPart= "." {Integer}
Sign = "+" | "-"
ExponentialPart = "E"  {Sign}? {Integer}
SciNumber = "-"? {Integer} {DecimalPart}? {ExponentialPart}?

AlphaLower = [a-z]
AlphaUpper = [A-Z]
Alpha = {AlphaLower} | {AlphaUpper}
AlphaNum = {Alpha} | {Digit}

C99VarStr = {Alpha} ({AlphaNum} | "_")*
//C99Var = ("\n" {C99VarStr} ) | (" " {C99VarStr})



%% //identification of tokens

    //Comparaison operators
    "!" {System.out.println("NOT: " + yytext());return new Symbol(LexicalUnit.NOT, yyline, yycolumn);}
    "<" {System.out.println("SMALLER: "+ yytext()); return new Symbol(LexicalUnit.SMALLER, yyline, yycolumn);}
    ">" {System.out.println("GREATER: "+ yytext()); return new Symbol(LexicalUnit.GREATER, yyline, yycolumn);}
    "=" {System.out.println("EQUAL: "+ yytext()); return new Symbol(LexicalUnit.EQUAL, yyline, yycolumn);}  
    
    
    //If
    "if" {System.out.println("IF: "+ yytext()); return new Symbol(LexicalUnit.IF, yyline, yycolumn);}
    "endif" {System.out.println("ENDIF: "+ yytext()); return new Symbol(LexicalUnit.ENDIF, yyline, yycolumn);}
    "else" {System.out.println("ELSE: "+ yytext()); return new Symbol(LexicalUnit.ELSE, yyline, yycolumn);}
    "then" {System.out.println("THEN: "+ yytext()); return new Symbol(LexicalUnit.THEN, yyline, yycolumn);}
    //how to apply word regex
    {SciNumber} {System.out.println("FLOAT: "+ yytext()); return new Symbol(LexicalUnit.FLOAT, yyline, yycolumn);}
    //^C99VarStr |  " " {C99VarStr}  {System.out.println("C99VAR: "+ yytext()); return new Symbol(LexicalUnit.C99VAR, yyline, yycolumn);}
    {C99VarStr}  {System.out.println("C99VAR: "+ yytext()); return new Symbol(LexicalUnit.C99VAR, yyline, yycolumn);}
    
    . {}


