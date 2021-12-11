package DAO;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import utils.DataSourceUtils;
import utils.User;

import java.sql.SQLException;

public class UserDao {
	public static Boolean insertUser(User user) throws SQLException{
		QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
		String sql="insert into lilshop.user (username,password,gender,email,telephone,introduce,activeCode,state,registTime) values(?,?,?,?,?,?,?,?,?)";
		int num=runner.update(sql, user.getUsername(),user.getPassword(),user.getGender(),user.getEmail(),user.getTelephone(),
				user.getIntroduce(),user.getActiveCode(),user.getState(),user.getRegistTime());
		return num > 0;
	}
	public static User getUsername(String username) throws SQLException {
		QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
		String sql="select * from lilshop.user where username=?";
		User user=(User) runner.query(sql, new BeanHandler(User.class),new Object[] {username});
		return user;
	}
	public static User getUserById(int uID) throws SQLException {
		QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
		String sql="select * from lilshop.user where Id=?";
		User user=(User) runner.query(sql, new BeanHandler(User.class),new Object[] {uID});
		return user;
	}
	public static boolean deleteUser(int userId) throws SQLException {
		QueryRunner runner=new QueryRunner(DataSourceUtils.getDataSource());
		String sql="delete from lilshop.user where id="+userId;
		int num=runner.update(sql);
		return num > 0;
	}
	public static void main(String args[]) throws SQLException {
		User user= UserDao.getUsername("456");
		System.out.println(user);
	}


}
