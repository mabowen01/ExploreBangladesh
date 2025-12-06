<%@ page import="java.lang.String" %>
<%
  String currentUser = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Explore Bangladesh - Sidebar Home</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      min-height: 100vh;
      display: flex;
      flex-direction: row;
      margin: 0;
    }
    #sidebar {
      width: 250px;
      background-color: #343a40;
      color: white;
      min-height: 100vh;
      padding-top: 1rem;
    }
    #sidebar .nav-link {
      color: white;
    }
    #sidebar .nav-link.active {
      background-color: #495057;
    }
    #content {
      flex-grow: 1;
      padding: 2rem;
      background-color: #f8f9fa;
      min-height: 100vh;
    }
  </style>
</head>
<body>

  <!-- Sidebar -->
  <nav id="sidebar" class="d-flex flex-column">
    <h4 class="px-3">Explore Bangladesh</h4>
    <ul class="nav flex-column px-2">
      <li class="nav-item">
        <a class="nav-link <%= request.getRequestURI().endsWith("sidebar_home.jsp") ? "active" : "" %>" href="sidebar_home.jsp">Home</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= request.getRequestURI().endsWith("about.jsp") ? "active" : "" %>" href="about.jsp">About</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= request.getRequestURI().endsWith("scenery.jsp") ? "active" : "" %>" href="scenery.jsp">Scenery</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= request.getRequestURI().endsWith("food.jsp") ? "active" : "" %>" href="food.jsp">Food</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= request.getRequestURI().endsWith("sport.jsp") ? "active" : "" %>" href="sport.jsp">Sports</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= request.getRequestURI().endsWith("music.jsp") ? "active" : "" %>" href="music.jsp">Music</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= request.getRequestURI().endsWith("settings.jsp") ? "active" : "" %>" href="settings.jsp">Settings</a>
      </li>
    </ul>
  </nav>

  <!-- Main Content -->
  <div id="content">
    <h1>Welcome to Explore Bangladesh</h1>
    <p>This is your new sidebar homepage.</p>

    <!-- Place your popular foods, scenery, movies, etc here -->

  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>