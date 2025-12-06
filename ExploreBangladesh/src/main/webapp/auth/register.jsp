<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../header.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Registration</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    .register-container {
      max-width: 500px;
      margin: 50px auto;
      background: #ffffff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body>

<div class="container">
  <div class="register-container">
    <h3 class="text-center text-success mb-4">
      <i class="bi bi-person-plus-fill"></i> User Registration
    </h3>

    <form action="register_process.jsp" method="post">
      <div class="mb-3">
        <label class="form-label">Full Name</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
          <input type="text" class="form-control" name="name" placeholder="Enter your name" required>
        </div>
      </div>

      <div class="mb-3">
        <label class="form-label">Email Address</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
          <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
        </div>
      </div>

      <div class="mb-3">
        <label class="form-label">Password</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
          <input type="password" class="form-control" name="password" placeholder="Create a password" required>
        </div>
      </div>

      <div class="d-grid mb-3">
        <button type="submit" class="btn btn-success">
          <i class="bi bi-check-circle"></i> Register
        </button>
      </div>
    </form>

    <div class="text-center">
      <p class="mb-1">Already have an account?</p>
      <a href="login.jsp" class="text-decoration-none text-primary fw-bold">
        <i class="bi bi-box-arrow-in-right"></i> Login Here
      </a>
    </div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="../footer.jsp" />
</body>
</html>