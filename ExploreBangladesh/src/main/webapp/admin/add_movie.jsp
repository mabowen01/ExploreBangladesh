<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Add Movie</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #fff1eb, #ace0f9);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    .card {
      border: none;
      border-radius: 20px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    }
    .card-header {
      background: #00264d;
      color: white;
      padding: 1.5rem;
      text-align: center;
      border-radius: 20px 20px 0 0;
    }
    .form-label {
      font-weight: 500;
      color: #00264d;
    }
    .form-control:focus {
      border-color: #00264d;
      box-shadow: 0 0 0 0.2rem rgba(0, 38, 77, 0.25);
    }
    .btn-primary {
      background-color: #00264d;
      border: none;
      border-radius: 10px;
      padding: 10px 20px;
    }
    .btn-primary:hover {
      background-color: #004080;
    }
    .image-preview, .video-preview {
      max-width: 100%;
      border-radius: 10px;
      display: none;
      margin-top: 10px;
    }
    .image-preview {
      height: 200px;
      object-fit: cover;
    }
    .video-preview {
      height: 220px;
    }
    .spinner-border {
      margin-left: 10px;
    }
  </style>
</head>
<body>

<jsp:include page="../header.jsp" />

<div class="container my-5">
  <div class="card">
    <div class="card-header">
      <h3><i class="fas fa-film me-2"></i>Add New Movie</h3>
    </div>
    <div class="card-body p-4">
      <form method="post" action="${pageContext.request.contextPath}/uploadMovie" enctype="multipart/form-data">
        <div class="mb-3">
          <label class="form-label">Movie Name</label>
          <input type="text" name="name" class="form-control" placeholder="Enter movie title" required>
        </div>
        <div class="mb-3">
          <label class="form-label">Description</label>
          <textarea name="description" class="form-control" rows="4" placeholder="Describe the movie" required></textarea>
        </div>
        <div class="mb-3">
          <label class="form-label">Select Poster Image</label>
          <input type="file" name="image" accept="image/*" class="form-control" id="movieImage" required>
          <img id="imagePreview" class="image-preview" alt="Poster Preview" />
        </div>
        <div class="mb-3">
          <label class="form-label">Upload Movie Trailer (optional)</label>
          <input type="file" name="video" accept="video/*" class="form-control" id="movieVideo">
          <video id="videoPreview" class="video-preview" controls></video>
        </div>
        <div class="text-end">
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-upload me-2"></i>Add Movie
            <span class="spinner-border spinner-border-sm d-none" role="status" id="spinner"></span>
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<jsp:include page="../footer.jsp" />

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Image Preview
  document.getElementById('movieImage').addEventListener('change', function (event) {
    const preview = document.getElementById('imagePreview');
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function (e) {
        preview.src = e.target.result;
        preview.style.display = 'block';
      };
      reader.readAsDataURL(file);
    }
  });

  // Video Preview
  document.getElementById('movieVideo').addEventListener('change', function (event) {
    const preview = document.getElementById('videoPreview');
    const file = event.target.files[0];
    if (file) {
      const videoURL = URL.createObjectURL(file);
      preview.src = videoURL;
      preview.style.display = 'block';
    }
  });

  // Loading Spinner on Submit
  document.querySelector('form').addEventListener('submit', function () {
    document.getElementById('spinner').classList.remove('d-none');
  });
</script>

</body>
</html>