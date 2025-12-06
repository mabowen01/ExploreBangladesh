<%@ page import="java.sql.*, db.DBConnection" %>
<%
String name = request.getParameter("name");
String description = request.getParameter("description");
String image = request.getParameter("image");

Connection conn = DBConnection.getConnection();
PreparedStatement stmt = conn.prepareStatement("INSERT INTO scenery(name, description, image) VALUES (?, ?, ?)");
stmt.setString(1, name);
stmt.setString(2, description);
stmt.setString(3, image);

int rows = stmt.executeUpdate();

if (rows > 0) {
    out.println("Tourist attraction added successfully.");
} else {
    out.println("Failed to add.");
}
%>
<br><a href="add_scenery.jsp">Add Another</a> | <a href="manage_scenery.jsp">Manage</a>