<%@ page import="java.sql.*, db.DBConnection" %>
<%
int id = Integer.parseInt(request.getParameter("id"));

Connection conn = DBConnection.getConnection();
PreparedStatement stmt = conn.prepareStatement("DELETE FROM food WHERE id = ?");
stmt.setInt(1, id);

int rows = stmt.executeUpdate();

if (rows > 0) {
    response.sendRedirect("manage_food.jsp");
} else {
    out.println("Failed to delete.");
}
%>