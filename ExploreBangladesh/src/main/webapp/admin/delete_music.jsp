<%@ page import="java.sql.*, db.DBConnection" %>
<%
    String id = request.getParameter("id");
    Connection conn = DBConnection.getConnection();
    PreparedStatement stmt = conn.prepareStatement("DELETE FROM music WHERE id = ?");
    stmt.setInt(1, Integer.parseInt(id));
    stmt.executeUpdate();
    response.sendRedirect("manage_music.jsp");
%>
