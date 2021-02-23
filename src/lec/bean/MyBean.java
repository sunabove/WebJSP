package lec.bean;

public class MyBean {
	private String name = "John";
	private boolean deleted;
	
	public MyBean() {		
	}

	public String getName() {
		System.out.println( "getName() method is called." );
		
		return name;
	}

	public void setName(String name) {
		System.out.println( "setName(String name) method is called." );
		
		this.name = name;
	}

	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
}
