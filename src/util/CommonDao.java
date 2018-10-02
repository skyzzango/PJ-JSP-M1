package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class CommonDao {
	private final String driverName = "oracle.jdbc.driver.OracleDriver";
	private final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private final String db_id = "iu";
	private final String db_pw = "iu1004";

	private Connection conn = null;
	private Statement stmt = null;

	public Statement openConnection() {
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, db_id, db_pw);
			stmt = conn.createStatement();
		} catch (Exception e) {
			System.err.println("Oracle Database Connection Something Problem!!");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return stmt;
	}

	public Connection getConnection(String dbName) {
		try {
//			if (dbName.equals("mysql")) {
//				DataSource dataSource = (DataSource) new InitialContext()
//						.lookup("java:comp/env/jdbc/mySql");
//				conn = dataSource.getConnection();
//			} else if (dbName.equals("oracle")) {
//				DataSource dataSource = (DataSource) new InitialContext()
//						.lookup("java:comp/env/jdbc/myOracle");
//				conn = dataSource.getConnection();
//			}
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, db_id, db_pw);
		} catch (Exception e) {
			System.err.println("Oracle Database Connection Something Problem!!");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return conn;
	}

	public void closeConnection() {
		try {
			if (!conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
