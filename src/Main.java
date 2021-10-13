//package src;

import java.io.IOException;
import java.util.Map;
import java.util.Vector;

public class Main {

    public static void main(String[] args) {
        try {
            java.io.FileReader reader = new java.io.FileReader(args[0]);
            LexicalAnalyzer myAnalyzer = new LexicalAnalyzer(reader);

            Symbol token;
            do {
                token = myAnalyzer.nextToken();

            }
            while (token.getType() != LexicalUnit.END_OF_STREAM);

            System.out.println("My symbol table");
            printSymbolTable(myAnalyzer.getSymbolTable());
            System.out.println("List of Lexical Unit");
            printSymbolsVector(myAnalyzer.getSymbols());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void printSymbolTable(Map<String, Integer> symbolTable){
        symbolTable.entrySet().forEach(System.out::println);
    }

    private static void printSymbolsVector(Vector<Symbol> symbols){
        symbols.forEach(System.out::println);
    }

}
