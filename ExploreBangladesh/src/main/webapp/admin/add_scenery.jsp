<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Tourist Attraction</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- FontAwesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #e0f7fa, #fffde7);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    .container {
      max-width: 600px;
    }
    .card {
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }
    .card-header {
      background: #004d40;
      color: white;
      border-radius: 15px 15px 0 0;
      text-align: center;
      padding: 1.5rem;
    }
    .form-label {
      font-weight: 500;
      color: #004d40;
    }
    .btn-primary {
      background-color: #004d40;
      border: none;
      border-radius: 10px;
      transition: 0.3s ease;
    }
    .btn-primary:hover {
      background-color: #00695c;
    }
    .image-preview {
      max-width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 10px;
      display: none;
      margin-top: 10px;
    }
  </style>
</head>
<body>

<jsp:include page="../header.jsp" />

<div class="container my-5">
  <div class="card">
    <div class="card-header">
      <h3><i class="fas fa-map-marker-alt me-2"></i>Add Tourist Attraction</h3>
    </div>
    <div class="card-body p-4">
      <form method="post" action="${pageContext.request.contextPath}/uploadScenery" enctype="multipart/form-data">
        <div class="mb-3">
          <label class="form-label">Attraction Name</label>
          <input type="text" name="name" class="form-control" placeholder="Enter attraction name" required>
        </div>
        <div class="mb-3">
          <label class="form-label">Description</label>
          <textarea name="description" class="form-control" rows="4" placeholder="Describe the place" required></textarea>
        </div>
        <div class="mb-3">
          <label class="form-label">Select Image</label>
          <input type="file" name="image" accept="image/*" class="form-control" id="imageInput" required>
          <img id="imagePreview" class="image-preview" alt="Preview" />
        </div>
        <div class="text-end">
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-plus-circle me-2"></i>Add Attraction
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
  // Show image preview
  document.getElementById('imageInput').addEventListener('change', function(event) {
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