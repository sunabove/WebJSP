package lec.list;

import java.util.ArrayList;
import java.util.Iterator;

public class IteratorLinkedListTest {
	public static void main(String[] args) {
		var numbers = new ArrayList<Integer>();
		
		numbers.add(12);
		numbers.add(8); 
		
		System.out.println( "*".repeat(40));
		
		var it = numbers.iterator();
		while (it.hasNext()) {
			Integer i = it.next();
			System.out.println( i );
			if (i < 10) {
				it.remove();
			}
		}
		
		System.out.println( "*".repeat(40));
		for( var i : numbers ) {
			System.out.println( i );
		}
		
		System.out.println( "*".repeat(40));
		numbers.forEach( i -> { System.out.println( i ); });
		
		System.out.println(numbers);
	}
}
