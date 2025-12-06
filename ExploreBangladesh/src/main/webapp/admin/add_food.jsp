<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <!-- Font Awesome for Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    .navbar-brand {
      font-weight: 600;
      color: #1a3c34 !important;
    }
    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }
    .card-header {
      background: #1a3c34;
      color: white;
      border-radius: 15px 15px 0 0;
      padding: 1.5rem;
    }
    .form-control, .form-control-file {
      border-radius: 10px;
      border: 1px solid #ced4da;
      transition: all 0.3s ease;
    }
    .form-control:focus {
      border-color: #1a3c34;
      box-shadow: 0 0 10px rgba(26, 60, 52, 0.2);
    }
    .btn-primary {
      background: #1a3c34;
      border: none;
      border-radius: 10px;
      padding: 0.75rem 2rem;
      transition: all 0.3s ease;
    }
    .btn-primary:hover {
      background: #2e5a50;
      transform: translateY(-2px);
    }
    .image-preview {
      max-width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 10px;
      margin-top: 1rem;
      display: none;
    }
    .footer {
      background: #1a3c34;
      color: white;
      padding: 2rem 0;
      margin-top: auto;
    }
    .form-label {
      font-weight: 500;
      color: #1a3c34;
    }
    .container {
      max-width: 600px;
    }
  </style>
</head>
<body>

<jsp:include page="../header.jsp" />
<br><br><br><br><br><br>
  <!-- Main Content -->
  <div class="container my-5">
    <div class="card">
      <div class="card-header text-center">
        <h3 class="mb-0"><i class="fas fa-utensils me-2"></i>Add New Food Item</h3>
      </div>
      <div class="card-body p-4">
        <form method="post" action="${pageContext.request.contextPath}/uploadFood" enctype="multipart/form-data">
          <div class="mb-3">
            <label for="foodName" class="form-label">Food Name</label>
            <input type="text" name="name" id="foodName" class="form-control" placeholder="Enter food name" required>
          </div>
          <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea name="description" id="description" class="form-control" rows="4" placeholder="Describe the food item" required></textarea>
          </div>
          <div class="mb-3">
            <label for="image" class="form-label">Select Image</label>
            <input type="file" name="image" id="image" accept="image/*" class="form-control" required>
            <img id="imagePreview" class="image-preview" alt="Image Preview">
          </div>
          <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-primary">
              <i class="fas fa-upload me-2"></i>Submit
              <span class="spinner-border spinner-border-sm ms-2 d-none" id="spinner" role="status" aria-hidden="true"></span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>



  <!-- Bootstrap JS and Popper.js -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <!-- Custom JavaScript for Image Preview and Fake Loading -->
  <script>
    // Image Preview
    document.getElementById('image').addEventListener('change', function(event) {
      const preview = document.getElementById('imagePreview');
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          preview.src = e.target.result;
          preview.style.display = 'block';
        };
        reader.readAsDataURL(file);
      }
    });

    // Fake Loading Spinner on Submit
    document.querySelector('form').addEventListener('submit', function() {
      const submitBtn = document.querySelector('.btn-primary');
      const spinner = document.getElementById('spinner');
      submitBtn.disabled = true;
      spinner.classList.remove('d-none');
      setTimeout(() => {
        submitBtn.disabled = false;
        spinner.classList.add('d-none');
      }, 2000); // Simulate loading for 2 seconds
    });
  </script>
  <jsp:include page="../footer.jsp" />
  
</body>
</html>