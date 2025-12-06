<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    .login-container {
      background: #ffffff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
      max-width: 400px;
      width: 100%;
    }
    .form-switch .form-check-input {
      width: 3em;
      height: 1.5em;
    }
    .admin-mode {
      color: #dc3545;
    }
    .user-mode {
      color: #0d6efd;
    }
  </style>
</head>
<body>

<div class="login-container">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="text-center mb-0 flex-grow-1">
      <i class="bi bi-person-circle user-mode" id="login-icon"></i> 
      <span id="login-title" class="user-mode">User Login</span>
    </h3>
    <div class="form-check form-switch">
      <input class="form-check-input" type="checkbox" role="switch" id="loginModeSwitch">
      <label class="form-check-label" for="loginModeSwitch">Admin</label>
    </div>
  </div>

  <form action="login_process.jsp" method="post" id="loginForm">
    <div class="mb-3">
      <label class="form-label">Email</label>
      <div class="input-group">
        <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
        <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
      </div>
    </div>

    <div class="mb-3">
      <label class="form-label">Password</label>
      <div class="input-group">
        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
        <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
      </div>
    </div>

    <div class="d-grid mb-3">
      <button type="submit" class="btn btn-primary" id="loginButton">
        <i class="bi bi-box-arrow-in-right"></i> Login
      </button>
    </div>
  </form>

  <div class="text-center">
    <p class="mb-1">Don't have an account?</p>
    <a href="register.jsp" class="text-decoration-none text-success fw-bold" id="registerLink">
      <i class="bi bi-person-plus-fill"></i> Create an Account
    </a>
  </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  document.getElementById('loginModeSwitch').addEventListener('change', function() {
    const loginForm = document.getElementById('loginForm');
    const loginTitle = document.getElementById('login-title');
    const loginIcon = document.getElementById('login-icon');
    const loginButton = document.getElementById('loginButton');
    const registerLink = document.getElementById('registerLink');
    
    if(this.checked) {
      // Admin mode
       loginForm.action = "login_process.jsp";
      loginTitle.textContent = "Admin Login";
      loginTitle.classList.remove('user-mode');
      loginTitle.classList.add('admin-mode');
      loginIcon.classList.remove('bi-person-circle', 'user-mode');
      loginIcon.classList.add('bi-shield-lock', 'admin-mode');
      loginButton.classList.remove('btn-primary');
      loginButton.classList.add('btn-danger');
      registerLink.style.display = 'none';
    } else {
      // User mode
      loginForm.action = "login_process.jsp";
      loginTitle.textContent = "User Login";
      loginTitle.classList.remove('admin-mode');
      loginTitle.classList.add('user-mode');
      loginIcon.classList.remove('bi-shield-lock', 'admin-mode');
      loginIcon.classList.add('bi-person-circle', 'user-mode');
      loginButton.classList.remove('btn-danger');
      loginButton.classList.add('btn-primary');
      registerLink.style.display = 'block';
    }
  });
</script>

</body>
</html>