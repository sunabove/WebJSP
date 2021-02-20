package lec.list;

import java.util.Collection;

public class EmployeeList extends java.util.ArrayList<Employee>{

	private static final long serialVersionUID = 7022263835954442542L;

	// 생성자 3개를 만듦.
	public EmployeeList() {
		super();
	}
	
	public EmployeeList(int initialCapacity) {
		super( initialCapacity );		
	}
	
	public EmployeeList(Collection<? extends Employee> c) {
		super( c );
	}
	
	// 리스트의 크기를 반환하는 length() 함수를 만듦.	
	public int length() {
		return super.size();
	}
	
}
