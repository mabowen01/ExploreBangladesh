<%@ page import="java.sql.*, db.DBConnection" %>
<%
    String idParam = request.getParameter("id");
    int sceneryId = 0;
    String name = "";
    String description = "";
    String image = "";

    if (idParam != null && !idParam.isEmpty()) {
        sceneryId = Integer.parseInt(idParam);

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM scenery WHERE id = ?");
            ps.setInt(1, sceneryId);
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
<title>Edit Tourist Attraction</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="container mt-4">

<h2>Edit Tourist Attraction</h2>

<form action="${pageContext.request.contextPath}/admin/updateScenery" method="post" enctype="multipart/form-data" class="mt-3">

    <input type="hidden" name="id" value="<%= sceneryId %>" />

    <div class="mb-3">
        <label for="name" class="form-label">Attraction Name</label>
        <input type="text" id="name" name="name" class="form-control" value="<%= name %>" required />
    </div>

    <div class="mb-3">
        <label for="description" class="form-label">Description</label>
        <textarea id="description" name="description" class="form-control" rows="4" required><%= description %></textarea>
    </div>

    <div class="mb-3">
        <label for="image" class="form-label">Attraction Image</label>
        <input type="file" id="image" name="image" class="form-control" />
        <%
            if (image != null && !image.isEmpty()) {
        %>
            <img src="<%= request.getContextPath() + "/" + image %>" alt="Attraction Image" style="max-width:200px; margin-top:10px;" />
        <%
            }
        %>
    </div>

    <button type="submit" class="btn btn-primary">Update Attraction</button>
    <a href="<%= request.getContextPath() + "/admin/manage_scenery.jsp" %>" class="btn btn-secondary ms-2">Cancel</a>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>