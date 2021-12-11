package utils;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;
import java.sql.SQLException;

public class DataSourceUtils {
	private static DataSource ds;
	static {
		ds = new ComboPooledDataSource();
	}
	public static DataSource getDataSource() {
		return ds;
	}
	public static void main(String[] args) throws SQLException {
		System.out.print(ds.getConnection());
	}
}

