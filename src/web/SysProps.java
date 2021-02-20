package web;

public class SysProps extends java.util.Properties {
	
	private static final long serialVersionUID = 7981790469787084764L;

	public SysProps() {
		try {
			this.load( this.getClass().getResourceAsStream( "my_props.properties") );
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public static void main( String args []) {
		SysProps props = new SysProps();
		
		props.forEach((k, v) -> System.out.println(k + "=" + v)); 
	}

}
