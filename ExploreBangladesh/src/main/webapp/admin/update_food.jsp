<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="java.io.File" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF-8");

  String idStr = request.getParameter("id");
  String name = request.getParameter("name");
  String description = request.getParameter("description");
  String oldImage = request.getParameter("old_image");

  if (idStr == null || idStr.trim().isEmpty()) {
    out.println("Food ID is missing!");
    return;
  }

  int id = Integer.parseInt(idStr);

  Part filePart = request.getPart("image");
  String fileName = oldImage;

  if (filePart != null && filePart.getSize() > 0) {
    String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    String uploadPath = application.getRealPath("/") + "uploads";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdir();

    filePart.write(uploadPath + File.separator + submittedFileName);
    fileName = "uploads/" + submittedFileName;
  }

  Connection conn = DBConnection.getConnection();
  PreparedStatement ps = conn.prepareStatement("UPDATE food SET name=?, description=?, image=? WHERE id=?");
  ps.setString(1, name);
  ps.setString(2, description);
  ps.setString(3, fileName);
  ps.setInt(4, id);
  ps.executeUpdate();

  response.sendRedirect("manage_food.jsp");
%>