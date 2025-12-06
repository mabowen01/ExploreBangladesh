<%@ page import="java.sql.*, db.DBConnection" %>
<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String password = request.getParameter("password");

Connection conn = DBConnection.getConnection();
PreparedStatement stmt = conn.prepareStatement(
  "INSERT INTO user (name, email, password, role) VALUES (?, ?, ?, 'user')"
);
stmt.setString(1, name);
stmt.setString(2, email);
stmt.setString(3, password);

int rows = stmt.executeUpdate();

if (rows > 0) {
  response.sendRedirect("login.jsp");
} else {
  out.println("Registration failed. Try a different email.");
}
%>