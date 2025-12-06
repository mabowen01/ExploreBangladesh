<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Processing Food</title>
</head>
<body>

<%
String name = request.getParameter("name");
String description = request.getParameter("description");
String image = request.getParameter("image");

Connection conn = DBConnection.getConnection();

try {
    PreparedStatement stmt = conn.prepareStatement("INSERT INTO food(name, description, image) VALUES (?, ?, ?)");
    stmt.setString(1, name);
    stmt.setString(2, description);
    stmt.setString(3, image);

    int rows = stmt.executeUpdate();

    if (rows > 0) {
        out.println("<p> Food added successfully!</p>");
    } else {
        out.println("<p> Failed to add food.</p>");
    }

    out.println("<a href='add_food.jsp'>➕ Add Another</a> | <a href='../index.jsp'> Home</a>");

} catch (Exception e) {
    out.println("Error: " + e.getMessage());
}
%>

</body>
</html>