<%@ page import="java.sql.*, db.DBConnection" %>
<%
    String idParam = request.getParameter("id");
    int sportId = 0;
    String name = "";
    String description = "";
    String image = "";

    if (idParam != null && !idParam.isEmpty()) {
        sportId = Integer.parseInt(idParam);

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM sport WHERE id = ?");
            ps.setInt(1, sportId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                description = rs.getString("description");
                image = rs.getString("image");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Edit Sport</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="container mt-4">

<h2>Edit Sport</h2>

<form action="${pageContext.request.contextPath}/admin/updateSport" method="post" enctype="multipart/form-data" class="mt-3">

    <input type="hidden" name="id" value="<%= sportId %>" />

    <div class="mb-3">
        <label for="name" class="form-label">Sport Name</label>
        <input type="text" id="name" name="name" class="form-control" value="<%= name %>" required />
    </div>

    <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea id="description" name="description" class="form-control" rows="4" required><%= description %></textarea>
    </div>

    <div class="mb-3">
        <label for="image" class="form-label">Sport Image</label>
        <input type="file" id="image" name="image" class="form-control" />
        <%
            if (image != null && !image.isEmpty()) {
        %>
            <img src="<%= request.getContextPath() + "/" + image %>" alt="Sport Image" style="max-width:200px; margin-top:10px;" />
        <%
            }
        %>
    </div>

    <button type="submit" class="btn btn-primary">Update Sport</button>
    <a href="<%= request.getContextPath() + "/admin/manage_sport.jsp" %>" class="btn btn-secondary ms-2">Cancel</a>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>