package lec.mapper;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class EmployeeMapperTest {

	public static void main(String[] args) throws Exception {
		InputStream inputStream = Resources.getResourceAsStream( "mybatis-config.xml" );
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);		
		
		var out = System.out;
		
		SqlSession session = sqlSessionFactory.openSession();
		
		EmployeeMapper mapper = session.getMapper(EmployeeMapper.class);
		
		Employee employee ;
		employee = new Employee(1);
		employee.setFirstName( "My John");
		employee.setEmail( "My John@google.com");
		
		var id = mapper.insert(employee);
		out.println( "id = " + id );
		
		employee = mapper.selectOne(1);
		
		out.println();
		out.println("EMP = " + employee); 
		
		employee.setFirstName( "ABCDEF" );
		mapper.update(employee);
		
		employee = mapper.selectOne(2);
		if( null != employee ) {
			mapper.delete(employee);
		}
		
		List<Employee> employees = mapper.selectAll();
		
		for( var e : employees ) {
			out.println( "EMP = " + e );
		} 
		
		session.commit();
	}

}
