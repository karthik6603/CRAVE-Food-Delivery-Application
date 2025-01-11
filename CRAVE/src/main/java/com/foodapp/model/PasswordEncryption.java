package com.foodapp.model;

public class PasswordEncryption {

	public static String encrypt(String s) {
		
		StringBuilder encryptedpassword = new StringBuilder();
		
		for(int i=0; i<s.length(); i++) {
			encryptedpassword.append((char)(s.charAt(i)+2));
		}
		
		return encryptedpassword.toString();
		
	}
	
	public static String decrypt(String s) {
		
		StringBuilder decryptedpassword = new StringBuilder();
		
		for(int i=0; i<s.length(); i++) {
			decryptedpassword.append((char)(s.charAt(i)-2));
		}
		
		return decryptedpassword.toString();
		
	}
	
}
