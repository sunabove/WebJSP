package lec.list;

import java.util.HashMap;

public class HashMapTest {
	public static void main(String[] args) {
		HashMap<String, String> capitals = new HashMap<String, String>();
		
		capitals.put("England", "London");
		capitals.put("Germany", "Berlin");
		capitals.put("Norway", "Oslo");
		capitals.put("USA", "Washington DC");
		
		System.out.println(capitals.get("England"));
	}
}