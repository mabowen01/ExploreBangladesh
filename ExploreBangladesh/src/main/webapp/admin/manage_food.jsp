<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Food Management System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <style>
    :root {
      --primary-color: #e67e22;
      --secondary-color: #d35400;
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
    .food-image {
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
            <h4 class="text-white">Food Admin</h4>
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
                <i class="bi bi-egg-fried"></i> Food Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="bi bi-people"></i> User Management
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="bi bi-cart"></i> Orders
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
          <h1 class="h2">Food Management</h1>
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
                    <h6 class="card-title">Total Foods</h6>
                    <h2 class="mb-0">245</h2>
                  </div>
                  <i class="bi bi-egg-fried fs-1"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card bg-success text-white">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                  <div>
                    <h6 class="card-title">Available</h6>
                    <h2 class="mb-0">200</h2>
                  </div>
                  <i class="bi bi-check-circle fs-1"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card bg-warning text-dark">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                  <div>
                    <h6 class="card-title">Out of Stock</h6>
                    <h2 class="mb-0">30</h2>
                  </div>
                  <i class="bi bi-exclamation-triangle fs-1"></i>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="card bg-danger text-white">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                  <div>
                    <h6 class="card-title">Discontinued</h6>
                    <h2 class="mb-0">15</h2>
                  </div>
                  <i class="bi bi-x-circle fs-1"></i>
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
                <a href="add_food.jsp" class="btn btn-primary">
                  <i class="bi bi-plus-circle"></i> Add New Food
                </a>
                <button class="btn btn-outline-secondary ms-2">
                  <i class="bi bi-upload"></i> Bulk Import
                </button>
              </div>
              <div class="col-md-6 text-md-end mt-2 mt-md-0">
                <div class="input-group search-box">
                  <input type="text" class="form-control" placeholder="Search foods...">
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
                <label class="form-label">Category</label>
                <select class="form-select">
                  <option selected>All Categories</option>
                  <option>Main Course</option>
                  <option>Appetizer</option>
                  <option>Dessert</option>
                  <option>Beverage</option>
                </select>
              </div>
              <div class="col-md-3">
                <label class="form-label">Status</label>
                <select class="form-select">
                  <option selected>All Statuses</option>
                  <option>Available</option>
                  <option>Out of Stock</option>
                  <option>Discontinued</option>
                </select>
              </div>
              <div class="col-md-3">
                <label class="form-label">Cuisine</label>
                <select class="form-select">
                  <option selected>All Cuisines</option>
                  <option>Italian</option>
                  <option>Chinese</option>
                  <option>Indian</option>
                  <option>Mexican</option>
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
                    <th width="15%">Image</th>
                    <th width="20%">Name</th>
                    <th width="25%">Description</th>
                    <th width="10%">Category</th>
                    <th width="10%">Status</th>
                    <th width="15%">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM food ORDER BY id DESC");
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
                      <img src="../<%= imgPath %>" class="food-image" onerror="this.src='../images/default.jpg'"/>
                    </td>
                    <td>
                      <strong><%= rs.getString("name") %></strong>
                      <div class="text-muted small">Cuisine: Unknown</div>
                    </td>
                    <td><%= rs.getString("description") %></td>
                    <td>Main Course</td>
                    <td>
                      <span class="badge bg-success status-badge">Available</span>
                    </td>
                    <td class="action-btns">
                      <a href="edit_food.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Edit">
                        <i class="bi bi-pencil"></i>
                      </a>
                      <a href="delete_food.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Are you sure you want to delete this food item?')" data-bs-toggle="tooltip" title="Delete">
                        <i class="bi bi-trash"></i>
                      </a>
                      <button class="btn btn-sm btn-outline-secondary" data-bs-toggle="tooltip" title="Preview">
                        <i class="bi bi-eye"></i>
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
          <span class="text-muted">© 2023 Food Management System</span>
        </div>
        <div class="col-md-6 text-md-end">
          <span class="text-muted">v1.0.0</span>
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

    // Notification function
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
          Food item updated successfully!
        </div>
      `
      
      notification.appendChild(toast)
      document.body.appendChild(notification)
      
      setTimeout(() => {
        notification.remove()
      }, 3000)
    }
  </script>
</body>
</html>