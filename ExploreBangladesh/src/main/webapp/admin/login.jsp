<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Login - Explore Bangladesh</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400&display=swap" rel="stylesheet" />
  <style>
    body {
      background: linear-gradient(135deg, #2c3e50 0%, #4a5568 100%);
      font-family: 'Roboto', sans-serif;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow-x: hidden;
    }
    .login-container {
      max-width: 450px;
      margin: 60px auto;
      padding: 40px;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 15px;
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .login-container:hover {
      transform: translateY(-5px);
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4);
    }
    .header-title {
      font-family: 'Playfair Display', serif;
      color: #2c3e50;
      font-size: 2.5rem;
      font-weight: 700;
      text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
      margin-bottom: 20px;
    }
    .form-label {
      color: #34495e;
      font-weight: 400;
      font-size: 0.95rem;
    }
    .input-group-text {
      background: #f8f9fa;
      border: 1px solid #d1d9e6;
      color: #2c3e50;
    }
    .form-control {
      border-radius: 10px;
      border: 1px solid #d1d9e6;
      font-size: 0.95rem;
      padding: 12px;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }
    .form-control:focus {
      border-color: #2c3e50;
      box-shadow: 0 0 8px rgba(44, 62, 80, 0.3);
      outline: none;
    }
    .btn-primary {
      border-radius: 50px;
      padding: 12px;
      background: linear-gradient(45deg, #2c3e50, #4a5568);
      border: none;
      font-size: 1rem;
      font-weight: 400;
      transition: all 0.3s ease;
    }
    .btn-primary:hover {
      background: linear-gradient(45deg, #4a5568, #718096);
      transform: scale(1.05);
    }
    .text-muted {
      color: #7f8c8d !important;
      font-size: 0.9rem;
    }
    .text-muted a {
      color: #2c3e50;
      font-weight: 500;
      text-decoration: none;
    }
    .text-muted a:hover {
      text-decoration: underline;
      color: #4a5568;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .login-container {
      animation: fadeIn 0.8s ease-out;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="login-container">
    <h3 class="text-center header-title">
      <i class="fas fa-shield-alt me-2"></i> Admin Login
    </h3>

    <form action="check_login.jsp" method="post">
      <div class="mb-3">
        <label class="form-label">Email</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-envelope"></i></span>
          <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
        </div>
      </div>

      <div class="mb-3">
        <label class="form-label">Password</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fas fa-lock"></i></span>
          <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
        </div>
      </div>

      <div class="d-grid">
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-sign-in-alt me-1"></i> Login
        </button>
      </div>
    </form>

    <div class="text-center mt-3">
      <p class="mb-0 text-muted">Not an admin? <a href="../auth/login.jsp">User Login</a></p>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>