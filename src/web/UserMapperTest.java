package web;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class UserMapperTest {

	public static void main(String[] args) throws Exception {
		InputStream inputStream = Resources.getResourceAsStream( "mybatis-config.xml" );
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);		
		
		SqlSession session = sqlSessionFactory.openSession();
		
		UserMapper mapper = session.getMapper(UserMapper.class);
		
		User user ;
		user = new User(); 
		user.setName( "john");
		user.setPasswd( "admin");
		
		mapper.insert(user);
		
		user = mapper.selectOne(1);
		System.out.println(user); 
		
		user.setName( "ABCDEF" );
		mapper.update(user);
		
		user = mapper.selectOne(12);
		if( user != null ) { 
			mapper.delete(user);
		}
		
		List<User> users = mapper.selectAll();
		
		for( User e : users ) {
			System.out.println( e );
		} 
		
		session.commit();
	}

}
