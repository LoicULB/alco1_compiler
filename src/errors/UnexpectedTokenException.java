package errors;

import java.io.IOException;

public class UnexpectedTokenException extends IOException {
    /**
     * Constructs an {@code IOException} with the specified detail foundToken.
     *
     * @param foundToken the token which was not matched by any other regex
     * @param lineNumber the number of the line on which we found the token
     */
    public UnexpectedTokenException(String foundToken, int lineNumber) {
        super("Found an unexpected token : " + foundToken + " on line : " + lineNumber);
    }
}
