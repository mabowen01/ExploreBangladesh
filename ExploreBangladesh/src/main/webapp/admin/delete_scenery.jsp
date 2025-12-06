<%@ page import="java.sql.*, db.DBConnection" %>
<%
    String id = request.getParameter("id");
    if (id != null && !id.trim().isEmpty()) {
        Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement("DELETE FROM scenery WHERE id = ?");
        stmt.setInt(1, Integer.parseInt(id));
        stmt.executeUpdate();
    }
    response.sendRedirect("manage_scenery.jsp");
%>