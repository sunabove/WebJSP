package lec.list;

import java.util.LinkedList;

public class LinkedListTest {
	public static void main(String[] args) {
		var cars = new LinkedList<String>();
		
		cars.add("Volvo");
		cars.add("BMW");
		cars.add("Ford");

		// Use addFirst() to add the item to the beginning
		cars.addFirst("Mazda");
		System.out.println(cars);
	}
}