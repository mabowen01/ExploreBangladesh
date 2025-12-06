<%@ page session="true" %>
<%
    String adminEmail = (String) session.getAttribute("userEmail");
    if (adminEmail == null || !adminEmail.equals("admin@bd.com")) {
        response.sendRedirect("../auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Explore Bangladesh</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #3b82f6;
            --secondary: #1e293b;
            --accent: #22d3ee;
            --text: #e2e8f0;
            --bg: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
        }
        [data-theme="light"] {
            --primary: #2563eb;
            --secondary: #f1f5f9;
            --accent: #06b6ff;
            --text: #1f2937;
            --bg: #ffffff;
            --card-bg: rgba(241, 245, 249, 0.7);
            --glass-bg: rgba(0, 0, 0, 0.1);
            --glass-border: rgba(0, 0, 0, 0.2);
        }
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, var(--bg), var(--secondary));
            color: var(--text);
            min-height: 100vh;
            overflow-x: hidden;
            transition: background 0.3s ease, color 0.3s ease;
        }
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 280px;
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            padding-top: 80px;
            box-shadow: 2px 0 15px rgba(0, 0, 0, 0.4);
            transition: transform 0.3s ease;
            z-index: 1000;
        }
        .sidebar-hidden {
            transform: translateX(-280px);
        }
        .sidebar .nav-link {
            color: var(--text);
            font-size: 0.95rem;
            padding: 12px 20px;
            border-radius: 8px;
            margin: 5px 15px;
            transition: background 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
        }
        .sidebar .nav-link:hover {
            background: var(--glass-bg);
            box-shadow: 0 0 10px var(--accent);
            color: var(--accent);
        }
        .sidebar .nav-link.active {
            background: var(--primary);
            color: #ffffff;
            box-shadow: 0 0 15px rgba(59, 130, 246, 0.5);
        }
        .sidebar .nav-link i {
            margin-right: 12px;
        }
        .sidebar .dropdown-toggle::after {
            float: right;
            margin-top: 8px;
        }
        .header {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            padding: 15px 25px;
            position: fixed;
            top: 0;
            left: 280px;
            right: 0;
            z-index: 900;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            transition: left 0.3s ease;
        }
        .header .user-info {
            position: relative;
        }
        .header .dropdown-menu {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            color: var(--text);
        }
        .header .dropdown-item {
            color: var(--text);
            transition: background 0.3s ease;
        }
        .header .dropdown-item:hover {
            background: var(--glass-bg);
            color: var(--accent);
        }
        .toggle-btn, .theme-toggle {
            background: none;
            border: none;
            color: var(--text);
            font-size: 1.4rem;
            cursor: pointer;
            transition: color 0.3s ease;
        }
        .toggle-btn:hover, .theme-toggle:hover {
            color: var(--accent);
        }
        .main-content {
            margin-left: 280px;
            padding: 100px 30px 30px;
            transition: margin-left 0.3s ease;
        }
        .main-content.full-width {
            margin-left: 0;
        }
        .dashboard-title {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text);
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
            margin-bottom: 30px;
        }
        .card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
        }
        .card-title {
            color: var(--text);
            font-size: 1.3rem;
            font-weight: 500;
        }
        .card-text {
            color: #94a3b8;
            font-size: 0.9rem;
        }
        .counter {
            font-size: 2rem;
            font-weight: 700;
            color: var(--accent);
        }
        .notification-bell {
            position: relative;
            background: none;
            border: none;
            color: var(--text);
            font-size: 1.4rem;
            cursor: pointer;
        }
        .notification-bell .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            font-size: 0.7rem;
        }
        .notification-dropdown {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            width: 300px;
            right: 0;
        }
        .notification-item {
            color: var(--text);
            padding: 10px 15px;
            border-bottom: 1px solid var(--glass-border);
        }
        .notification-item:hover {
            background: var(--glass-bg);
            color: var(--accent);
        }
        .modal-content {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            color: var(--text);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
        }
        .modal-header, .modal-footer {
            border: none;
        }
        .modal-title {
            color: var(--text);
        }
        .btn-logout {
            background: linear-gradient(45deg, #ef4444, #dc2626);
            border: none;
            border-radius: 50px;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        .btn-logout:hover {
            background: linear-gradient(45deg, #dc2626, #b91c1c);
            transform: scale(1.05);
        }
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-280px);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
            .header {
                left: 0;
            }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .card {
            animation: fadeIn 0.8s ease-out;
            animation-delay: calc(0.1s * var(--card-index));
        }
        .loading-spinner {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: 4px solid var(--glass-bg);
            border-top: 4px solid var(--accent);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body data-theme="dark">
    <!-- Sidebar -->
    <nav class="sidebar">
        <div class="sidebar-header text-center mb-4">
            <h4 class="text-white">Admin Panel</h4>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#foodMenu" aria-expanded="false">
                    <i class="fas fa-utensils"></i> Food
                </a>
                <div class="collapse" id="foodMenu">
                    <a class="nav-link ps-5" href="add_food.jsp">Add Food</a>
                    <a class="nav-link ps-5" href="manage_food.jsp">Manage Food</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#musicMenu" aria-expanded="false">
                    <i class="fas fa-music"></i> Music
                </a>
                <div class="collapse" id="musicMenu">
                    <a class="nav-link ps-5" href="add_music.jsp">Add Music</a>
                    <a class="nav-link ps-5" href="manage_music.jsp">Manage Music</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#movieMenu" aria-expanded="false">
                    <i class="fas fa-film"></i> Movies
                </a>
                <div class="collapse" id="movieMenu">
                    <a class="nav-link ps-5" href="add_movie.jsp">Add Movie</a>
                    <a class="nav-link ps-5" href="manage_movie.jsp">Manage Movies</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#sportMenu" aria-expanded="false">
                    <i class="fas fa-trophy"></i> Sports
                </a>
                <div class="collapse" id="sportMenu">
                    <a class="nav-link ps-5" href="add_sport.jsp">Add Sport</a>
                    <a class="nav-link ps-5" href="manage_sport.jsp">Manage Sports</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link dropdown-toggle" data-bs-toggle="collapse" href="#sceneryMenu" aria-expanded="false">
                    <i class="fas fa-mountain"></i> Attractions
                </a>
                <div class="collapse" id="sceneryMenu">
                    <a class="nav-link ps-5" href="add_scenery.jsp">Add Attraction</a>
                    <a class="nav-link ps-5" href="manage_scenery.jsp">Manage Attractions</a>
                </div>
            </li>
        </ul>
    </nav>

    <!-- Header -->
    <header class="header">
        <div class="d-flex align-items-center">
            <button class="toggle-btn me-3" id="toggleSidebar">
                <i class="fas fa-bars"></i>
            </button>
            <button class="theme-toggle me-3" id="themeToggle">
                <i class="fas fa-moon"></i>
            </button>
            <button class="notification-bell" data-bs-toggle="dropdown">
                <i class="fas fa-bell"></i>
                <span class="badge bg-danger rounded-pill">3</span>
            </button>
            <ul class="dropdown-menu notification-dropdown">
                <li class="notification-item">New user registered</li>
                <li class="notification-item">Content pending review</li>
                <li class="notification-item">System update available</li>
            </ul>
        </div>
        <div class="user-info">
            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-user-circle me-2"></i> <%= adminEmail %>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i> Settings</a></li>
                <li><a class="dropdown-item text-danger" href="#" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
            </ul>
        </div>
    </header>

    <!-- Main Content -->
    <div class="main-content">
        <h3 class="dashboard-title">Admin Dashboard</h3>
        <div class="row">
            <div class="col-md-4 mb-4" style="--card-index: 1;">
                <div class="card p-4">
                    <h5 class="card-title"><i class="fas fa-users me-2"></i> Total Users</h5>
                    <p class="counter" data-target="1500">0</p>
                    <p class="card-text">Active users on the platform.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4" style="--card-index: 2;">
                <div class="card p-4">
                    <h5 class="card-title"><i class="fas fa-file-alt me-2"></i> Total Content</h5>
                    <p class="counter" data-target="500">0</p>
                    <p class="card-text">Published items across all categories.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4" style="--card-index: 3;">
                <div class="card p-4">
                    <h5 class="card-title"><i class="fas fa-comment-dots me-2"></i> Recent Comments</h5>
                    <p class="counter" data-target="200">0</p>
                    <p class="card-text">User comments awaiting review.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Logout Modal -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="logoutModalLabel">Confirm Logout</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to logout?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a href="../auth/logout.jsp" class="btn btn-logout">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Loading Spinner -->
    <div class="loading-spinner" id="loadingSpinner"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sidebar toggle
        const toggleBtn = document.getElementById('toggleSidebar');
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');
        const header = document.querySelector('.header');
        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('sidebar-hidden');
            sidebar.classList.toggle('active');
            mainContent.classList.toggle('full-width');
            header.style.left = sidebar.classList.contains('sidebar-hidden') ? '0' : '280px';
        });

        // Theme toggle
        const themeToggle = document.getElementById('themeToggle');
        const body = document.body;
        themeToggle.addEventListener('click', () => {
            const currentTheme = body.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            body.setAttribute('data-theme', newTheme);
            const iconClass = newTheme === 'dark' ? 'fa-moon' : 'fa-sun';
            themeToggle.innerHTML = '<i class="fas ' + iconClass + '"></i>';
        });

        // Animated counters
        document.querySelectorAll('.counter').forEach(counter => {
            const target = +counter.getAttribute('data-target');
            let count = 0;
            const increment = target / 100;
            const updateCount = () => {
                if (count < target) {
                    count += increment;
                    counter.innerText = Math.ceil(count);
                    setTimeout(updateCount, 20);
                } else {
                    counter.innerText = target;
                }
            };
            updateCount();
        });

        // Highlight active nav link
        const currentPath = window.location.pathname.split('/').pop();
        document.querySelectorAll('.nav-link').forEach(link => {
            if (link.getAttribute('href') === currentPath) {
                link.classList.add('active');
                link.closest('.collapse')?.classList.add('show');
                link.closest('.nav-item')?.querySelector('.dropdown-toggle')?.classList.add('active');
            }
        });

        // Show loading spinner during navigation
        document.querySelectorAll('a[href]').forEach(link => {
            link.addEventListener('click', (e) => {
                if (!link.href.includes('#') && !link.dataset.bsToggle) {
                    document.getElementById('loadingSpinner').style.display = 'block';
                }
            });
        });
    </script>
</body>
</html>