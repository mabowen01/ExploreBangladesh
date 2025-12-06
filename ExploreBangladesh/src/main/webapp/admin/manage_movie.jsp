<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Movie Management System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <style>
    :root {
      --primary-color: #6c5ce7;
      --secondary-color: #a29bfe;
      --dark-color: #2d3436;
      --light-color: #f5f6fa;
    }
    body {
      background-color: #f8f9fa;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    .navbar-brand {
      font-weight: 700;
      color: var(--primary-color);
    }
    .card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s ease;
    }
    .card:hover {
      transform: translateY(-5px);
    }
    .table-responsive {
      border-radius: 10px;
      overflow: hidden;
    }
    .table thead {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
    }
    .action-btns .btn {
      margin-right: 5px;
    }
    .movie-poster {
      width: 80px;
      height: 120px;
      object-fit: cover;
      border-radius: 5px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    .status-badge {
      font-size: 0.75rem;
      padding: 0.35em 0.65em;
    }
    .search-box {
      max-width: 300px;
    }
    .sidebar {
      min-height: 100vh;
      background: linear-gradient(135deg, #2d3436, #636e72);
      color: white;
    }
    .sidebar .nav-link {
      color: rgba(255,255,255,0.8);
      margin-bottom: 5px;
      border-radius: 5px;
    }
    .sidebar .nav-link:hover, .sidebar .nav-link.active {
      background-color: rgba(255,255,255,0.1);
      color: white;
    }
    .sidebar .nav-link i {
      margin-right: 10px;
    }
    .rating-stars {
      color: #ffc107;
      font-size: 0.9rem;
    }
  </style>
</head>
<body>
  <div class="container-fluid">
    <div class="row">
      <!-- Sidebar -->
      <div class="col-md-3 col-lg-2 d-md-block sidebar collapse bg-dark">
        <div class="position-sticky pt-3">
          <div class="text-center mb-4">
            <h4 class="text-white">Cinema Admin</h4>
            <div class="d-flex justify-content-center mb-3">
              <div class="position-relative">
                <img src="../images/img.jpg" class="rounded-circle border border-white" width="80" height="80" alt="Admin">
                <span class="position-absolute bottom-0 end-0 bg-success rounded-circle p-1 border border-white"></span>
              </div>
            </div>
            <h6 class="text-white mb-1">Admin User</h6>
            <small class="text-muted">Last login: Today</small>
          </div>
          
          <ul class="nav flex-column">
            <li class="nav-item">
              <a class="nav-link" href="dashboard.jsp">
                <i class="bi bi-speedometer2"></i> Dashboard
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="#">
                <i class="bi bi-film"></i> Movie Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="bi bi-people"></i> User Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="bi bi-ticket-perforated"></i> Showtimes
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="bi bi-graph-up"></i> Analytics
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="bi bi-gear"></i> Settings
              </a>
            </li>
          </ul>
        </div>
      </div>

      <!-- Main Content -->
      <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
        <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h1 class="h2">Movie Management</h1>
          <div class="btn-toolbar mb-2 mb-md-0">
            <div class="btn-group me-2">
              <button type="button" class="btn btn-sm btn-outline-secondary">Export</button>
              <button type="button" class="btn btn-sm btn-outline-secondary">Print</button>
            </div>
            <button type="button" class="btn btn-sm btn-outline-primary">
              <i class="bi bi-question-circle"></i> Help
            </button>
          </div>
        </div>

        <!-- Stats Cards -->
        <div class="row mb-4">
          <div class="col-md-3">
            <div class="card bg-primary text-white">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                  <div>
                    <h6 class="card-title">Total Movies</h6>
                    <h2 class="mb-0">328</h2>
                  </div>
                  <i class="bi bi-film fs-1"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card bg-success text-white">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                  <div>
                    <h6 class="card-title">Now Showing</h6>
                    <h2 class="mb-0">42</h2>
                  </div>
                  <i class="bi bi-tv fs-1"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card bg-warning text-dark">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                  <div>
                    <h6 class="card-title">Coming Soon</h6>
                    <h2 class="mb-0">18</h2>
                  </div>
                  <i class="bi bi-calendar2-event fs-1"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card bg-danger text-white">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                  <div>
                    <h6 class="card-title">Archived</h6>
                    <h2 class="mb-0">268</h2>
                  </div>
                  <i class="bi bi-archive fs-1"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Action Bar -->
        <div class="card mb-4">
          <div class="card-body">
            <div class="row">
              <div class="col-md-6">
                <a href="add_movie.jsp" class="btn btn-primary">
                  <i class="bi bi-plus-circle"></i> Add New Movie
                </a>
                <button class="btn btn-outline-secondary ms-2">
                  <i class="bi bi-upload"></i> Bulk Import
                </button>
              </div>
              <div class="col-md-6 text-md-end mt-2 mt-md-0">
                <div class="input-group search-box">
                  <input type="text" class="form-control" placeholder="Search movies...">
                  <button class="btn btn-outline-secondary" type="button">
                    <i class="bi bi-search"></i>
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Filters -->
        <div class="card mb-4">
          <div class="card-body">
            <div class="row g-3">
              <div class="col-md-3">
                <label class="form-label">Genre</label>
                <select class="form-select">
                  <option selected>All Genres</option>
                  <option>Action</option>
                  <option>Comedy</option>
                  <option>Drama</option>
                  <option>Sci-Fi</option>
                  <option>Horror</option>
                </select>
              </div>
              <div class="col-md-3">
                <label class="form-label">Status</label>
                <select class="form-select">
                  <option selected>All Statuses</option>
                  <option>Now Showing</option>
                  <option>Coming Soon</option>
                  <option>Archived</option>
                </select>
              </div>
              <div class="col-md-3">
                <label class="form-label">Release Date</label>
                <select class="form-select">
                  <option selected>Any Time</option>
                  <option>Last 30 Days</option>
                  <option>Last 6 Months</option>
                  <option>Last Year</option>
                </select>
              </div>
              <div class="col-md-3 d-flex align-items-end">
                <button class="btn btn-primary w-100">
                  <i class="bi bi-funnel"></i> Apply Filters
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Main Table -->
        <div class="card">
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-hover align-middle">
                <thead class="table-dark">
                  <tr>
                    <th width="5%">ID</th>
                    <th width="15%">Poster</th>
                    <th width="20%">Title</th>
                    <th width="15%">Director</th>
                    <th width="10%">Year</th>
                    <th width="10%">Rating</th>
                    <th width="10%">Status</th>
                    <th width="15%">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM movie ORDER BY id DESC");
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                      String imgPath = rs.getString("image");
                      if (imgPath == null || imgPath.trim().isEmpty()) {
                        imgPath = "images/default.jpg";
                      }
                  %>
                  <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td>
                      <img src="../<%= imgPath %>" class="movie-poster" onerror="this.src='../images/default.jpg'"/>
                    </td>
                    <td>
                      <strong><%= rs.getString("name") %></strong>
                      <div class="text-muted small">Runtime: 2h 15m</div>
                    </td>
                    <td>Director Name</td>
                    <td>2023</td>
                    <td>
                      <span class="rating-stars">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-half"></i>
                      </span>
                    </td>
                    <td>
                      <span class="badge bg-success status-badge">Now Showing</span>
                    </td>
                    <td class="action-btns">
                      <a href="edit_movie.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                        <i class="bi bi-pencil"></i>
                      </a>
                      <a href="delete_movie.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this movie?')" data-bs-toggle="tooltip" title="Delete">
                        <i class="bi bi-trash"></i>
                      </a>
                      <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="tooltip" title="Preview">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button class="btn btn-sm btn-outline-info" data-bs-toggle="tooltip" title="Showtimes">
                        <i class="bi bi-calendar-event"></i>
                      </button>
                    </td>
                  </tr>
                  <% } %>
                </tbody>
              </table>
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation" class="mt-4">
              <ul class="pagination justify-content-center">
                <li class="page-item disabled">
                  <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                </li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                  <a class="page-link" href="#">Next</a>
                </li>
              </ul>
            </nav>
          </div>
        </div>
      </main>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer mt-auto py-3 bg-light">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <span class="text-muted">© 2023 Cinema Management System</span>
        </div>
        <div class="col-md-6 text-md-end">
          <span class="text-muted">v2.1.0</span>
        </div>
      </div>
    </div>
  </footer>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Enable tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl)
    })
    
    // Sample function for demonstration
    function showNotification() {
      const notification = document.createElement('div')
      notification.className = 'position-fixed bottom-0 end-0 p-3'
      notification.style.zIndex = '11'
      
      const toast = document.createElement('div')
      toast.className = 'toast show'
      toast.role = 'alert'
      toast.setAttribute('aria-live', 'assertive')
      toast.setAttribute('aria-atomic', 'true')
      
      toast.innerHTML = `
        <div class="toast-header bg-primary text-white">
          <strong class="me-auto">System Notification</strong>
          <small>Just now</small>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
          Movie updated successfully!
        </div>
      `
      
      notification.appendChild(toast)
      document.body.appendChild(notification)
      
      setTimeout(() => {
        notification.remove()
      }, 3000)
    }
    
    // Uncomment to show notification on page load (for demo)
    // window.addEventListener('load', showNotification)
  </script>
</body>
</html>