<%@ page import="java.sql.*, db.DBConnection" %>
<%
  Connection conn = DBConnection.getConnection();
  Integer currentUserId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Explore Bangladesh</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body style="background-color: #f8f9fa;">
<jsp:include page="header.jsp" />
<!-- Navbar -->



<!-- Navbar -->

<%@ page import="java.lang.String" %>
<%
  String currentUser = (String) session.getAttribute("userName");
%>



<jsp:include page="banner.jsp" />





<!-- <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">Explore Bangladesh</a>
    <div>
      <a href="index.jsp" class="btn btn-outline-light me-2">Home</a>
      <a href="about.jsp" class="btn btn-outline-light">About</a>
      Other nav items
    </div>
  </div>
</nav> -->








<form action="index.jsp" method="get" class="mb-4 text-center">

</form>
<div class="container">
 


<!-- Navbar -->


<jsp:include page="welcome_section.jsp" />

  <!-- Foods Section -->
  <!-- ############################################### -->
  <!-- Foods Section -->
  <!-- Add this Bootstrap Icons CSS in your <head> if not already -->
 <!-- Add animate.css and Bootstrap Icons (already in head) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<!-- Custom CSS for Enhanced Styling -->
<style>
  .food-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    background: #fff;
    border-radius: 20px;
    overflow: hidden;
  }
  .food-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15) !important;
  }
  .food-card img {
    border-radius: 20px 20px 0 0;
    transition: transform 0.5s ease;
  }
  .food-card:hover img {
    transform: scale(1.05);
  }
  .btn-success, .btn-outline-success, .btn-outline-primary {
    transition: all 0.3s ease;
  }
  .btn-success:hover, .btn-outline-success:hover, .btn-outline-primary:hover {
    transform: scale(1.05);
  }
  .comments-container::-webkit-scrollbar {
    width: 8px;
  }
  .comments-container::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
  }
  .comments-container::-webkit-scrollbar-thumb {
    background: #28a745;
    border-radius: 10px;
  }
  .tooltip-inner {
    background-color: #28a745;
    color: #fff;
    border-radius: 8px;
  }
  .modal-content {
    border-radius: 15px;
    border: none;
  }
  .filter-btn.active {
    background-color: #28a745 !important;
    color: #fff !important;
    transform: scale(1.05);
  }
  .share-btn {
    cursor: pointer;
  }
</style>

<!-- Popular Foods of Bangladesh Section -->
<div class="container-fluid py-5" style="background: linear-gradient(rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0.95)), url('images/food-pattern.jpg'); background-size: cover; background-attachment: fixed;">
  <div class="container">
    <h2 class="mt-5 mb-4 text-center fw-bold text-success animate__animated animate__fadeInDown">
      <i class="bi bi-egg-fried me-2"></i>Popular Foods of Bangladesh
      <small class="d-block text-muted fs-6 mt-2">Explore the Vibrant Culinary Heritage</small>
    </h2>

    <!-- Food Category Filter -->
    <div class="d-flex justify-content-center mb-4 animate__animated animate__fadeIn">
      <div class="btn-group btn-group-sm" role="group" id="foodFilter">
        <button type="button" class="btn btn-outline-success filter-btn active" data-filter="all">All</button>
        <button type="button" class="btn btn-outline-success filter-btn" data-filter="street">Street Food</button>
        <button type="button" class="btn btn-outline-success filter-btn" data-filter="traditional">Traditional</button>
        <button type="button" class="btn btn-outline-success filter-btn" data-filter="festive">Festive</button>
        <button type="button" class="btn btn-outline-success filter-btn" data-filter="desserts">Desserts</button>
      </div>
    </div>

    <!-- Food Items -->
    <div class="row g-4" id="foodContainer">
      <%
        boolean hasData = false;
        try {
          PreparedStatement stmtFood = conn.prepareStatement("SELECT * FROM food ORDER BY id DESC LIMIT 3");
          ResultSet rsFood = stmtFood.executeQuery();
          int foodCounter = 0;

          while (rsFood.next()) {
            hasData = true;
            foodCounter++;
            int id = rsFood.getInt("id");
            String name = rsFood.getString("name") != null ? rsFood.getString("name") : "Unknown Dish";
            String description = rsFood.getString("description") != null ? rsFood.getString("description") : "No description available.";
            String image = rsFood.getString("image") != null ? rsFood.getString("image") : "images/default-food.jpg";
            String category;
            try {
              category = rsFood.getString("category") != null ? rsFood.getString("category").toLowerCase() : "traditional";
            } catch (SQLException e) {
              category = "traditional"; // Fallback if category column doesn't exist
              out.println("<!-- Warning: Category column missing: " + e.getMessage() + " -->");
            }

            int totalLikes = 0;
            int totalComments = 0;
            try {
              PreparedStatement likeCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM likes WHERE item_type = 'food' AND item_id = ?");
              likeCountStmt.setInt(1, id);
              ResultSet likeCountRs = likeCountStmt.executeQuery();
              if (likeCountRs.next()) {
                totalLikes = likeCountRs.getInt("total");
              }
              likeCountRs.close();
              likeCountStmt.close();

              PreparedStatement commentCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM comment WHERE item_type = 'food' AND item_id = ?");
              commentCountStmt.setInt(1, id);
              ResultSet commentCountRs = commentCountStmt.executeQuery();
              if (commentCountRs.next()) {
                totalComments = commentCountRs.getInt("total");
              }
              commentCountRs.close();
              commentCountStmt.close();
            } catch (SQLException e) {
              out.println("<!-- Error fetching likes/comments: " + e.getMessage() + " -->");
            }

            boolean likedByUser = false;
            if (currentUserId != null) {
              try {
                PreparedStatement userLikeStmt = conn.prepareStatement("SELECT * FROM likes WHERE user_id = ? AND item_id = ? AND item_type = 'food'");
                userLikeStmt.setInt(1, currentUserId);
                userLikeStmt.setInt(2, id);
                ResultSet userLikeRs = userLikeStmt.executeQuery();
                likedByUser = userLikeRs.next();
                userLikeRs.close();
                userLikeStmt.close();
              } catch (SQLException e) {
                out.println("<!-- Error checking user like: " + e.getMessage() + " -->");
              }
            }
      %>
      <div class="col-md-4 mb-4 animate__animated animate__fadeInUp food-item" data-category="<%= category %>" style="animation-delay: <%= foodCounter * 0.1 %>s;">
        <div class="card h-100 border-0 shadow-lg food-card">
          <div class="position-relative">
            <img src="<%= image %>" class="card-img-top" alt="<%= name %>" style="height: 250px; object-fit: cover;" onerror="this.src='images/default-food.jpg'">
            <div class="position-absolute top-0 end-0 bg-success text-white px-2 py-1 rounded-bl" style="font-size: 0.8rem;">
              <i class="bi bi-award-fill me-1"></i>Popular
            </div>
          </div>
          <div class="card-body d-flex flex-column">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <h5 class="card-title text-success mb-0">
                <i class="bi bi-<%= foodCounter == 1 ? "egg-fried" : foodCounter == 2 ? "cup-hot" : "egg" %> text-warning me-2"></i>
                <%= name %>
              </h5>
              <span class="badge bg-success bg-opacity-10 text-success text-capitalize"><%= category %></span>
            </div>
            <p class="card-text mb-3 text-muted" style="font-size: 0.95rem;"><%= description %></p>

            <!-- Rating and Interaction Buttons -->
            <div class="mb-3">
              <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center" data-bs-toggle="tooltip" data-bs-placement="top" title="Based on 120 user reviews">
                  <div class="rating-stars me-2">
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-half text-warning"></i>
                  </div>
                  <small class="text-muted">4.5 (120)</small>
                </div>
                <button class="btn btn-sm btn-outline-primary share-btn" onclick="shareDish('<%= name %>', '<%= id %>')" data-bs-toggle="tooltip" data-bs-placement="top" title="Share this dish">
                  <i class="bi bi-share-fill"></i>
                </button>
              </div>
            </div>

            <!-- Like Button -->
            <form action="like_toggle.jsp" method="post" class="mb-3">
              <input type="hidden" name="item_id" value="<%= id %>">
              <input type="hidden" name="item_type" value="food">
              <button type="submit" class="btn btn-sm <%= likedByUser ? "btn-danger" : "btn-outline-danger" %> position-relative overflow-hidden" data-bs-toggle="tooltip" data-bs-placement="top" title="<%= likedByUser ? "Unlike this dish" : "Like this dish" %>">
                <i class="bi <%= likedByUser ? "bi-heart-fill" : "bi-heart" %> me-1"></i>Like (<%= totalLikes %>)
                <span class="position-absolute top-0 start-0 w-100 h-100 bg-danger opacity-10" style="border-radius: inherit;"></span>
              </button>
            </form>

            <!-- Comment Section -->
            <% if (currentUserId != null) { %>
              <form action="comment_add.jsp" method="post" class="mb-3">
                <input type="hidden" name="item_id" value="<%= id %>">
                <input type="hidden" name="item_type" value="food">
                <div class="input-group">
                  <textarea name="content" class="form-control" rows="2" placeholder="Share your thoughts..." style="border-radius: 8px 0 0 8px; resize: none;" required></textarea>
                  <button type="submit" class="btn btn-primary" style="border-radius: 0 8px 8px 0;">
                    <i class="bi bi-send-fill"></i>
                  </button>
                </div>
              </form>
            <% } else { %>
              <div class="alert alert-light border mb-3 text-center py-2" style="border-radius: 8px;">
                <i class="bi bi-lock-fill me-1"></i> <a href="login.jsp" class="text-decoration-none">Login</a> to join the conversation
              </div>
            <% } %>

            <!-- Comments Section -->
            <div class="mt-auto">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <h6 class="mb-0 text-muted"><i class="bi bi-chat-square-text-fill me-1"></i> Recent Comments (<%= totalComments %>)</h6>
                <small class="text-muted" data-bs-toggle="tooltip" data-bs-placement="top" title="Total interactions"><i class="bi bi-people-fill me-1"></i><%= totalLikes + totalComments %> interactions</small>
              </div>
              <div class="comments-container" style="max-height: 200px; overflow-y: auto;">
                <%
                  try {
                    PreparedStatement cStmt = conn.prepareStatement("SELECT c.*, u.name FROM comment c JOIN user u ON c.user_id = u.id WHERE c.item_type = 'food' AND c.item_id = ? ORDER BY c.timestamp DESC LIMIT 2");
                    cStmt.setInt(1, id);
                    ResultSet cRs = cStmt.executeQuery();
                    while (cRs.next()) {
                      String commentName = cRs.getString("name") != null ? cRs.getString("name") : "Anonymous";
                      String commentContent = cRs.getString("content") != null ? cRs.getString("content") : "";
                      String commentTimestamp = cRs.getString("timestamp") != null ? cRs.getString("timestamp") : "Unknown time";
                %>
                <div class="border rounded p-2 mb-2 bg-light position-relative animate__animated animate__fadeIn" style="border-radius: 10px;">
                  <div class="d-flex align-items-center mb-1">
                    <div class="bg-success rounded-circle me-2" style="width: 30px; height: 30px; display: flex; align-items: center; justify-content: center;">
                      <i class="bi bi-person-fill text-white"></i>
                    </div>
                    <div>
                      <strong class="text-success"><%= commentName %></strong>
                      <small class="text-muted d-block"><i class="bi bi-clock"></i> <%= commentTimestamp %></small>
                    </div>
                  </div>
                  <p class="mb-0 ps-4"><%= commentContent %></p>
                </div>
                <%
                    }
                    cRs.close();
                    cStmt.close();
                  } catch (SQLException e) {
                    out.println("<!-- Error fetching comments: " + e.getMessage() + " -->");
                  }
                %>
              </div>
            </div>
          </div>
          <div class="card-footer bg-transparent border-top-0 text-end">
            <button type="button" class="btn btn-sm btn-outline-success" data-bs-toggle="modal" data-bs-target="#foodModal<%= id %>">
              <i class="bi bi-arrow-right-circle me-1"></i>Quick View
            </button>
          </div>
        </div>

        <!-- Modal for Quick View -->
        <div class="modal fade" id="foodModal<%= id %>" tabindex="-1" aria-labelledby="foodModalLabel<%= id %>" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header border-0">
                <h5 class="modal-title text-success" id="foodModalLabel<%= id %>"><i class="bi bi-egg-fried me-2"></i><%= name %></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <img src="<%= image %>" class="img-fluid rounded mb-3" alt="<%= name %>" style="max-height: 200px; object-fit: cover;" onerror="this.src='images/default-food.jpg'">
                <p class="text-muted"><%= description %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="badge bg-success bg-opacity-10 text-success text-capitalize"><%= category %></span>
                  <div>
                    <i class="bi bi-star-fill text-warning"></i> 4.5 (120 reviews)
                  </div>
                </div>
              </div>
              <div class="modal-footer border-0">
                <a href="food_details.jsp?id=<%= id %>" class="btn btn-success">View Full Details</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <%
          }
          rsFood.close();
          stmtFood.close();
          if (!hasData) {
      %>
      <div class="col-12 text-center">
        <div class="alert alert-info" role="alert">
          No food items available at the moment. Check back later!
        </div>
      </div>
      <%
          }
        } catch (SQLException e) {
          out.println("<div class='col-12 text-center'><div class='alert alert-danger' role='alert'>Error loading food items: " + e.getMessage() + "</div></div>");
        }
      %>
    </div>

    <!-- View All Button -->
    <div class="text-center mt-4 animate__animated animate__fadeIn">
      <a href="food.jsp" class="btn btn-success px-4 py-2" style="border-radius: 30px;">
        <i class="bi bi-arrow-right-circle-fill me-2"></i>Explore All Bangladeshi Cuisine
      </a>
    </div>

    <!-- Food Facts Carousel -->
    <div class="row mt-5 animate__animated animate__fadeIn">
      <div class="col-12">
        <div id="foodFactsCarousel" class="carousel slide bg-success bg-opacity-10 p-4 rounded-3" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-success"><i class="bi bi-lightbulb-fill me-2"></i>Did You Know?</h5>
                  <p class="mb-0">Bangladeshi cuisine features over 100 unique dishes with bold flavors and aromatic spices.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/biryani.jpg" alt="Biryani" style="height: 80px;" class="img-fluid" onerror="this.src='images/default-food.jpg'">
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-success"><i class="bi bi-lightbulb-fill me-2"></i>Fun Fact</h5>
                  <p class="mb-0">Pitha, a traditional Bangladeshi rice cake, is a festive favorite during winter celebrations.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/pitha.jpg" alt="Pitha" style="height: 80px;" class="img-fluid" onerror="this.src='images/default-food.jpg'">
                </div>
              </div>
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#foodFactsCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#foodFactsCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- JavaScript for Filter, Tooltips, and Share -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Initialize Tooltips
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

  // Filter Functionality
  document.querySelectorAll('#foodFilter .filter-btn').forEach(button => {
    button.addEventListener('click', () => {
      document.querySelectorAll('#foodFilter .filter-btn').forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');

      const filter = button.getAttribute('data-filter');
      const foodItems = document.querySelectorAll('.food-item');

      foodItems.forEach(item => {
        if (filter === 'all' || item.getAttribute('data-category') === filter) {
          item.style.display = 'block';
          item.classList.remove('animate__fadeOut');
          item.classList.add('animate__fadeIn');
        } else {
          item.classList.remove('animate__fadeIn');
          item.classList.add('animate__fadeOut');
          setTimeout(() => { item.style.display = 'none'; }, 300);
        }
      });
    });
  });

  // Share Functionality
  function shareDish(name, id) {
    const shareUrl = window.location.origin + '/food_details.jsp?id=' + id;
    const shareText = 'Check out this delicious Bangladeshi dish: ' + name + '!';
    if (navigator.share) {
      navigator.share({
        title: name,
        text: shareText,
        url: shareUrl
      }).catch(err => console.log('Share error:', err));
    } else {
      prompt('Copy this link to share:', shareUrl);
    }
  }
</script>

  <!-- Scenery Section -->
  <!-- ############################################################# -->
  <!-- Scenery Section -->
  
 <!-- Custom CSS for Scenery Section -->
<style>
  .scenery-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    background: #fff;
    border-radius: 20px;
    overflow: hidden;
  }
  .scenery-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15) !important;
  }
  .scenery-card img {
    border-radius: 20px 20px 0 0;
    transition: transform 0.5s ease;
  }
  .scenery-card:hover img {
    transform: scale(1.05);
  }
  .comments-container::-webkit-scrollbar {
    width: 8px;
  }
  .comments-container::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
  }
  .comments-container::-webkit-scrollbar-thumb {
    background: #0d6efd;
    border-radius: 10px;
  }
  .filter-btn.active {
    background-color: #0d6efd !important;
    color: #fff !important;
    transform: scale(1.05);
  }
</style>

<!-- Famous Tourist Attractions Section -->
<div class="container-fluid py-5" style="background: linear-gradient(rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0.95)), url('images/scenery-pattern.jpg'); background-size: cover; background-attachment: fixed;">
  <div class="container">
    <h2 class="mt-5 mb-4 text-center fw-bold text-primary animate__animated animate__fadeInDown">
      <i class="bi bi-map-fill me-2"></i>Famous Tourist Attractions
      <small class="d-block text-muted fs-6 mt-2">Discover the Natural Beauty of Bangladesh</small>
    </h2>

    <!-- Scenery Category Filter -->
    <div class="d-flex justify-content-center mb-4 animate__animated animate__fadeIn">
      <div class="btn-group btn-group-sm" role="group" id="sceneryFilter">
        <button type="button" class="btn btn-outline-primary filter-btn active" data-filter="all">All</button>
        <button type="button" class="btn btn-outline-primary filter-btn" data-filter="beach">Beaches</button>
        <button type="button" class="btn btn-outline-primary filter-btn" data-filter="hill">Hills</button>
        <button type="button" class="btn btn-outline-primary filter-btn" data-filter="forest">Forests</button>
        <button type="button" class="btn btn-outline-primary filter-btn" data-filter="historical">Historical</button>
      </div>
    </div>

    <!-- Scenery Items -->
    <div class="row g-4" id="sceneryContainer">
      <%
        boolean hasData2 = false;
        try {
          PreparedStatement stmtScenery = conn.prepareStatement("SELECT * FROM scenery ORDER BY id DESC LIMIT 3");
          ResultSet rsScenery = stmtScenery.executeQuery();
          int sceneryCounter = 0;

          while (rsScenery.next()) {
            hasData = true;
            sceneryCounter++;
            int id = rsScenery.getInt("id");
            String name = rsScenery.getString("name") != null ? rsScenery.getString("name") : "Unknown Place";
            String description = rsScenery.getString("description") != null ? rsScenery.getString("description") : "No description available.";
            String image = rsScenery.getString("image") != null ? rsScenery.getString("image") : "images/default.jpg";
            String category;
            try {
              category = rsScenery.getString("category") != null ? rsScenery.getString("category").toLowerCase() : "historical";
            } catch (SQLException e) {
              category = "historical";
              out.println("<!-- Warning: Scenery category column missing: " + e.getMessage() + " -->");
            }

            int totalLikes = 0;
            int totalComments = 0;
            try {
              PreparedStatement likeCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM likes WHERE item_type = 'scenery' AND item_id = ?");
              likeCountStmt.setInt(1, id);
              ResultSet likeCountRs = likeCountStmt.executeQuery();
              if (likeCountRs.next()) {
                totalLikes = likeCountRs.getInt("total");
              }
              likeCountRs.close();
              likeCountStmt.close();

              PreparedStatement commentCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM comment WHERE item_type = 'scenery' AND item_id = ?");
              commentCountStmt.setInt(1, id);
              ResultSet commentCountRs = commentCountStmt.executeQuery();
              if (commentCountRs.next()) {
                totalComments = commentCountRs.getInt("total");
              }
              commentCountRs.close();
              commentCountStmt.close();
            } catch (SQLException e) {
              out.println("<!-- Error fetching scenery likes/comments: " + e.getMessage() + " -->");
            }

            boolean likedByUser = false;
            if (currentUserId != null) {
              try {
                PreparedStatement userLikeStmt = conn.prepareStatement("SELECT * FROM likes WHERE user_id = ? AND item_id = ? AND item_type = 'scenery'");
                userLikeStmt.setInt(1, currentUserId);
                userLikeStmt.setInt(2, id);
                ResultSet userLikeRs = userLikeStmt.executeQuery();
                likedByUser = userLikeRs.next();
                userLikeRs.close();
                userLikeStmt.close();
              } catch (SQLException e) {
                out.println("<!-- Error checking scenery user like: " + e.getMessage() + " -->");
              }
            }
      %>
      <div class="col-md-4 mb-4 animate__animated animate__fadeInUp scenery-item" data-category="<%= category %>" style="animation-delay: <%= sceneryCounter * 0.1 %>s;">
        <div class="card h-100 border-0 shadow-lg scenery-card">
          <div class="position-relative">
            <img src="<%= image %>" class="card-img-top" alt="<%= name %>" style="height: 250px; object-fit: cover;" onerror="this.src='images/default.jpg'">
            <div class="position-absolute top-0 end-0 bg-primary text-white px-2 py-1 rounded-bl" style="font-size: 0.8rem;">
              <i class="bi bi-award-fill me-1"></i>Popular
            </div>
          </div>
          <div class="card-body d-flex flex-column">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <h5 class="card-title text-primary mb-0">
                <i class="bi bi-<%= sceneryCounter == 1 ? "geo-alt-fill" : sceneryCounter == 2 ? "tree-fill" : "water" %> text-warning me-2"></i>
                <%= name %>
              </h5>
              <span class="badge bg-primary bg-opacity-10 text-primary text-capitalize"><%= category %></span>
            </div>
            <p class="card-text mb-3 text-muted" style="font-size: 0.95rem;"><%= description %></p>

            <!-- Rating and Interaction Buttons -->
            <div class="mb-3">
              <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center" data-bs-toggle="tooltip" data-bs-placement="top" title="Based on 100 user reviews">
                  <div class="rating-stars me-2">
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-half text-warning"></i>
                  </div>
                  <small class="text-muted">4.5 (100)</small>
                </div>
                <button class="btn btn-sm btn-outline-primary share-btn" onclick="shareItem('scenery', '<%= name %>', '<%= id %>')" data-bs-toggle="tooltip" data-bs-placement="top" title="Share this place">
                  <i class="bi bi-share-fill"></i>
                </button>
              </div>
            </div>

            <!-- Like Button -->
            <form action="like_toggle.jsp" method="post" class="mb-3">
              <input type="hidden" name="item_id" value="<%= id %>">
              <input type="hidden" name="item_type" value="scenery">
              <button type="submit" class="btn btn-sm <%= likedByUser ? "btn-danger" : "btn-outline-danger" %> position-relative overflow-hidden" data-bs-toggle="tooltip" data-bs-placement="top" title="<%= likedByUser ? "Unlike this place" : "Like this place" %>">
                <i class="bi <%= likedByUser ? "bi-heart-fill" : "bi-heart" %> me-1"></i>Like (<%= totalLikes %>)
                <span class="position-absolute top-0 start-0 w-100 h-100 bg-danger opacity-10" style="border-radius: inherit;"></span>
              </button>
            </form>

            <!-- Comment Section -->
            <% if (currentUserId != null) { %>
              <form action="comment_add.jsp" method="post" class="mb-3">
                <input type="hidden" name="item_id" value="<%= id %>">
                <input type="hidden" name="item_type" value="scenery">
                <div class="input-group">
                  <textarea name="content" class="form-control" rows="2" placeholder="Share your thoughts..." style="border-radius: 8px 0 0 8px; resize: none;" required></textarea>
                  <button type="submit" class="btn btn-primary" style="border-radius: 0 8px 8px 0;">
                    <i class="bi bi-send-fill"></i>
                  </button>
                </div>
              </form>
            <% } else { %>
              <div class="alert alert-light border mb-3 text-center py-2" style="border-radius: 8px;">
                <i class="bi bi-lock-fill me-1"></i> <a href="login.jsp" class="text-decoration-none">Login</a> to join the conversation
              </div>
            <% } %>

            <!-- Comments Section -->
            <div class="mt-auto">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <h6 class="mb-0 text-muted"><i class="bi bi-chat-square-text-fill me-1"></i>Recent Comments (<%= totalComments %>)</h6>
                <small class="text-muted" data-bs-toggle="tooltip" data-bs-placement="top" title="Total interactions"><i class="bi bi-people-fill me-1"></i><%= totalLikes + totalComments %> interactions</small>
              </div>
              <div class="comments-container" style="max-height: 200px; overflow-y: auto;">
                <%
                  try {
                    PreparedStatement cStmt = conn.prepareStatement("SELECT c.*, u.name FROM comment c JOIN user u ON c.user_id = u.id WHERE c.item_type = 'scenery' AND c.item_id = ? ORDER BY c.timestamp DESC LIMIT 2");
                    cStmt.setInt(1, id);
                    ResultSet cRs = cStmt.executeQuery();
                    while (cRs.next()) {
                      String commentName = cRs.getString("name") != null ? cRs.getString("name") : "Anonymous";
                      String commentContent = cRs.getString("content") != null ? cRs.getString("content") : "";
                      String commentTimestamp = cRs.getString("timestamp") != null ? cRs.getString("timestamp") : "Unknown time";
                %>
                <div class="border rounded p-2 mb-2 bg-light position-relative animate__animated animate__fadeIn" style="border-radius: 10px;">
                  <div class="d-flex align-items-center mb-1">
                    <div class="bg-primary rounded-circle me-2" style="width: 30px; height: 30px; display: flex; align-items: center; justify-content: center;">
                      <i class="bi bi-person-fill text-white"></i>
                    </div>
                    <div>
                      <strong class="text-primary"><%= commentName %></strong>
                      <small class="text-muted d-block"><i class="bi bi-clock"></i> <%= commentTimestamp %></small>
                    </div>
                  </div>
                  <p class="mb-0 ps-4"><%= commentContent %></p>
                </div>
                <%
                    }
                    cRs.close();
                    cStmt.close();
                  } catch (SQLException e) {
                    out.println("<!-- Error fetching scenery comments: " + e.getMessage() + " -->");
                  }
                %>
              </div>
            </div>
          </div>
          <div class="card-footer bg-transparent border-top-0 text-end">
            <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#sceneryModal<%= id %>">
              <i class="bi bi-arrow-right-circle me-1"></i>Quick View
            </button>
          </div>
        </div>

        <!-- Modal for Quick View -->
        <div class="modal fade" id="sceneryModal<%= id %>" tabindex="-1" aria-labelledby="sceneryModalLabel<%= id %>" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header border-0">
                <h5 class="modal-title text-primary" id="sceneryModalLabel<%= id %>"><i class="bi bi-geo-alt-fill me-2"></i><%= name %></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <img src="<%= image %>" class="img-fluid rounded mb-3" alt="<%= name %>" style="max-height: 200px; object-fit: cover;" onerror="this.src='images/default.jpg'">
                <p class="text-muted"><%= description %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="badge bg-primary bg-opacity-10 text-primary text-capitalize"><%= category %></span>
                  <div>
                    <i class="bi bi-star-fill text-warning"></i> 4.5 (100 reviews)
                  </div>
                </div>
              </div>
              <div class="modal-footer border-0">
                <a href="scenery_details.jsp?id=<%= id %>" class="btn btn-primary">View Full Details</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <%
          }
          rsScenery.close();
          stmtScenery.close();
          if (!hasData) {
      %>
      <div class="col-12 text-center">
        <div class="alert alert-info" role="alert">
          No attractions available at the moment. Check back later!
        </div>
      </div>
      <%
          }
        } catch (SQLException e) {
          out.println("<div class='col-12 text-center'><div class='alert alert-danger' role='alert'>Error loading attractions: " + e.getMessage() + "</div></div>");
        }
      %>
    </div>

    <!-- View All Button -->
    <div class="text-center mt-4 animate__animated animate__fadeIn">
      <a href="scenery.jsp" class="btn btn-primary px-4 py-2" style="border-radius: 30px;">
        <i class="bi bi-arrow-right-circle-fill me-2"></i>Explore All Attractions
      </a>
    </div>

    <!-- Scenery Facts Carousel -->
    <div class="row mt-5 animate__animated animate__fadeIn">
      <div class="col-12">
        <div id="sceneryFactsCarousel" class="carousel slide bg-primary bg-opacity-10 p-4 rounded-3" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-primary"><i class="bi bi-lightbulb-fill me-2"></i>Did You Know?</h5>
                  <p class="mb-0">Bangladesh is home to the world’s longest natural sea beach, Cox’s Bazar, stretching over 120 km.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/coxs-bazar.jpg" alt="Cox’s Bazar" style="height: 80px;" class="img-fluid" onerror="this.src='images/default.jpg'">
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-primary"><i class="bi bi-lightbulb-fill me-2"></i>Fun Fact</h5>
                  <p class="mb-0">Sundarbans, a UNESCO World Heritage Site, is the largest mangrove forest in the world.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/sundarbans.jpg" alt="Sundarbans" style="height: 80px;" class="img-fluid" onerror="this.src='images/default.jpg'">
                </div>
              </div>
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#sceneryFactsCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#sceneryFactsCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>
  
  
<!-- Movie Section -->
<!-- ################################################################## -->
  <!-- Movie Section -->
  
  <!-- Popular Bangladeshi Movies Section -->
<div class="container-fluid py-5" style="background: linear-gradient(rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0.95)), url('images/movie-pattern.jpg'); background-size: cover; background-attachment: fixed;">
  <div class="container">
    <h2 class="mt-5 mb-4 text-center fw-bold text-warning animate__animated animate__fadeInDown">
      <i class="bi bi-film me-2"></i>Popular Bangladeshi Movies
      <small class="d-block text-muted fs-6 mt-2">Discover the Cinematic Gems of Bangladesh</small>
    </h2>

    <!-- Movie Category Filter -->
    <div class="d-flex justify-content-center mb-4 animate__animated animate__fadeIn">
      <div class="btn-group btn-group-sm" role="group" id="movieFilter">
        <button type="button" class="btn btn-outline-warning filter-btn active" data-filter="all">All</button>
        <button type="button" class="btn btn-outline-warning filter-btn" data-filter="drama">Drama</button>
        <button type="button" class="btn btn-outline-warning filter-btn" data-filter="action">Action</button>
        <button type="button" class="btn btn-outline-warning filter-btn" data-filter="romance">Romance</button>
        <button type="button" class="btn btn-outline-warning filter-btn" data-filter="comedy">Comedy</button>
      </div>
    </div>

    <!-- Movie Items -->
    <div class="row g-4" id="movieContainer">
      <%
        boolean dataExists = false;
        try {
          PreparedStatement stmtMovie = conn.prepareStatement("SELECT * FROM movie ORDER BY id DESC LIMIT 3");
          ResultSet rsMovie = stmtMovie.executeQuery();
          int movieCounter = 0;

          while (rsMovie.next()) {
            dataExists = true;
            movieCounter++;
            int id = rsMovie.getInt("id");
            String name = rsMovie.getString("name") != null ? rsMovie.getString("name") : "Unknown Movie";
            String description = rsMovie.getString("description") != null ? rsMovie.getString("description") : "No description available.";
            String image = rsMovie.getString("image") != null ? rsMovie.getString("image") : "images/default.jpg";
            String category;
            try {
              category = rsMovie.getString("category") != null ? rsMovie.getString("category").toLowerCase() : "drama";
            } catch (SQLException e) {
              category = "drama"; // Fallback if category column doesn't exist
              out.println("<!-- Warning: Category column missing: " + e.getMessage() + " -->");
            }

            int totalLikes = 0;
            int totalComments = 0;
            try {
              PreparedStatement likeCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM likes WHERE item_type = 'movie' AND item_id = ?");
              likeCountStmt.setInt(1, id);
              ResultSet likeCountRs = likeCountStmt.executeQuery();
              if (likeCountRs.next()) {
                totalLikes = likeCountRs.getInt("total");
              }
              likeCountRs.close();
              likeCountStmt.close();

              PreparedStatement commentCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM comment WHERE item_type = 'movie' AND item_id = ?");
              commentCountStmt.setInt(1, id);
              ResultSet commentCountRs = commentCountStmt.executeQuery();
              if (commentCountRs.next()) {
                totalComments = commentCountRs.getInt("total");
              }
              commentCountRs.close();
              commentCountStmt.close();
            } catch (SQLException e) {
              out.println("<!-- Error fetching likes/comments: " + e.getMessage() + " -->");
            }

            boolean likedByUser = false;
            if (currentUserId != null) {
              try {
                PreparedStatement userLikeStmt = conn.prepareStatement("SELECT * FROM likes WHERE user_id = ? AND item_id = ? AND item_type = 'movie'");
                userLikeStmt.setInt(1, currentUserId);
                userLikeStmt.setInt(2, id);
                ResultSet userLikeRs = userLikeStmt.executeQuery();
                likedByUser = userLikeRs.next();
                userLikeRs.close();
                userLikeStmt.close();
              } catch (SQLException e) {
                out.println("<!-- Error checking user like: " + e.getMessage() + " -->");
              }
            }
      %>
      <div class="col-md-4 mb-4 animate__animated animate__fadeInUp movie-item" data-category="<%= category %>" style="animation-delay: <%= movieCounter * 0.1 %>s;">
        <div class="card h-100 border-0 shadow-lg movie-card">
          <div class="position-relative">
            <img src="<%= image %>" class="card-img-top" alt="<%= name %>" style="height: 250px; object-fit: cover;" onerror="this.src='images/default.jpg'">
            <div class="position-absolute top-0 end-0 bg-warning text-dark px-2 py-1 rounded-bl" style="font-size: 0.8rem;">
              <i class="bi bi-award-fill me-1"></i>Popular
            </div>
          </div>
          <div class="card-body d-flex flex-column">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <h5 class="card-title text-warning mb-0">
                <i class="bi bi-<%= movieCounter == 1 ? "camera-reels" : movieCounter == 2 ? "film" : "clapperboard" %> text-danger me-2"></i>
                <%= name %>
              </h5>
              <span class="badge bg-warning bg-opacity-10 text-warning text-capitalize"><%= category %></span>
            </div>
            <p class="card-text mb-3 text-muted" style="font-size: 0.95rem;"><%= description %></p>

            <!-- Rating and Interaction Buttons -->
            <div class="mb-3">
              <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center" data-bs-toggle="tooltip" data-bs-placement="top" title="Based on 150 user reviews">
                  <div class="rating-stars me-2">
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-fill text-warning"></i>
                    <i class="bi bi-star-half text-warning"></i>
                  </div>
                  <small class="text-muted">4.5 (150)</small>
                </div>
                <button class="btn btn-sm btn-outline-primary share-btn" onclick="shareMovie('<%= name %>', '<%= id %>')" data-bs-toggle="tooltip" data-bs-placement="top" title="Share this movie">
                  <i class="bi bi-share-fill"></i>
                </button>
              </div>
            </div>

            <!-- Like Button -->
            <form action="like_toggle.jsp" method="post" class="mb-3">
              <input type="hidden" name="item_id" value="<%= id %>">
              <input type="hidden" name="item_type" value="movie">
              <button type="submit" class="btn btn-sm <%= likedByUser ? "btn-danger" : "btn-outline-danger" %> position-relative overflow-hidden" data-bs-toggle="tooltip" data-bs-placement="top" title="<%= likedByUser ? "Unlike this movie" : "Like this movie" %>">
                <i class="bi <%= likedByUser ? "bi-heart-fill" : "bi-heart" %> me-1"></i>Like (<%= totalLikes %>)
                <span class="position-absolute top-0 start-0 w-100 h-100 bg-danger opacity-10" style="border-radius: inherit;"></span>
              </button>
            </form>

            <!-- Comment Section -->
            <% if (currentUserId != null) { %>
              <form action="comment_add.jsp" method="post" class="mb-3">
                <input type="hidden" name="item_id" value="<%= id %>">
                <input type="hidden" name="item_type" value="movie">
                <div class="input-group">
                  <textarea name="content" class="form-control" rows="2" placeholder="Share your thoughts..." style="border-radius: 8px 0 0 8px; resize: none;" required></textarea>
                  <button type="submit" class="btn btn-primary" style="border-radius: 0 8px 8px 0;">
                    <i class="bi bi-send-fill"></i>
                  </button>
                </div>
              </form>
            <% } else { %>
              <div class="alert alert-light border mb-3 text-center py-2" style="border-radius: 8px;">
                <i class="bi bi-lock-fill me-1"></i> <a href="login.jsp" class="text-decoration-none">Login</a> to join the conversation
              </div>
            <% } %>

            <!-- Comments Section -->
            <div class="mt-auto">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <h6 class="mb-0 text-muted"><i class="bi bi-chat-square-text-fill me-1"></i> Recent Comments (<%= totalComments %>)</h6>
                <small class="text-muted" data-bs-toggle="tooltip" data-bs-placement="top" title="Total interactions"><i class="bi bi-people-fill me-1"></i><%= totalLikes + totalComments %> interactions</small>
              </div>
              <div class="movie-comments-container" style="max-height: 200px; overflow-y: auto;">
                <%
                  try {
                    PreparedStatement cStmt = conn.prepareStatement("SELECT c.*, u.name FROM comment c JOIN user u ON c.user_id = u.id WHERE c.item_type = 'movie' AND c.item_id = ? ORDER BY c.timestamp DESC LIMIT 2");
                    cStmt.setInt(1, id);
                    ResultSet cRs = cStmt.executeQuery();
                    while (cRs.next()) {
                      String commentName = cRs.getString("name") != null ? cRs.getString("name") : "Anonymous";
                      String commentContent = cRs.getString("content") != null ? cRs.getString("content") : "";
                      String commentTimestamp = cRs.getString("timestamp") != null ? cRs.getString("timestamp") : "Unknown time";
                %>
                <div class="border rounded p-2 mb-2 bg-light position-relative animate__animated animate__fadeIn" style="border-radius: 10px;">
                  <div class="d-flex align-items-center mb-1">
                    <div class="bg-warning rounded-circle me-2" style="width: 30px; height: 30px; display: flex; align-items: center; justify-content: center;">
                      <i class="bi bi-person-fill text-dark"></i>
                    </div>
                    <div>
                      <strong class="text-warning"><%= commentName %></strong>
                      <small class="text-muted d-block"><i class="bi bi-clock"></i> <%= commentTimestamp %></small>
                    </div>
                  </div>
                  <p class="mb-0 ps-4"><%= commentContent %></p>
                </div>
                <%
                    }
                    cRs.close();
                    cStmt.close();
                  } catch (SQLException e) {
                    out.println("<!-- Error fetching comments: " + e.getMessage() + " -->");
                  }
                %>
              </div>
            </div>
          </div>
          <div class="card-footer bg-transparent border-top-0 text-end">
            <button type="button" class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#movieModal<%= id %>">
              <i class="bi bi-arrow-right-circle me-1"></i>Quick View
            </button>
          </div>
        </div>

        <!-- Modal for Quick View -->
        <div class="modal fade" id="movieModal<%= id %>" tabindex="-1" aria-labelledby="movieModalLabel<%= id %>" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header border-0">
                <h5 class="modal-title text-warning" id="movieModalLabel<%= id %>"><i class="bi bi-film me-2"></i><%= name %></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <img src="<%= image %>" class="img-fluid rounded mb-3" alt="<%= name %>" style="max-height: 200px; object-fit: cover;" onerror="this.src='images/default.jpg'">
                <p class="text-muted"><%= description %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="badge bg-warning bg-opacity-10 text-warning text-capitalize"><%= category %></span>
                  <div>
                    <i class="bi bi-star-fill text-warning"></i> 4.5 (150 reviews)
                  </div>
                </div>
              </div>
              <div class="modal-footer border-0">
                <a href="movie_details.jsp?id=<%= id %>" class="btn btn-warning">View Full Details</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <%
          }
          rsMovie.close();
          stmtMovie.close();
          if (!dataExists) {
      %>
      <div class="col-12 text-center">
        <div class="alert alert-info" role="alert">
          No movies available at the moment. Check back later!
        </div>
      </div>
      <%
          }
        } catch (SQLException e) {
          out.println("<div class='col-12 text-center'><div class='alert alert-danger' role='alert'>Error loading movies: " + e.getMessage() + "</div></div>");
        }
      %>
    </div>

    <!-- View All Button -->
    <div class="text-center mt-4 animate__animated animate__fadeIn">
      <a href="movie.jsp" class="btn btn-warning px-4 py-2" style="border-radius: 30px;">
        <i class="bi bi-arrow-right-circle-fill me-2"></i>Explore All Bangladeshi Movies
      </a>
    </div>

    <!-- Movie Facts Carousel -->
    <div class="row mt-5 animate__animated animate__fadeIn">
      <div class="col-12">
        <div id="movieFactsCarousel" class="carousel slide bg-warning bg-opacity-10 p-4 rounded-3" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-warning"><i class="bi bi-lightbulb-fill me-2"></i>Did You Know?</h5>
                  <p class="mb-0">Bangladeshi cinema, known as Dhallywood, produces over 80 films annually, blending rich storytelling with cultural themes.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/movie-poster1.jpg" alt="Movie Poster" style="height: 80px;" class="img-fluid" onerror="this.src='images/default.jpg'">
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-warning"><i class="bi bi-lightbulb-fill me-2"></i>Fun Fact</h5>
                  <p class="mb-0">The first Bangladeshi feature film, "Mukh O Mukhosh," was released in 1956, marking the birth of Dhallywood.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/movie-poster2.jpg" alt="Movie Poster" style="height: 80px;" class="img-fluid" onerror="this.src='images/default.jpg'">
                </div>
              </div>
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#movieFactsCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#movieFactsCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Additional CSS for Movies Section -->
<style>
  .movie-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    background: #fff;
    border-radius: 20px;
    overflow: hidden;
  }
  .movie-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15) !important;
  }
  .movie-card img {
    border-radius: 20px 20px 0 0;
    transition: transform 0.5s ease;
  }
  .movie-card:hover img {
    transform: scale(1.05);
  }
  .btn-warning, .btn-outline-warning {
    transition: all 0.3s ease;
  }
  .btn-warning:hover, .btn-outline-warning:hover {
    transform: scale(1.05);
  }
  .movie-filter-btn.active {
    background-color: #ffc107 !important;
    color: #212529 !important;
    transform: scale(1.05);
  }
  .movie-comments-container::-webkit-scrollbar {
    width: 8px;
  }
  .movie-comments-container::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
  }
  .movie-comments-container::-webkit-scrollbar-thumb {
    background: #ffc107;
    border-radius: 10px;
  }
</style>

<!-- JavaScript for Filter, Tooltips, and Share -->
<script>
  // Initialize Tooltips for Movies
  const movieTooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  const movieTooltipList = [...movieTooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

  // Filter Functionality for Movies
  document.querySelectorAll('#movieFilter .filter-btn').forEach(button => {
    button.addEventListener('click', () => {
      document.querySelectorAll('#movieFilter .filter-btn').forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');

      const filter = button.getAttribute('data-filter');
      const movieItems = document.querySelectorAll('.movie-item');

      movieItems.forEach(item => {
        if (filter === 'all' || item.getAttribute('data-category') === filter) {
          item.style.display = 'block';
          item.classList.remove('animate__fadeOut');
          item.classList.add('animate__fadeIn');
        } else {
          item.classList.remove('animate__fadeIn');
          item.classList.add('animate__fadeOut');
          setTimeout(() => { item.style.display = 'none'; }, 300);
        }
      });
    });
  });

  // Share Functionality for Movies
  function shareMovie(name, id) {
    const shareUrl = window.location.origin + '/movie_details.jsp?id=' + id;
    const shareText = 'Check out this amazing Bangladeshi movie: ' + name + '!';
    if (navigator.share) {
      navigator.share({
        title: name,
        text: shareText,
        url: shareUrl
      }).catch(err => console.log('Share error:', err));
    } else {
      prompt('Copy this link to share:', shareUrl);
    }
  }
</script>
   
   
  <!-- Music Section -->
  <!-- ################################################################# -->
  <!-- Music Section -->
  
  
  <!-- Bangladeshi Music & Artists Section -->
<div class="container-fluid py-5" style="background: linear-gradient(rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0.95)), url('images/music-pattern.jpg'); background-size: cover; background-attachment: fixed;">
  <div class="container">
    <h2 class="mt-5 mb-4 text-center fw-bold text-info animate__animated animate__fadeInDown">
      <i class="bi bi-music-note-beamed me-2"></i>Bangladeshi Music & Artists
      <small class="d-block text-muted fs-6 mt-2">Celebrate the Melodies of Bangladesh</small>
    </h2>

    <!-- Music Category Filter -->
    <div class="d-flex justify-content-center mb-4 animate__animated animate__fadeIn">
      <div class="btn-group btn-group-sm" role="group" id="musicFilter">
        <button type="button" class="btn btn-outline-info filter-btn active" data-filter="all">All</button>
        <button type="button" class="btn btn-outline-info filter-btn" data-filter="folk">Folk</button>
        <button type="button" class="btn btn-outline-info filter-btn" data-filter="modern">Modern</button>
        <button type="button" class="btn btn-outline-info filter-btn" data-filter="classical">Classical</button>
        <button type="button" class="btn btn-outline-info filter-btn" data-filter="pop">Pop</button>
      </div>
    </div>

    <!-- Music Items -->
    <div class="row g-4" id="musicContainer">
      <%
        boolean dataExists22 = false;
        try {
          PreparedStatement stmtMusic = conn.prepareStatement("SELECT * FROM music ORDER BY id DESC LIMIT 3");
          ResultSet rsMusic = stmtMusic.executeQuery();
          int musicCounter = 0;

          while (rsMusic.next()) {
            dataExists = true;
            musicCounter++;
            int id = rsMusic.getInt("id");
            String name = rsMusic.getString("name") != null ? rsMusic.getString("name") : "Unknown Music";
            String description = rsMusic.getString("description") != null ? rsMusic.getString("description") : "No description available.";
            String image = rsMusic.getString("image") != null ? rsMusic.getString("image") : "images/default.jpg";
            String category;
            try {
              category = rsMusic.getString("category") != null ? rsMusic.getString("category").toLowerCase() : "folk";
            } catch (SQLException e) {
              category = "folk"; // Fallback if category column doesn't exist
              out.println("<!-- Warning: Category column missing: " + e.getMessage() + " -->");
            }

            int totalLikes = 0;
            int totalComments = 0;
            try {
              PreparedStatement likeCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM likes WHERE item_type = 'music' AND item_id = ?");
              likeCountStmt.setInt(1, id);
              ResultSet likeCountRs = likeCountStmt.executeQuery();
              if (likeCountRs.next()) {
                totalLikes = likeCountRs.getInt("total");
              }
              likeCountRs.close();
              likeCountStmt.close();

              PreparedStatement commentCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM comment WHERE item_type = 'music' AND item_id = ?");
              commentCountStmt.setInt(1, id);
              ResultSet commentCountRs = commentCountStmt.executeQuery();
              if (commentCountRs.next()) {
                totalComments = commentCountRs.getInt("total");
              }
              commentCountRs.close();
              commentCountStmt.close();
            } catch (SQLException e) {
              out.println("<!-- Error fetching likes/comments: " + e.getMessage() + " -->");
            }

            boolean likedByUser = false;
            if (currentUserId != null) {
              try {
                PreparedStatement userLikeStmt = conn.prepareStatement("SELECT * FROM likes WHERE user_id = ? AND item_id = ? AND item_type = 'music'");
                userLikeStmt.setInt(1, currentUserId);
                userLikeStmt.setInt(2, id);
                ResultSet userLikeRs = userLikeStmt.executeQuery();
                likedByUser = userLikeRs.next();
                userLikeRs.close();
                userLikeStmt.close();
              } catch (SQLException e) {
                out.println("<!-- Error checking user like: " + e.getMessage() + " -->");
              }
            }
      %>
      <div class="col-md-4 mb-4 animate__animated animate__fadeInUp music-item" data-category="<%= category %>" style="animation-delay: <%= musicCounter * 0.1 %>s;">
        <div class="card h-100 border-0 shadow-lg music-card">
          <div class="position-relative">
            <img src="<%= image %>" class="card-img-top" alt="<%= name %>" style="height: 250px; object-fit: cover;" onerror="this.src='images/default.jpg'">
            <div class="position-absolute top-0 end-0 bg-info text-white px-2 py-1 rounded-bl" style="font-size: 0.8rem;">
              <i class="bi bi-award-fill me-1"></i>Popular
            </div>
          </div>
          <div class="card-body d-flex flex-column">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <h5 class="card-title text-info mb-0">
                <i class="bi bi-<%= musicCounter == 1 ? "vinyl-fill" : musicCounter == 2 ? "music-note-beamed" : "music-player-fill" %> text-dark me-2"></i>
                <%= name %>
              </h5>
              <span class="badge bg-info bg-opacity-10 text-info text-capitalize"><%= category %></span>
            </div>
            <p class="card-text mb-3 text-muted" style="font-size: 0.95rem;"><%= description %></p>

            <!-- Rating and Interaction Buttons -->
            <div class="mb-3">
              <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center" data-bs-toggle="tooltip" data-bs-placement="top" title="Based on 100 user reviews">
                  <div class="rating-stars me-2">
                    <i class="bi bi-star-fill text-info"></i>
                    <i class="bi bi-star-fill text-info"></i>
                    <i class="bi bi-star-fill text-info"></i>
                    <i class="bi bi-star-fill text-info"></i>
                    <i class="bi bi-star-half text-info"></i>
                  </div>
                  <small class="text-muted">4.5 (100)</small>
                </div>
                <button class="btn btn-sm btn-outline-primary share-btn" onclick="shareMusic('<%= name %>', '<%= id %>')" data-bs-toggle="tooltip" data-bs-placement="top" title="Share this music">
                  <i class="bi bi-share-fill"></i>
                </button>
              </div>
            </div>

            <!-- Like Button -->
            <form action="like_toggle.jsp" method="post" class="mb-3">
              <input type="hidden" name="item_id" value="<%= id %>">
              <input type="hidden" name="item_type" value="music">
              <button type="submit" class="btn btn-sm <%= likedByUser ? "btn-danger" : "btn-outline-danger" %> position-relative overflow-hidden" data-bs-toggle="tooltip" data-bs-placement="top" title="<%= likedByUser ? "Unlike this music" : "Like this music" %>">
                <i class="bi <%= likedByUser ? "bi-heart-fill" : "bi-heart" %> me-1"></i>Like (<%= totalLikes %>)
                <span class="position-absolute top-0 start-0 w-100 h-100 bg-danger opacity-10" style="border-radius: inherit;"></span>
              </button>
            </form>

            <!-- Comment Section -->
            <% if (currentUserId != null) { %>
              <form action="comment_add.jsp" method="post" class="mb-3">
                <input type="hidden" name="item_id" value="<%= id %>">
                <input type="hidden" name="item_type" value="music">
                <div class="input-group">
                  <textarea name="content" class="form-control" rows="2" placeholder="Share your thoughts..." style="border-radius: 8px 0 0 8px; resize: none;" required></textarea>
                  <button type="submit" class="btn btn-primary" style="border-radius: 0 8px 8px 0;">
                    <i class="bi bi-send-fill"></i>
                  </button>
                </div>
              </form>
            <% } else { %>
              <div class="alert alert-light border mb-3 text-center py-2" style="border-radius: 8px;">
                <i class="bi bi-lock-fill me-1"></i> <a href="login.jsp" class="text-decoration-none">Login</a> to join the conversation
              </div>
            <% } %>

            <!-- Comments Section -->
            <div class="mt-auto">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <h6 class="mb-0 text-muted"><i class="bi bi-chat-square-text-fill me-1"></i> Recent Comments (<%= totalComments %>)</h6>
                <small class="text-muted" data-bs-toggle="tooltip" data-bs-placement="top" title="Total interactions"><i class="bi bi-people-fill me-1"></i><%= totalLikes + totalComments %> interactions</small>
              </div>
              <div class="music-comments-container" style="max-height: 200px; overflow-y: auto;">
                <%
                  try {
                    PreparedStatement cStmt = conn.prepareStatement("SELECT c.*, u.name FROM comment c JOIN user u ON c.user_id = u.id WHERE c.item_type = 'music' AND c.item_id = ? ORDER BY c.timestamp DESC LIMIT 2");
                    cStmt.setInt(1, id);
                    ResultSet cRs = cStmt.executeQuery();
                    while (cRs.next()) {
                      String commentName = cRs.getString("name") != null ? cRs.getString("name") : "Anonymous";
                      String commentContent = cRs.getString("content") != null ? cRs.getString("content") : "";
                      String commentTimestamp = cRs.getString("timestamp") != null ? cRs.getString("timestamp") : "Unknown time";
                %>
                <div class="border rounded p-2 mb-2 bg-light position-relative animate__animated animate__fadeIn" style="border-radius: 10px;">
                  <div class="d-flex align-items-center mb-1">
                    <div class="bg-info rounded-circle me-2" style="width: 30px; height: 30px; display: flex; align-items: center; justify-content: center;">
                      <i class="bi bi-person-fill text-white"></i>
                    </div>
                    <div>
                      <strong class="text-info"><%= commentName %></strong>
                      <small class="text-muted d-block"><i class="bi bi-clock"></i> <%= commentTimestamp %></small>
                    </div>
                  </div>
                  <p class="mb-0 ps-4"><%= commentContent %></p>
                </div>
                <%
                    }
                    cRs.close();
                    cStmt.close();
                  } catch (SQLException e) {
                    out.println("<!-- Error fetching comments: " + e.getMessage() + " -->");
                  }
                %>
              </div>
            </div>
          </div>
          <div class="card-footer bg-transparent border-top-0 text-end">
            <button type="button" class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#musicModal<%= id %>">
              <i class="bi bi-arrow-right-circle me-1"></i>Quick View
            </button>
          </div>
        </div>

        <!-- Modal for Quick View -->
        <div class="modal fade" id="musicModal<%= id %>" tabindex="-1" aria-labelledby="musicModalLabel<%= id %>" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header border-0">
                <h5 class="modal-title text-info" id="musicModalLabel<%= id %>"><i class="bi bi-music-note-beamed me-2"></i><%= name %></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <img src="<%= image %>" class="img-fluid rounded mb-3" alt="<%= name %>" style="max-height: 200px; object-fit: cover;" onerror="this.src='images/default.jpg'">
                <p class="text-muted"><%= description %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="badge bg-info bg-opacity-10 text-info text-capitalize"><%= category %></span>
                  <div>
                    <i class="bi bi-star-fill text-info"></i> 4.5 (100 reviews)
                  </div>
                </div>
              </div>
              <div class="modal-footer border-0">
                <a href="music_details.jsp?id=<%= id %>" class="btn btn-info">View Full Details</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <%
          }
          rsMusic.close();
          stmtMusic.close();
          if (!dataExists) {
      %>
      <div class="col-12 text-center">
        <div class="alert alert-info" role="alert">
          No music items available at the moment. Check back later!
        </div>
      </div>
      <%
          }
        } catch (SQLException e) {
          out.println("<div class='col-12 text-center'><div class='alert alert-danger' role='alert'>Error loading music: " + e.getMessage() + "</div></div>");
        }
      %>
    </div>

    <!-- View All Button -->
    <div class="text-center mt-4 animate__animated animate__fadeIn">
      <a href="music.jsp" class="btn btn-info px-4 py-2" style="border-radius: 30px;">
        <i class="bi bi-arrow-right-circle-fill me-2"></i>Explore All Bangladeshi Music
      </a>
    </ </div>

    <!-- Music Facts Carousel -->
    <div class="row mt-5 animate__animated animate__fadeIn">
      <div class="col-12">
        <div id="musicFactsCarousel" class="carousel slide bg-info bg-opacity-10 p-4 rounded-3" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-info"><i class="bi bi-lightbulb-fill me-2"></i>Did You Know?</h5>
                  <p class="mb-0">Baul music, a mystic folk tradition from Bangladesh, is recognized by UNESCO as an Intangible Cultural Heritage.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/baul-music.jpg" alt="Baul Music" style="height: 80px;" class="img-fluid" onerror="this.src='images/default.jpg'">
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-info"><i class="bi bi-lightbulb-fill me-2"></i>Fun Fact</h5>
                  <p class="mb-0">Rabindra Sangeet, inspired by Rabindranath Tagore, remains a beloved genre in Bangladeshi music culture.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/rabindra-sangeet.jpg" alt="Rabindra Sangeet" style="height: 80px;" class="img-fluid" onerror="this.src='images/default.jpg'">
                </div>
              </div>
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#musicFactsCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#musicFactsCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Additional CSS for Music Section -->
<style>
  .music-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    background: #fff;
    border-radius: 20px;
    overflow: hidden;
  }
  .music-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15) !important;
  }
  .music-card img {
    border-radius: 20px 20px 0 0;
    transition: transform 0.5s ease;
  }
  .music-card:hover img {
    transform: scale(1.05);
  }
  .btn-info, .btn-outline-info {
    transition: all 0.3s ease;
  }
  .btn-info:hover, .btn-outline-info:hover {
    transform: scale(1.05);
  }
  .music-filter-btn.active {
    background-color: #17a2b8 !important;
    color: #fff !important;
    transform: scale(1.05);
  }
  .music-comments-container::-webkit-scrollbar {
    width: 8px;
  }
  .music-comments-container::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
  }
  .music-comments-container::-webkit-scrollbar-thumb {
    background: #17a2b8;
    border-radius: 10px;
  }
</style>

<!-- JavaScript for Filter, Tooltips, and Share -->
<script>
  // Initialize Tooltips for Music
  const musicTooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  const musicTooltipList = [...musicTooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

  // Filter Functionality for Music
  document.querySelectorAll('#musicFilter .filter-btn').forEach(button => {
    button.addEventListener('click', () => {
      document.querySelectorAll('#musicFilter .filter-btn').forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');

      const filter = button.getAttribute('data-filter');
      const musicItems = document.querySelectorAll('.music-item');

      musicItems.forEach(item => {
        if (filter === 'all' || item.getAttribute('data-category') === filter) {
          item.style.display = 'block';
          item.classList.remove('animate__fadeOut');
          item.classList.add('animate__fadeIn');
        } else {
          item.classList.remove('animate__fadeIn');
          item.classList.add('animate__fadeOut');
          setTimeout(() => { item.style.display = 'none'; }, 300);
        }
      });
    });
  });

  // Share Functionality for Music
  function shareMusic(name, id) {
    const shareUrl = window.location.origin + '/music_details.jsp?id=' + id;
    const shareText = 'Check out this amazing Bangladeshi music: ' + name + '!';
    if (navigator.share) {
      navigator.share({
        title: name,
        text: shareText,
        url: shareUrl
      }).catch(err => console.log('Share error:', err));
    } else {
      prompt('Copy this link to share:', shareUrl);
    }
  }
</script>
  
  <!-- Sports Section -->
  <!-- ################################################################# -->
  <!-- Sports Section -->
  <!-- Popular Sports of Bangladesh Section -->
<div class="container-fluid py-5" style="background: linear-gradient(rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0.95)), url('images/sports-pattern.jpg'); background-size: cover; background-attachment: fixed;">
  <div class="container">
    <h2 class="mt-5 mb-4 text-center fw-bold text-danger animate__animated animate__fadeInDown">
      <i class="bi bi-trophy-fill me-2"></i>Popular Sports of Bangladesh
      <small class="d-block text-muted fs-6 mt-2">Experience the Thrill of Bangladeshi Sports</small>
    </h2>

    <!-- Sports Category Filter -->
    <div class="d-flex justify-content-center mb-4 animate__animated animate__fadeIn">
      <div class="btn-group btn-group-sm" role="group" id="sportsFilter">
        <button type="button" class="btn btn-outline-danger filter-btn active" data-filter="all">All</button>
        <button type="button" class="btn btn-outline-danger filter-btn" data-filter="cricket">Cricket</button>
        <button type="button" class="btn btn-outline-danger filter-btn" data-filter="football">Football</button>
        <button type="button" class="btn btn-outline-danger filter-btn" data-filter="kabaddi">Kabaddi</button>
        <button type="button" class="btn btn-outline-danger filter-btn" data-filter="traditional">Traditional</button>
      </div>
    </div>

    <!-- Sports Items -->
    <div class="row g-4" id="sportsContainer">
      <%
        boolean dataExists2 = false;
        try {
          PreparedStatement stmtSport = conn.prepareStatement("SELECT * FROM sport ORDER BY id DESC LIMIT 3");
          ResultSet rsSport = stmtSport.executeQuery();
          int sportCounter = 0;

          while (rsSport.next()) {
            dataExists = true;
            sportCounter++;
            int id = rsSport.getInt("id");
            String name = rsSport.getString("name") != null ? rsSport.getString("name") : "Unknown Sport";
            String description = rsSport.getString("description") != null ? rsSport.getString("description") : "No description available.";
            String image = rsSport.getString("image") != null ? rsSport.getString("image") : "images/default.jpg";
            String category;
            try {
              category = rsSport.getString("category") != null ? rsSport.getString("category").toLowerCase() : "cricket";
            } catch (SQLException e) {
              category = "cricket"; // Fallback if category column doesn't exist
              out.println("<!-- Warning: Category column missing: " + e.getMessage() + " -->");
            }

            int totalLikes = 0;
            int totalComments = 0;
            try {
              PreparedStatement likeCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM likes WHERE item_type = 'sport' AND item_id = ?");
              likeCountStmt.setInt(1, id);
              ResultSet likeCountRs = likeCountStmt.executeQuery();
              if (likeCountRs.next()) {
                totalLikes = likeCountRs.getInt("total");
              }
              likeCountRs.close();
              likeCountStmt.close();

              PreparedStatement commentCountStmt = conn.prepareStatement("SELECT COUNT(*) AS total FROM comment WHERE item_type = 'sport' AND item_id = ?");
              commentCountStmt.setInt(1, id);
              ResultSet commentCountRs = commentCountStmt.executeQuery();
              if (commentCountRs.next()) {
                totalComments = commentCountRs.getInt("total");
              }
              commentCountRs.close();
              commentCountStmt.close();
            } catch (SQLException e) {
              out.println("<!-- Error fetching likes/comments: " + e.getMessage() + " -->");
            }

            boolean likedByUser = false;
            if (currentUserId != null) {
              try {
                PreparedStatement userLikeStmt = conn.prepareStatement("SELECT * FROM likes WHERE user_id = ? AND item_id = ? AND item_type = 'sport'");
                userLikeStmt.setInt(1, currentUserId);
                userLikeStmt.setInt(2, id);
                ResultSet userLikeRs = userLikeStmt.executeQuery();
                likedByUser = userLikeRs.next();
                userLikeRs.close();
                userLikeStmt.close();
              } catch (SQLException e) {
                out.println("<!-- Error checking user like: " + e.getMessage() + " -->");
              }
            }
      %>
      <div class="col-md-4 mb-4 animate__animated animate__fadeInUp sport-item" data-category="<%= category %>" style="animation-delay: <%= sportCounter * 0.1 %>s;">
        <div class="card h-100 border-0 shadow-lg sport-card">
          <div class="position-relative">
            <img src="<%= image %>" class="card-img-top" alt="<%= name %>" style="height: 250px; object-fit: cover;" onerror="this.src='images/default.jpg'">
            <div class="position-absolute top-0 end-0 bg-danger text-white px-2 py-1 rounded-bl" style="font-size: 0.8rem;">
              <i class="bi bi-award-fill me-1"></i>Popular
            </div>
          </div>
          <div class="card-body d-flex flex-column">
            <div class="d-flex justify-content-between align-items-center mb-2">
              <h5 class="card-title text-danger mb-0">
                <i class="bi bi-<%= sportCounter == 1 ? "trophy-fill" : sportCounter == 2 ? "flag-fill" : "activity" %> text-dark me-2"></i>
                <%= name %>
              </h5>
              <span class="badge bg-danger bg-opacity-10 text-danger text-capitalize"><%= category %></span>
            </div>
            <p class="card-text mb-3 text-muted" style="font-size: 0.95rem;"><%= description %></p>

            <!-- Rating and Interaction Buttons -->
            <div class="mb-3">
              <div class="d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center" data-bs-toggle="tooltip" data-bs-placement="top" title="Based on 80 user reviews">
                  <div class="rating-stars me-2">
                    <i class="bi bi-star-fill text-danger"></i>
                    <i class="bi bi-star-fill text-danger"></i>
                    <i class="bi bi-star-fill text-danger"></i>
                    <i class="bi bi-star-fill text-danger"></i>
                    <i class="bi bi-star-half text-danger"></i>
                  </div>
                  <small class="text-muted">4.5 (80)</small>
                </div>
                <button class="btn btn-sm btn-outline-primary share-btn" onclick="shareSport('<%= name %>', '<%= id %>')" data-bs-toggle="tooltip" data-bs-placement="top" title="Share this sport">
                  <i class="bi bi-share-fill"></i>
                </button>
              </div>
            </div>

            <!-- Like Button -->
            <form action="like_toggle.jsp" method="post" class="mb-3">
              <input type="hidden" name="item_id" value="<%= id %>">
              <input type="hidden" name="item_type" value="sport">
              <button type="submit" class="btn btn-sm <%= likedByUser ? "btn-danger" : "btn-outline-danger" %> position-relative overflow-hidden" data-bs-toggle="tooltip" data-bs-placement="top" title="<%= likedByUser ? "Unlike this sport" : "Like this sport" %>">
                <i class="bi <%= likedByUser ? "bi-heart-fill" : "bi-heart" %> me-1"></i>Like (<%= totalLikes %>)
                <span class="position-absolute top-0 start-0 w-100 h-100 bg-danger opacity-10" style="border-radius: inherit;"></span>
              </button>
            </form>

            <!-- Comment Section -->
            <% if (currentUserId != null) { %>
              <form action="comment_add.jsp" method="post" class="mb-3">
                <input type="hidden" name="item_id" value="<%= id %>">
                <input type="hidden" name="item_type" value="sport">
                <div class="input-group">
                  <textarea name="content" class="form-control" rows="2" placeholder="Share your thoughts..." style="border-radius: 8px 0 0 8px; resize: none;" required></textarea>
                  <button type="submit" class="btn btn-primary" style="border-radius: 0 8px 8px 0;">
                    <i class="bi bi-send-fill"></i>
                  </button>
                </div>
              </form>
            <% } else { %>
              <div class="alert alert-light border mb-3 text-center py-2" style="border-radius: 8px;">
                <i class="bi bi-lock-fill me-1"></i> <a href="login.jsp" class="text-decoration-none">Login</a> to join the conversation
              </div>
            <% } %>

            <!-- Comments Section -->
            <div class="mt-auto">
              <div class="d-flex justify-content-between align-items-center mb-2">
                <h6 class="mb-0 text-muted"><i class="bi bi-chat-square-text-fill me-1"></i> Recent Comments (<%= totalComments %>)</h6>
                <small class="text-muted" data-bs-toggle="tooltip" data-bs-placement="top" title="Total interactions"><i class="bi bi-people-fill me-1"></i><%= totalLikes + totalComments %> interactions</small>
              </div>
              <div class="sport-comments-container" style="max-height: 200px; overflow-y: auto;">
                <%
                  try {
                    PreparedStatement cStmt = conn.prepareStatement("SELECT c.*, u.name FROM comment c JOIN user u ON c.user_id = u.id WHERE c.item_type = 'sport' AND c.item_id = ? ORDER BY c.timestamp DESC LIMIT 2");
                    cStmt.setInt(1, id);
                    ResultSet cRs = cStmt.executeQuery();
                    while (cRs.next()) {
                      String commentName = cRs.getString("name") != null ? cRs.getString("name") : "Anonymous";
                      String commentContent = cRs.getString("content") != null ? cRs.getString("content") : "";
                      String commentTimestamp = cRs.getString("timestamp") != null ? cRs.getString("timestamp") : "Unknown time";
                %>
                <div class="border rounded p-2 mb-2 bg-light position-relative animate__animated animate__fadeIn" style="border-radius: 10px;">
                  <div class="d-flex align-items-center mb-1">
                    <div class="bg-danger rounded-circle me-2" style="width: 30px; height: 30px; display: flex; align-items: center; justify-content: center;">
                      <i class="bi bi-person-fill text-white"></i>
                    </div>
                    <div>
                      <strong class="text-danger"><%= commentName %></strong>
                      <small class="text-muted d-block"><i class="bi bi-clock"></i> <%= commentTimestamp %></small>
                    </div>
                  </div>
                  <p class="mb-0 ps-4"><%= commentContent %></p>
                </div>
                <%
                    }
                    cRs.close();
                    cStmt.close();
                  } catch (SQLException e) {
                    out.println("<!-- Error fetching comments: " + e.getMessage() + " -->");
                  }
                %>
              </div>
            </div>
          </div>
          <div class="card-footer bg-transparent border-top-0 text-end">
            <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#sportModal<%= id %>">
              <i class="bi bi-arrow-right-circle me-1"></i>Quick View
            </button>
          </div>
        </div>

        <!-- Modal for Quick View -->
        <div class="modal fade" id="sportModal<%= id %>" tabindex="-1" aria-labelledby="sportModalLabel<%= id %>" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header border-0">
                <h5 class="modal-title text-danger" id="sportModalLabel<%= id %>"><i class="bi bi-trophy-fill me-2"></i><%= name %></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <img src="<%= image %>" class="img-fluid rounded mb-3" alt="<%= name %>" style="max-height: 200px; object-fit: cover;" onerror="this.src='images/default.jpg'">
                <p class="text-muted"><%= description %></p>
                <div class="d-flex justify-content-between align-items-center">
                  <span class="badge bg-danger bg-opacity-10 text-danger text-capitalize"><%= category %></span>
                  <div>
                    <i class="bi bi-star-fill text-danger"></i> 4.5 (80 reviews)
                  </div>
                </div>
              </div>
              <div class="modal-footer border-0">
                <a href="sport_details.jsp?id=<%= id %>" class="btn btn-danger">View Full Details</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <%
          }
          rsSport.close();
          stmtSport.close();
          if (!dataExists) {
      %>
      <div class="col-12 text-center">
        <div class="alert alert-info" role="alert">
          No sports available at the moment. Check back later!
        </div>
      </div>
      <%
          }
        } catch (SQLException e) {
          out.println("<div class='col-12 text-center'><div class='alert alert-danger' role='alert'>Error loading sports: " + e.getMessage() + "</div></div>");
        }
      %>
    </div>

    <!-- View All Button -->
    <div class="text-center mt-4 animate__animated animate__fadeIn">
      <a href="sport.jsp" class="btn btn-danger px-4 py-2" style="border-radius: 30px;">
        <i class="bi bi-arrow-right-circle-fill me-2"></i>Explore All Bangladeshi Sports
      </a>
    </div>

    <!-- Sports Facts Carousel -->
    <div class="row mt-5 animate__animated animate__fadeIn">
      <div class="col-12">
        <div id="sportsFactsCarousel" class="carousel slide bg-danger bg-opacity-10 p-4 rounded-3" data-bs-ride="carousel">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-danger"><i class="bi bi-lightbulb-fill me-2"></i>Did You Know?</h5>
                  <p class="mb-0">Cricket is the most popular sport in Bangladesh, with the national team achieving Test status in 2000.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/cricket.jpg" alt="Cricket" style="height: 80px;" class="img-fluid" onerror="this.src='images/default.jpg'">
                </div>
              </div>
            </div>
            <div class="carousel-item">
              <div class="row align-items-center">
                <div class="col-md-8">
                  <h5 class="text-danger"><i class="bi bi-lightbulb-fill me-2"></i>Fun Fact</h5>
                  <p class="mb-0">Kabaddi, a traditional sport, is considered the national sport of Bangladesh and is played widely in rural areas.</p>
                </div>
                <div class="col-md-4 text-center">
                  <img src="images/kabaddi.jpg" alt="Kabaddi" style="height: 80px;" class="img-fluid" onerror="this.src='images/default.jpg'">
                </div>
              </div>
            </div>
          </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#sportsFactsCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button class="carousel-control-next" type="button" data-bs-target="#sportsFactsCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Additional CSS for Sports Section -->
<style>
  .sport-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    background: #fff;
    border-radius: 20px;
    overflow: hidden;
  }
  .sport-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15) !important;
  }
  .sport-card img {
    border-radius: 20px 20px 0 0;
    transition: transform 0.5s ease;
  }
  .sport-card:hover img {
    transform: scale(1.05);
  }
  .btn-danger, .btn-outline-danger {
    transition: all 0.3s ease;
  }
  .btn-danger:hover, .btn-outline-danger:hover {
    transform: scale(1.05);
  }
  .sport-filter-btn.active {
    background-color: #dc3545 !important;
    color: #fff !important;
    transform: scale(1.05);
  }
  .sport-comments-container::-webkit-scrollbar {
    width: 8px;
  }
  .sport-comments-container::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
  }
  .sport-comments-container::-webkit-scrollbar-thumb {
    background: #dc3545;
    border-radius: 10px;
  }
</style>

<!-- JavaScript for Filter, Tooltips, and Share -->
<script>
  // Initialize Tooltips for Sports
  const sportTooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  const sportTooltipList = [...sportTooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));

  // Filter Functionality for Sports
  document.querySelectorAll('#sportsFilter .filter-btn').forEach(button => {
    button.addEventListener('click', () => {
      document.querySelectorAll('#sportsFilter .filter-btn').forEach(btn => btn.classList.remove('active'));
      button.classList.add('active');

      const filter = button.getAttribute('data-filter');
      const sportItems = document.querySelectorAll('.sport-item');

      sportItems.forEach(item => {
        if (filter === 'all' || item.getAttribute('data-category') === filter) {
          item.style.display = 'block';
          item.classList.remove('animate__fadeOut');
          item.classList.add('animate__fadeIn');
        } else {
          item.classList.remove('animate__fadeIn');
          item.classList.add('animate__fadeOut');
          setTimeout(() => { item.style.display = 'none'; }, 300);
        }
      });
    });
  });

  // Share Functionality for Sports
  function shareSport(name, id) {
    const shareUrl = window.location.origin + '/sport_details.jsp?id=' + id;
    const shareText = 'Check out this exciting Bangladeshi sport: ' + name + '!';
    if (navigator.share) {
      navigator.share({
        title: name,
        text: shareText,
        url: shareUrl
      }).catch(err => console.log('Share error:', err));
    } else {
      prompt('Copy this link to share:', shareUrl);
    }
  }
</script>
  
  
  

  <!-- Admin Section -->
  <div class="mt-5 text-center">
    <a href="admin/manage_food.jsp" class="btn btn-outline-secondary me-2">Manage Food</a>
    <a href="admin/add_food.jsp" class="btn btn-outline-secondary">Add Food</a>
    <a href="admin/add_movie.jsp" class="btn btn-outline-primary">Add Movie</a>
    <a href="admin/add_music.jsp" class="btn btn-outline-success">Add Music</a>
    <a href="admin/add_sport.jsp" class="btn btn-outline-warning">Add Sport</a>
  </div>

  <div class="text-center mt-4">
    <a href="admin/login.jsp" class="btn btn-dark">Admin Login</a>
  </div>
</div>
<jsp:include page="footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>