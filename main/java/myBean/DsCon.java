package myBean;

import javax.naming.*;
import java.sql.*;
import javax.sql.DataSource;

public class DsCon {
	public static Connection getConnection() throws NamingException, SQLException{
		Context initContext=new InitialContext();
		DataSource ds=(DataSource)initContext.lookup("java:/comp/env/jdbc/myWebtoon");
		return ds.getConnection();
	}
}

