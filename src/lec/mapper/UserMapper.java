package lec.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

@Mapper
public interface UserMapper {
	@Select( "SELECT * FROM user WHERE id = #{id}" )	
	User selectOne(int id);
	
	@Select( "SELECT * FROM user WHERE name=#{name} AND passwd = #{passwd}" )
	User logIn( User user );
	//User logIn( String name, String passwd );

	@Select( "SELECT * FROM user" )
	List<User> selectAll();

	@Insert( "INSERT INTO user( id, name, passwd, phone_no ) "
			+ " VALUES( #{id}, #{name}, #{passwd}, #{phoneNo} )" )
	int insert(User user);

	@Update( "UPDATE user SET name = #{name}, passwd = #{passwd}, phone_no = #{phoneNo} "
			+ " WHERE id = #{id} " )
	int update(User user);
	
	@Delete("DELETE FROM user WHERE id = #{id} ")
	int delete(User user); 
}