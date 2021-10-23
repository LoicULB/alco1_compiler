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
            readSourceCode(myAnalyzer);

            printDataStructures(myAnalyzer);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Print the data structures contained in the lexical analyser
     * @param myAnalyzer : the scanner used to apply the lexicographic analysis
     */
    private static void printDataStructures(LexicalAnalyzer myAnalyzer) {
        printSymbolsVector(myAnalyzer.getSymbols());
        System.out.println("Variables");
        printSymbolTable(myAnalyzer.getSymbolTable());
    }

    /**
     * Reads the source code and apply the nextToken function that will add the token encountered to the symbol
     * datastructures if needed.
     * @param myAnalyzer : The scnanner used to apply the lexicographic analysis
     * @throws IOException : if nextToken() has a problem with the file.
     */
    private static void readSourceCode(LexicalAnalyzer myAnalyzer) throws IOException {
        Symbol token;
        do {
            token = myAnalyzer.nextToken();

        }
        while (token.getType() != LexicalUnit.END_OF_STREAM);
    }


    /**
     * Print the symbol table
     * @param symbolTable : the symbol table to print
     */

    private static void printSymbolTable(Map<String, Integer> symbolTable){
        symbolTable.entrySet().forEach(System.out::println);
    }

    /**
     * Print the vector of symbols
     * @param symbols : the vector of symbols
     */
    private static void printSymbolsVector(Vector<Symbol> symbols){

        symbols.forEach(System.out::println);

    }

}
