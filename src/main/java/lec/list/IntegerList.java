package lec.list;

import java.util.Collection;

public class IntegerList extends java.util.ArrayList<Integer>{

	private static final long serialVersionUID = -1546030548451607381L;

	// 생성자 3개를 만듦.
	public IntegerList() {
		super();
	}
	
	public IntegerList(int initialCapacity) {
		super( initialCapacity );		
	}
	
	public IntegerList(Collection<? extends Integer> c) {
		super( c );
	}
	
	// 리스트의 크기를 반환하는 length() 함수를 만듦.	
	public int length() {
		return super.size();
	}
	
}
