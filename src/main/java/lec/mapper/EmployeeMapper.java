package lec.mapper;

import java.util.List;

import org.apache.ibatis.annotations.*;

@Mapper
public interface EmployeeMapper {
	@Select( "SELECT * FROM employee WHERE id = #{id}" )	
	Employee selectOne(int id);

	@Select( "SELECT * FROM employee" )
	List<Employee> selectAll();

	@Insert( "INSERT INTO employee( first_name, last_name, email, age, phone_no ) "
			+ " VALUES( #{firstName}, #{lastName}, #{email}, #{age}, #{phoneNo} )" )
	int insert(Employee employee);

	@Update( "UPDATE employee SET first_name = #{firstName}, last_name = #{lastName}, phone_no = #{phoneNo} "
			+ " WHERE id = #{id} " )
	int update(Employee employee);
	
	@Delete("DELETE FROM employee WHERE id = #{id} ")
	int delete(Employee employee);
}