package lec.list;

import java.util.Collection;

public class StringList extends java.util.ArrayList<String>{

	private static final long serialVersionUID = -5238731462108700329L;
	
	// 생성자 3개를 만듦.
	public StringList() {
		super();
	}
	
	public StringList(int initialCapacity) {
		super( initialCapacity );		
	}
	
	public StringList(Collection<? extends String> c) {
		super( c );
	}
	
	// 리스트의 크기를 반환하는 length() 함수를 만듦.	
	public int length() {
		return super.size();
	}
	
}
