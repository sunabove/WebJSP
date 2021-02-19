package web;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class EmployeeGenMapperTest {

	public static void main(String[] args) throws Exception {
		InputStream inputStream = Resources.getResourceAsStream( "mybatis-config.xml" );
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);		
		
		SqlSession session = sqlSessionFactory.openSession();
		
		EmployeeGenMapper mapper = session.getMapper(EmployeeGenMapper.class);
		
		Employee employee ;
		employee = new Employee();
		
		mapper.insert(employee);
		
		employee = mapper.selectByPrimaryKey( 1 );
		System.out.println(employee); 
		
		employee.setFirstName( "ABCDEF" );
		mapper.updateByExample( employee, employee);
		
		employee = mapper.selectByPrimaryKey(12);
		mapper.delete(employee);
		
		List<Employee> employees = mapper.selectAll();
		
		for( Employee e : employees ) {
			System.out.println( e );
		} 
		session.commit();
	}

}
