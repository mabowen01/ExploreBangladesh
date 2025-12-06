<%@ page import="db.DBConnection, java.sql.*" %>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");

Connection conn = DBConnection.getConnection();
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM user WHERE email=? AND password=?");
stmt.setString(1, email);
stmt.setString(2, password);
ResultSet rs = stmt.executeQuery();

if (rs.next()) {
  session.setAttribute("userId", rs.getInt("id"));
  session.setAttribute("role", rs.getString("role"));
  response.sendRedirect("../index.jsp");
} else {
  out.println("Login failed");
}
%>