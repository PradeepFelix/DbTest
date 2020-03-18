<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Database Test</title>
</head>
<body>
	<table>
		<%@ page import="java.util.*"%>
		<%@ page import="javax.sql.*"%>
		<%@page import="java.io.InputStream"%>
		<%@page import="java.util.Properties"%>
		<%
			java.sql.Connection con;
			java.sql.Statement s;
			java.sql.ResultSet rs;
			java.sql.PreparedStatement pst;

			con = null;
			s = null;
			pst = null;
			rs = null;

			Properties props = new Properties();

			try {

				InputStream in = application.getResourceAsStream("/db.properties");

				props.load(in);
				in.close();
			} catch (Exception ex) {
				System.out.println(ex);
			}

			String dbURL = props.getProperty("DBURL");

			System.out.println("The dburl is : " + dbURL);

			// Remember to change the next line with your own environment
			String url = dbURL;
			String id = "sa";
			String pass = "sa";

			try {

				System.out.println("jdbc driver done - 1");

				Class.forName("net.sourceforge.jtds.jdbc.Driver");

				con = java.sql.DriverManager.getConnection(url, id, pass);

				System.out.println("jdbc driver done - 2");

			} catch (ClassNotFoundException cnfex) {

				System.out.println(cnfex);

			}
			String sql = "select * from tbl_Test";
			try {
				s = con.createStatement();

				rs = s.executeQuery(sql);

				System.out.println(sql);
		%>

		<%
			while (rs.next()) {
		%><tr>
			<td><%=rs.getString("Message")%></td>

		</tr>

		<%
			System.out.println("Reading db");
					System.out.println(rs.getString("Message"));
				}
		%>

		<%
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();

			} finally {
				if (rs != null)
					rs.close();
				if (s != null)
					s.close();
				if (con != null)
					con.close();
			}
		%>
	</table>
</body>
</html>