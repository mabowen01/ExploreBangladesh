<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Add Sport</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #f1f8e9, #e3f2fd);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    .container {
      max-width: 650px;
    }
    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
    }
    .card-header {
      background: #1b5e20;
      color: white;
      border-radius: 15px 15px 0 0;
      padding: 1.5rem;
      text-align: center;
    }
    .form-label {
      color: #1b5e20;
      font-weight: 500;
    }
    .btn-primary {
      background-color: #1b5e20;
      border: none;
      border-radius: 10px;
      padding: 0.6rem 1.5rem;
    }
    .btn-primary:hover {
      background-color: #2e7d32;
    }
    .image-preview {
      max-width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 10px;
      margin-top: 10px;
      display: none;
    }
  </style>
</head>
<body>

<jsp:include page="../header.jsp" />

<div class="container my-5">
  <div class="card">
    <div class="card-header">
      <h3><i class="fas fa-futbol me-2"></i>Add New Sport</h3>
    </div>
    <div class="card-body p-4">
      <form method="post" action="${pageContext.request.contextPath}/uploadSport" enctype="multipart/form-data">
        <div class="mb-3">
          <label for="sportName" class="form-label">Sport Name</label>
          <input type="text" name="name" id="sportName" class="form-control" placeholder="Enter sport name" required>
        </div>
        <div class="mb-3">
          <label for="description" class="form-label">Description</label>
          <textarea name="description" id="description" class="form-control" rows="4" placeholder="Describe the sport" required></textarea>
        </div>
        <div class="mb-3">
          <label for="image" class="form-label">Select Image</label>
          <input type="file" name="image" id="image" accept="image/*" class="form-control" required>
          <img id="imagePreview" class="image-preview" alt="Image Preview">
        </div>
        <div class="text-end">
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-plus-circle me-2"></i>Add Sport
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<jsp:include page="../footer.jsp" />

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
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
</script>

</body>
</html>