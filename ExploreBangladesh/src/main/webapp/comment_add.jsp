<%@ page import="java.sql.*, db.DBConnection" %>
<%
  Integer userId = (Integer) session.getAttribute("userId");
  if (userId == null) {
    response.sendRedirect("auth/login.jsp");
    return;
  }

  String itemIdStr = request.getParameter("item_id");
  String itemType = request.getParameter("item_type");
  String content = request.getParameter("content");

  if (itemIdStr == null || itemType == null || content == null || content.trim().isEmpty()) {
    response.sendRedirect(request.getHeader("referer") != null ? request.getHeader("referer") : "index.jsp");
    return;
  }

  int itemId = Integer.parseInt(itemIdStr);

  try (Connection conn = DBConnection.getConnection()) {
    PreparedStatement stmt = conn.prepareStatement(
      "INSERT INTO comment(user_id, item_id, item_type, content) VALUES (?, ?, ?, ?)"
    );
    stmt.setInt(1, userId);
    stmt.setInt(2, itemId);
    stmt.setString(3, itemType);
    stmt.setString(4, content.trim());
    stmt.executeUpdate();
  } catch (Exception e) {
    e.printStackTrace();
  }

  String referer = request.getHeader("referer");
  response.sendRedirect(referer != null ? referer : "index.jsp");
%>