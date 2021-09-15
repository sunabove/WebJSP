package lec.list;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class IteratorHashMap {

	public static void main(String[] args) {
		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		map.put( 1,  2 );
		map.put( 2,  4 );
		map.put( 3,  6 );
		map.put( 4,  8 );
		
		System.out.println( "*".repeat(40));
		
		Iterator<Map.Entry<Integer, Integer>> entries = map.entrySet().iterator();
		while (entries.hasNext()) {
			Map.Entry<Integer, Integer> entry = entries.next();
			System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
		}

		System.out.println( "*".repeat(40));
		// Iterating over keys only
		for (Integer key : map.keySet()) {
			System.out.println("Key = " + key);
			System.out.println("Value = " + map.get(key));
		}

		System.out.println( "*".repeat(40));
		// Iterating over values only
		for (Integer value : map.values()) {
			System.out.println("Value = " + value);
		}

		System.out.println( "*".repeat(40));
		// Iterating
		map.forEach((k, v) -> {
			System.out.println(k + "," + v);
		});
	}

}
