<%@ page import="java.sql.*, db.DBConnection" %>
<%
  int id = Integer.parseInt(request.getParameter("id"));

  Connection conn = DBConnection.getConnection();
  PreparedStatement stmt = conn.prepareStatement("DELETE FROM movie WHERE id=?");
  stmt.setInt(1, id);
  stmt.executeUpdate();

  response.sendRedirect("manage_movie.jsp");
%>