package lec.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloServlet
 */
@WebServlet("/fiboServletLee")
public class FiboServletLee extends HttpServlet { 
	private static final long serialVersionUID = -393634178673644838L;

	/**
     * @see HttpServlet#HttpServlet()
     */
    public FiboServletLee() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		var writer = response.getWriter();
		
		int f0 = 1;
		int f1 = 1;
		int f;
		
		int lineNo = 0; 
		
		writer.append( "<html>" ); 
		writer.append( "<ol>" ); 
		while( lineNo < 50) {
			if ( f1 < 0 ) {
				break;
			} else {
				writer.append(  "<li>" + f1 + "</li>" ); 
			}
			f = f0 + f1 ; 
			f0 = f1;
			f1 = f;			
			
			lineNo ++ ; 
		}
		
		writer.append( "</ol>" );
		writer.append( "</html>" );  
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
