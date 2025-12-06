<%@ page import="java.sql.*, db.DBConnection" %>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");

Connection conn = DBConnection.getConnection();
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");
stmt.setString(1, email);
stmt.setString(2, password);
ResultSet rs = stmt.executeQuery();

if (rs.next()) {
    String role = rs.getString("role");

    session.setAttribute("userId", rs.getInt("id"));
    session.setAttribute("userName", rs.getString("name"));
    session.setAttribute("userEmail", email);
    session.setAttribute("userRole", role);

    if ("admin".equals(role)) {
        session.setAttribute("isAdmin", true);
        response.sendRedirect("../admin/dashboard.jsp");
    } else {
        response.sendRedirect("../index.jsp");
    }
} else {
%>
    <script>
      alert("Invalid login credentials.");
      window.location = "login.jsp";
    </script>
<%
}
%>