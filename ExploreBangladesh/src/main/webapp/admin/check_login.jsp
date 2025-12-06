<%@ page import="java.sql.*, db.DBConnection" %>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");

Connection conn = DBConnection.getConnection();
PreparedStatement stmt = conn.prepareStatement(
  "SELECT * FROM user WHERE email = ? AND password = ? AND role = 'admin'"
);
stmt.setString(1, email);
stmt.setString(2, password);
ResultSet rs = stmt.executeQuery();

if (rs.next()) {
  session.setAttribute("isAdmin", true);
  session.setAttribute("adminEmail", email);
  response.sendRedirect("dashboard.jsp");
} else {
%>
  <script>
    alert("Invalid email or password.");
    window.location = "login.jsp";
  </script>
<%
}
%>