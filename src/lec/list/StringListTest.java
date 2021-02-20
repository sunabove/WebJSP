package lec.list;

import java.util.Collections;

public class StringListTest {
	public static void main(String[] args) {
		
		var cars = new StringList();
		
		//var cars = new ArrayList<String>();
		
		cars.add("Volvo");
		cars.add("BMW");
		cars.add("Ford");
		cars.add("Mazda");
		
		cars.set(0, "Opel");
		//cars.remove(0);
		
		" abcd".length();
		
		int size = cars.size();
		size = cars.length();
		
		Collections.sort(cars); // Sort cars
		
		for (var car : cars) {
			System.out.println( car );
		}
	}
}