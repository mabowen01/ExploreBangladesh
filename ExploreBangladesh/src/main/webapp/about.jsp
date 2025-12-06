<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>About Us - Explore Bangladesh</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>

<!-- Navbar (reuse from your index.jsp or make a common navbar file) -->
<!-- <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">Explore Bangladesh</a>
    <div>
      <a href="index.jsp" class="btn btn-outline-light me-2">Home</a>
      <a href="about.jsp" class="btn btn-outline-light active">About</a>
      Add other nav links if needed
    </div>
  </div>
</nav> -->
<jsp:include page="header.jsp" />
<br><br>
<div class="container">
  <h1 class="mb-4">About Explore Bangladesh</h1>

  <p>
    Welcome to Explore Bangladesh! Our mission is to showcase the rich cultural heritage,
    delicious foods, beautiful tourist attractions, famous movies, music, and sports of Bangladesh.
  </p>

  <p>
    This website is designed for tourists and locals alike to learn more about Bangladesh's
    unique and vibrant culture. You can browse various sections, leave comments, like your favorite
    items, and even contribute if you register.
  </p>

  <h3>Our Vision</h3>
  <p>To promote Bangladesh as a top travel and cultural destination worldwide.</p>

  <h3>Contact Us</h3>
  <p>Email: info@explorebangladesh.com</p>
  <p>Phone: +880 1234 567890</p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>