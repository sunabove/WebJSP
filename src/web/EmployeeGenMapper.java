package web;

import java.util.List;

import  org.apache.ibatis.mapping.MappedStatement ;

import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.mapperhelper.MapperHelper ;
import tk.mybatis.mapper.mapperhelper.MapperTemplate ;
import tk.mybatis.mapper.mapperhelper.SqlHelper ;
import tk.mybatis.spring.annotation.MapperScan;

public interface EmployeeGenMapper extends Mapper<Employee>{
}