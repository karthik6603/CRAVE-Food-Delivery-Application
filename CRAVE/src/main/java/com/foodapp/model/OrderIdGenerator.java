package com.foodapp.model;

public class OrderIdGenerator {
	private static final String BASE62_ALPHABET = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    private static final int BASE62 = BASE62_ALPHABET.length();

    // Encrypt: Convert the integer to a Base62 string
    public static String encrypt(int number) {
        StringBuilder encoded = new StringBuilder();
        while (number > 0) {
            encoded.append(BASE62_ALPHABET.charAt(number % BASE62));
            number /= BASE62;
        }
        return encoded.reverse().toString();
    }

    // Decrypt: Convert the Base62 string back to an integer
    public static int decrypt(String base62String) {
        int decoded = 0;
        for (int i = 0; i < base62String.length(); i++) {
            decoded = decoded * BASE62 + BASE62_ALPHABET.indexOf(base62String.charAt(i));
        }
        return decoded;
    }


}
