package lec.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper {
	@Select( "SELECT * FROM my_user WHERE id = #{id}" )	
	User selectOne(int id);
	
	@Select( "SELECT * FROM my_user WHERE name=#{name} AND passwd = #{passwd}" )
	User logIn( User user );
	//User logIn( String name, String passwd );

	@Select( "SELECT * FROM my_user" )
	List<User> selectAll();

	@Insert( "INSERT INTO my_user( id, name, passwd, phone_no ) "
			+ " VALUES( #{id}, #{name}, #{passwd}, #{phoneNo} )" )
	int insert(User user);

	@Update( "UPDATE my_user SET name = #{name}, passwd = #{passwd}, phone_no = #{phoneNo} "
			+ " WHERE id = #{id} " )
	int update(User user);
	
	@Delete("DELETE FROM my_user WHERE id = #{id} ")
	int delete(User user); 
}