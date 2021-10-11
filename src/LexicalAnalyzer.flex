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
    private java.util.HashMap<String, Integer> symbolTable = new HashMap<>();
        private Vector<Symbol> symbols = new Vector<>();

        public java.util.HashMap<String, Integer> getSymbolTable(){
            return this.symbolTable;
        }

        public java.util.Vector<Symbol> getSymbols(){
            return this.symbols;
        }

        private void addToSymbols(LexicalUnit lexicalUnit){
            Symbol symbol = new Symbol(lexicalUnit, yyline, yycolumn, yytext());
        }

        //todo deal with all the shits :)
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
    "begin" {System.out.println("BEGIN: "+ yytext()); return new Symbol(LexicalUnit.BEG, yyline, yycolumn,yytext());} //todo sout to remove
    "end" {System.out.println("END: "+ yytext()); return new Symbol(LexicalUnit.END, yyline, yycolumn,yytext());}

    ";" {System.out.println("SEMICOLON: "+ yytext()); return new Symbol(LexicalUnit.SEMICOLON, yyline, yycolumn);}
    ":=" {System.out.println("ASSIGN: "+ yytext()); return new Symbol(LexicalUnit.ASSIGN, yyline, yycolumn,yytext());}

    "(" {
          Symbol retSymbol = new Symbol(LexicalUnit.LPAREN,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    ")" {
          Symbol retSymbol = new Symbol(LexicalUnit.RPAREN,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }

    //Arithmetic Operators
    "-" {
          Symbol retSymbol = new Symbol(LexicalUnit.MINUS,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "+" {
          Symbol retSymbol = new Symbol(LexicalUnit.PLUS,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "*" {
          Symbol retSymbol = new Symbol(LexicalUnit.TIMES,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "/" {
          Symbol retSymbol = new Symbol(LexicalUnit.DIVIDE,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }

    
    //If
    "if" {System.out.println("IF: "+ yytext()); return new Symbol(LexicalUnit.IF, yyline, yycolumn);}
    "then" {System.out.println("THEN: "+ yytext()); return new Symbol(LexicalUnit.THEN, yyline, yycolumn);}
    "endif" {System.out.println("ENDIF: "+ yytext()); return new Symbol(LexicalUnit.ENDIF, yyline, yycolumn);}
    "else" {System.out.println("ELSE: "+ yytext()); return new Symbol(LexicalUnit.ELSE, yyline, yycolumn);}

    //Comparaison operators
    "not" {System.out.println("NOT: " + yytext());return new Symbol(LexicalUnit.NOT, yyline, yycolumn);}
    "=" {System.out.println("EQUAL: "+ yytext()); return new Symbol(LexicalUnit.EQUAL, yyline, yycolumn);}
    ">" {System.out.println("GREATER: "+ yytext()); return new Symbol(LexicalUnit.GREATER, yyline, yycolumn);}
    "<" {System.out.println("SMALLER: "+ yytext()); return new Symbol(LexicalUnit.SMALLER, yyline, yycolumn);}

    //While
    "while" {
          Symbol retSymbol = new Symbol(LexicalUnit.WHILE,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "do" {
          Symbol retSymbol = new Symbol(LexicalUnit.DO,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "endwhile" {
          Symbol retSymbol = new Symbol(LexicalUnit.ENDWHILE,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }

    //For
    "for"  {
          Symbol retSymbol = new Symbol(LexicalUnit.FOR,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "from" {
          Symbol retSymbol = new Symbol(LexicalUnit.FROM,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "by" {
          Symbol retSymbol = new Symbol(LexicalUnit.BY,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "to" {
          Symbol retSymbol = new Symbol(LexicalUnit.TO,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "endfor" {
          Symbol retSymbol = new Symbol(LexicalUnit.ENDFOR,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }

    //IO
    "print" {
          Symbol retSymbol = new Symbol(LexicalUnit.PRINT,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
    "read" {
          Symbol retSymbol = new Symbol(LexicalUnit.READ,yyline,yycolumn,yytext());
          System.out.println(retSymbol);
          return retSymbol;
      }
   {VarName} {System.out.println("VARNAME: "+ yytext()); return new Symbol(LexicalUnit.VARNAME, yyline, yycolumn,yytext());}
   {Number} {System.out.println("NUMBER: "+ yytext()); return new Symbol(LexicalUnit.NUMBER, yyline, yycolumn,yytext());}

   {BigCom} {}
   {SmallCom} {}
   . {}
