<%@ page import="java.sql.*, db.DBConnection" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  Connection conn = DBConnection.getConnection();
  PreparedStatement stmt = conn.prepareStatement("SELECT * FROM movie ORDER BY id DESC");
  ResultSet rs = stmt.executeQuery();

  Integer currentUserId = (Integer) session.getAttribute("userId");
%>
<jsp:include page="header.jsp" />

<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Movies - Explore Bangladesh</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400&display=swap" rel="stylesheet" />
  <style>
    body {
      background: linear-gradient(180deg, #1c2526 0%, #2e4347 100%);
      font-family: 'Roboto', sans-serif;
      color: #e0e6ed;
      min-height: 100vh;
      overflow-x: hidden;
    }
    .container {
      max-width: 1300px;
      padding: 0 20px;
    }
    .header-title {
      font-family: 'Playfair Display', serif;
      color: #e0e6ed;
      font-size: 3rem;
      font-weight: 700;
      text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.4);
      letter-spacing: 1px;
    }
    .intro-text {
      font-size: 1.2rem;
      font-weight: 300;
      color: #b0c4de;
      opacity: 0.9;
    }
    .card {
      border: none;
      border-radius: 20px;
      overflow: hidden;
      background: rgba(255, 255, 255, 0.95);
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
      transition: transform 0.5s ease, box-shadow 0.5s ease;
      margin-bottom: 50px;
      position: relative;
    }
    .card:hover {
      transform: translateY(-10px);
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4);
    }
    .card-img-wrapper {
      position: relative;
      overflow: hidden;
      height: 300px;
    }
    .card-img {
      object-fit: cover;
      width: 100%;
      height: 100%;
      transition: transform 0.6s ease;
    }
    .card:hover .card-img {
      transform: scale(1.1);
    }
    .card-img-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(to top, rgba(0, 0, 0, 0.6), transparent);
      pointer-events: none;
    }
    .card-title {
      font-family: 'Playfair Display', serif;
      color: #1c2526;
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 15px;
    }
    .card-text {
      color: #34495e;
      font-size: 1rem;
      line-height: 1.7;
    }
    .btn-like {
      border-radius: 50px;
      padding: 10px 20px;
      font-size: 0.9rem;
      font-weight: 400;
      background: linear-gradient(45deg, #ff6b6b, #e74c3c);
      border: none;
      color: #fff;
      transition: all 0.3s ease;
    }
    .btn-like.btn-outline-danger {
      background: transparent;
      border: 2px solid #e74c3c;
      color: #e74c3c;
    }
    .btn-like:hover {
      background: linear-gradient(45deg, #e74c3c, #c0392b);
      color: #fff;
      transform: scale(1.05);
    }
    .btn-comment {
      border-radius: 50px;
      padding: 10px 20px;
      background: linear-gradient(45deg, #00b7eb, #0088c2);
      border: none;
      font-size: 0.9rem;
      font-weight: 400;
      color: #fff;
      transition: all 0.3s ease;
    }
    .btn-comment:hover {
      background: linear-gradient(45deg, #0088c2, #006a9c);
      transform: scale(1.05);
    }
    .comment-section {
      max-height: 280px;
      overflow-y: auto;
      padding: 15px;
      background: #f8f9fa;
      border-radius: 10px;
      margin-top: 20px;
    }
    .comment-section::-webkit-scrollbar {
      width: 6px;
    }
    .comment-section::-webkit-scrollbar-thumb {
      background: #00b7eb;
      border-radius: 10px;
    }
    .comment-box {
      border-radius: 15px;
      border: 1px solid #b0c4de;
      background: #fff;
      resize: none;
      font-size: 0.95rem;
      padding: 15px;
      transition: border-color 0.3s ease;
    }
    .comment-box:focus {
      border-color: #00b7eb;
      box-shadow: 0 0 8px rgba(0, 183, 235, 0.3);
    }
    .comment {
      background: #fff;
      border-radius: 12px;
      padding: 15px;
      margin-bottom: 15px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s ease;
    }
    .comment:hover {
      transform: translateX(5px);
    }
    .comment-author {
      color: #1c2526;
      font-weight: 500;
      font-size: 1rem;
    }
    .comment-timestamp {
      color: #7f8c8d;
      font-size: 0.85rem;
      font-style: italic;
    }
    .login-prompt {
      color: #ff6b6b;
      font-size: 0.95rem;
      font-weight: 400;
    }
    .login-prompt a {
      color: #00b7eb;
      text-decoration: none;
      font-weight: 500;
    }
    .login-prompt a:hover {
      text-decoration: underline;
    }
    .intro-section {
      background: rgba(0, 0, 0, 0.3);
      padding: 30px;
      border-radius: 15px;
      margin-bottom: 50px;
      text-align: center;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .card {
      animation: fadeIn 0.8s ease-out;
    }
  </style>
</head>
<body class="container mt-5">

<div class="intro-section">
  <h2 class="header-title">
    <i class="fas fa-film me-2"></i>Bangladeshi Movies
  </h2>
  <p class="intro-text">Discover the captivating stories and cinematic brilliance of Bangladesh</p>
</div>

<%
  while (rs.next()) {
    int movieId = rs.getInt("id");
    String movieName = rs.getString("name");
    String movieDesc = rs.getString("description");
    String movieImg = rs.getString("image");

    // Like count
    PreparedStatement likeCountStmt = conn.prepareStatement(
      "SELECT COUNT(*) AS total FROM likes WHERE item_type = 'movie' AND item_id = ?");
    likeCountStmt.setInt(1, movieId);
    ResultSet likeCountRs = likeCountStmt.executeQuery();
    likeCountRs.next();
    int totalLikes = likeCountRs.getInt("total");
    likeCountRs.close();
    likeCountStmt.close();

    // Whether current user liked it
    boolean likedByUser = false;
    if (currentUserId != null) {
      PreparedStatement userLikeStmt = conn.prepareStatement(
        "SELECT * FROM likes WHERE user_id = ? AND item_id = ? AND item_type = 'movie'");
      userLikeStmt.setInt(1, currentUserId);
      userLikeStmt.setInt(2, movieId);
      ResultSet userLikeRs = userLikeStmt.executeQuery();
      likedByUser = userLikeRs.next();
      userLikeRs.close();
      userLikeStmt.close();
    }
%>

<div class="card">
  <div class="row g-0">
    <div class="col-md-4">
      <div class="card-img-wrapper">
        <img src="<%= movieImg %>" class="card-img" alt="<%= movieName %>" onerror="this.src='images/default.jpg'">
        <div class="card-img-overlay"></div>
      </div>
    </div>
    <div class="col-md-8">
      <div class="card-body">
        <h5 class="card-title"><i class="fas fa-clapperboard me-2"></i><%= movieName %></h5>
        <p class="card-text"><%= movieDesc %></p>

        <!-- Like Button -->
        <form action="like_toggle.jsp" method="post" style="display:inline;">
          <input type="hidden" name="item_id" value="<%= movieId %>"/>
          <input type="hidden" name="item_type" value="movie"/>
          <button type="submit" class="btn btn-like <%= likedByUser ? "btn-danger" : "btn-outline-danger" %>">
            <i class="fas <%= likedByUser ? "fa-heart" : "fa-heart-circle-plus" %> me-1"></i>
            <%= likedByUser ? "Liked" : "Like" %> (<%= totalLikes %>)
          </button>
        </form>

        <!-- Comment Form -->
        <%
          if (currentUserId != null) {
        %>
        <form action="comment_add.jsp" method="post" class="mt-4">
          <input type="hidden" name="item_id" value="<%= movieId %>"/>
          <input type="hidden" name="item_type" value="movie"/>
          <div class="input-group">
            <textarea name="content" class="form-control comment-box" rows="3" placeholder="Share your thoughts on this movie..." required></textarea>
            <button type="submit" class="btn btn-comment">
              <i class="fas fa-paper-plane me-1"></i> Post
            </button>
          </div>
        </form>
        <%
          } else {
        %>
        <p class="login-prompt mt-4">
          <i class="fas fa-sign-in-alt me-1"></i> Please <a href="login.jsp">login</a> to share your thoughts.
        </p>
        <%
          }
        %>

        <!-- Show Comments -->
        <div class="comment-section">
          <%
            PreparedStatement cStmt = conn.prepareStatement(
              "SELECT c.*, u.name FROM comment c JOIN user u ON c.user_id = u.id WHERE c.item_type = 'movie' AND c.item_id = ? ORDER BY c.timestamp DESC");
            cStmt.setInt(1, movieId);
            ResultSet cRs = cStmt.executeQuery();

            while (cRs.next()) {
          %>
          <div class="comment">
            <div class="d-flex align-items-center mb-1">
              <strong class="comment-author"><i class="fas fa-user-circle me-1"></i><%= cRs.getString("name") %></strong>
              <span class="comment-timestamp ms-2">(<%= cRs.getString("timestamp") %>)</span>
            </div>
            <p class="mb-0"><%= cRs.getString("content") %></p>
          </div>
          <%
            }
            cRs.close();
            cStmt.close();
          %>
        </div>
      </div>
    </div>
  </div>
</div>

<%
  } // end while
  rs.close();
  stmt.close();
  conn.close();
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Add smooth scroll to comment section when new comment is posted
  document.querySelectorAll('form[action="comment_add.jsp"]').forEach(form => {
    form.addEventListener('submit', () => {
      setTimeout(() => {
        const commentSection = form.nextElementSibling.nextElementSibling;
        commentSection.scrollTo({ top: 0, behavior: 'smooth' });
      }, 500);
    });
  });
</script>
<jsp:include page="footer.jsp" />
</body>
</html>