<%@ page import="java.sql.*, db.DBConnection" %>
<%
  Integer userId = (Integer) session.getAttribute("userId");
  if (userId == null) {
    response.sendRedirect("auth/login.jsp");
    return;
  }

  String itemIdStr = request.getParameter("item_id");
  String itemType = request.getParameter("item_type");

  if (itemIdStr == null || itemType == null) {
    response.sendRedirect(request.getHeader("referer") != null ? request.getHeader("referer") : "index.jsp");
    return;
  }

  int itemId = Integer.parseInt(itemIdStr);

  try (Connection conn = DBConnection.getConnection()) {
    // Check if like already exists
    PreparedStatement checkStmt = conn.prepareStatement(
      "SELECT * FROM likes WHERE user_id = ? AND item_id = ? AND item_type = ?"
    );
    checkStmt.setInt(1, userId);
    checkStmt.setInt(2, itemId);
    checkStmt.setString(3, itemType);
    ResultSet rs = checkStmt.executeQuery();

    if (rs.next()) {
      // Exists, so unlike
      PreparedStatement deleteStmt = conn.prepareStatement(
        "DELETE FROM likes WHERE user_id = ? AND item_id = ? AND item_type = ?"
      );
      deleteStmt.setInt(1, userId);
      deleteStmt.setInt(2, itemId);
      deleteStmt.setString(3, itemType);
      deleteStmt.executeUpdate();
      deleteStmt.close();
    } else {
      // Not exists, so insert like
      PreparedStatement insertStmt = conn.prepareStatement(
        "INSERT INTO likes(user_id, item_id, item_type) VALUES (?, ?, ?)"
      );
      insertStmt.setInt(1, userId);
      insertStmt.setInt(2, itemId);
      insertStmt.setString(3, itemType);
      insertStmt.executeUpdate();
      insertStmt.close();
    }
    rs.close();
    checkStmt.close();
  } catch (Exception e) {
    e.printStackTrace();
  }

  String referer = request.getHeader("referer");
  response.sendRedirect(referer != null ? referer : "index.jsp");
%>