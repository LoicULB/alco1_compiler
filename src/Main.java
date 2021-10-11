//package src;

import java.io.IOException;
import java.util.HashMap;
import java.util.Vector;

public class Main {

    public static void main(String[] args) {
        try {
            java.io.FileReader reader = new java.io.FileReader(args[0]);
            LexicalAnalyzer myAnalyzer = new LexicalAnalyzer(reader);

            HashMap<String, Integer> symbolTable = new HashMap<>();


            Symbol token;
            do {
                token = myAnalyzer.nextToken();
                //System.out.println(token); todo should come back live
                if (token.getType() == LexicalUnit.VARNAME) {
                    //symbolTable.merge(token.getValue().toString(), 1, (k, v) -> v + 1);
                    symbolTable.compute(token.getValue().toString(), (k, v) -> (v == null) ? 1 : v + 1);
                }
            }
            while (token.getType() != LexicalUnit.END_OF_STREAM);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
