package com.spring.study.lombok;

public class LombokTestClassMain {
	public static void main(String[] args) {
		LombokTestClass testClass = new LombokTestClass("yyy", "홍길동", 20, 'M', false, 175);
		LombokTestClass testClass2 = new LombokTestClass();
		
		System.out.println(testClass.toString());
		System.out.println(testClass2.toString());
		
	}
}
