import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.Vector;
%% //Options of the scanner

%class LexicalAnalyzer //Name
%unicode
%line  //Use line counter (yyline variable)
%column // Use column counter (yycolumn variable)
%standalone //JFlex does not need a parser
%type Symbol 
%public
%function nextToken
%xstate YYINITIAL, DECIMAL_SN, C99_VAR, REL_OPE, CONDITION_STATEMENT
%{ //start the java code


            private java.util.Map<String, Integer> symbolTable = new TreeMap<>();
            private Vector<Symbol> symbols = new Vector<>();

            public java.util.Map<String, Integer> getSymbolTable(){
                return this.symbolTable;
            }

            public java.util.Vector<Symbol> getSymbols(){
                return this.symbols;
            }

            /**
            * Creates a symbol corresponding to the token that we met, then adds it to the symbol
            * table if needed. And in all cases to the vector of symbols.
            *
            * @param lexicalUnit : The lexical type of the token that we met.
            * @return the symbol created.
            */
            private Symbol addToSymbolsStructures(LexicalUnit lexicalUnit){
                Symbol symbol = new Symbol(lexicalUnit, yyline, yycolumn, yytext());
                if (symbol.getType() == LexicalUnit.VARNAME) {
                    symbolTable.compute(symbol.getValue().toString(), (k, v) -> (v == null) ? 1 : v + 1);
                }
                symbols.add(symbol);
                return symbol;

            }

            /**
            * Handle the end of file
            * @return the symbol corresponding to the END OF FILE
            */
            private Symbol endOfFile(){
                Symbol symbol = new Symbol(LexicalUnit.END_OF_STREAM, yyline, yycolumn);
                symbols.add(symbol);
                return symbol;
            }



%}
%eofval{
	return endOfFile();
    //return new Symbol(LexicalUnit.END_OF_STREAM, yyline, yycolumn);
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
    "begin" { addToSymbolsStructures(LexicalUnit.BEG);}
    "end" { addToSymbolsStructures(LexicalUnit.END);}

    ";" { addToSymbolsStructures(LexicalUnit.SEMICOLON);}
    ":=" { addToSymbolsStructures(LexicalUnit.ASSIGN);}

    "(" { addToSymbolsStructures(LexicalUnit.LPAREN);}
    ")" { addToSymbolsStructures(LexicalUnit.RPAREN);}

    //Arithmetic Operators
    "-" { addToSymbolsStructures(LexicalUnit.MINUS);}
    "+" { addToSymbolsStructures(LexicalUnit.PLUS);}
    "*" { addToSymbolsStructures(LexicalUnit.TIMES);}
    "/" { addToSymbolsStructures(LexicalUnit.DIVIDE);}

    
    //If
    "if" { addToSymbolsStructures(LexicalUnit.IF);}
    "then" { addToSymbolsStructures(LexicalUnit.THEN);}
    "endif" { addToSymbolsStructures(LexicalUnit.ENDIF);}
    "else" { addToSymbolsStructures(LexicalUnit.ELSE);}

    //Comparaison operators
    "not" { addToSymbolsStructures(LexicalUnit.NOT);}
    "=" { addToSymbolsStructures(LexicalUnit.EQUAL);}
    ">" { addToSymbolsStructures(LexicalUnit.GREATER);}
    "<" { addToSymbolsStructures(LexicalUnit.SMALLER);}

    //While
    "while" { addToSymbolsStructures(LexicalUnit.WHILE);}
    "do" { addToSymbolsStructures(LexicalUnit.DO);}
    "endwhile" { addToSymbolsStructures(LexicalUnit.ENDWHILE);}

    //For
    "for"  { addToSymbolsStructures(LexicalUnit.FOR);}
    "from" { addToSymbolsStructures(LexicalUnit.FROM);}
    "by" { addToSymbolsStructures(LexicalUnit.BY);}
    "to" { addToSymbolsStructures(LexicalUnit.TO);}
    "endfor" { addToSymbolsStructures(LexicalUnit.ENDFOR);}

    //IO
    "print" { addToSymbolsStructures(LexicalUnit.PRINT);}
    "read" { addToSymbolsStructures(LexicalUnit.READ);}
   {VarName} { addToSymbolsStructures(LexicalUnit.VARNAME);}
   {Number} { addToSymbolsStructures(LexicalUnit.NUMBER);}

   {BigCom} {}
   {SmallCom} {}
   . {}
