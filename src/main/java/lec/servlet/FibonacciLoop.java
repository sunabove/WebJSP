package lec.servlet;

public class FibonacciLoop {

	@SuppressWarnings("static-access")
	public static void main(String[] args) {
		var out = System.out;
		
		int f0 = 0 ;
		int f1 = 1 ;
		int f;
		
		int lineNo = 1; 
		do {
			out.println( "".format( "%d, %d", lineNo, f1 ) );
			
			f = f0 + f1 ; 
			f0 = f1;
			f1 = f;
			
			lineNo ++ ; 
		} while( f0 <= f1 ) ; 
	}

}
