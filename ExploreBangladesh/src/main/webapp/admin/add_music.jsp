<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }
    .card {
      border-radius: 15px;
      box-shadow: 0 8px 30px rgba(0,0,0,0.1);
    }
    .card-header {
      background-color: #1a3c34;
      color: white;
      border-radius: 15px 15px 0 0;
      padding: 1.5rem;
    }
    .form-control:focus {
      border-color: #1a3c34;
      box-shadow: 0 0 10px rgba(26, 60, 52, 0.2);
    }
    .btn-primary {
      background: #1a3c34;
      border: none;
      border-radius: 10px;
    }
    .btn-primary:hover {
      background: #2e5a50;
    }
    .image-preview {
      height: 200px;
      border-radius: 10px;
      margin-top: 1rem;
      display: none;
      object-fit: cover;
      width: 100%;
    }
    .rating label {
      font-size: 1.4rem;
      color: #ccc;
      cursor: pointer;
    }
    .rating input:checked ~ label,
    .rating label:hover,
    .rating label:hover ~ label {
      color: gold;
    }
  </style>
</head>
<body>

<jsp:include page="../header.jsp" />
<br><br><br>

<div class="container my-5">
  <div class="card">
    <div class="card-header text-center">
      <h3><i class="fas fa-music me-2"></i>Add New Music</h3>
    </div>
    <div class="card-body p-4">
      <form method="post" action="${pageContext.request.contextPath}/uploadMusic" enctype="multipart/form-data">
        <div class="mb-3">
          <label class="form-label">Music Name</label>
          <input type="text" name="name" class="form-control" placeholder="Enter music title" required>
        </div>

        <div class="mb-3">
          <label class="form-label">Artist Name</label>
          <input type="text" name="artist" class="form-control" placeholder="Enter artist name">
        </div>

        <div class="mb-3">
          <label class="form-label">Genre</label>
          <select name="genre" class="form-select">
            <option>Pop</option>
            <option>Folk</option>
            <option>Rock</option>
            <option>Classical</option>
            <option>Fusion</option>
          </select>
        </div>

        <div class="mb-3">
          <label class="form-label">Release Date</label>
          <input type="date" name="release_date" class="form-control">
        </div>

        <div class="mb-3">
          <label class="form-label">Language</label>
          <select name="language" class="form-select">
            <option>Bangla</option>
            <option>English</option>
            <option>Hindi</option>
            <option>Others</option>
          </select>
        </div>

        <div class="mb-3">
          <label class="form-label">Description</label>
          <textarea name="description" class="form-control" rows="3" placeholder="Describe the music"></textarea>
        </div>

        <div class="mb-3">
          <label class="form-label">Cover Image</label>
          <input type="file" name="image" id="image" accept="image/*" class="form-control">
          <img id="imagePreview" class="image-preview" alt="Preview">
        </div>

        <div class="mb-3">
          <label class="form-label">Music File (MP3)</label>
          <input type="file" name="music_file" accept=".mp3" class="form-control">
        </div>

        <div class="mb-4">
          <label class="form-label">Rating (Demo only)</label><br>
          <div class="rating">
            <input type="radio" id="star5" name="rating" value="5"><label for="star5">&#9733;</label>
            <input type="radio" id="star4" name="rating" value="4"><label for="star4">&#9733;</label>
            <input type="radio" id="star3" name="rating" value="3"><label for="star3">&#9733;</label>
            <input type="radio" id="star2" name="rating" value="2"><label for="star2">&#9733;</label>
            <input type="radio" id="star1" name="rating" value="1"><label for="star1">&#9733;</label>
          </div>
        </div>

        <div class="text-end">
          <button type="submit" class="btn btn-primary">
            <i class="fas fa-upload me-2"></i>Add Music
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

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

<jsp:include page="../footer.jsp" />
</body>
</html>