<%@ page import="java.lang.String" %>
<%
  String currentUser = (String) session.getAttribute("userName");
  String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
  <style>
    .navbar {
      background: linear-gradient(to right, #134e5e, #71b280);
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .nav-link {
      transition: color 0.3s ease;
      display: flex;
      align-items: center;
      gap: 0.3rem;
      font-size: 0.9rem;
      padding: 0.3rem 0.5rem;
    }
    .nav-link:hover {
      color: #fefcbf;
    }
    .search-btn {
      transition: background-color 0.3s ease;
      padding: 0.25rem 0.5rem;
    }
    .search-btn:hover {
      background-color: #fefcbf;
    }
    .language-menu {
      min-width: 120px;
    }
    @media (max-width: 768px) {
      .navbar-collapse {
        background: #134e5e;
        padding: 0.5rem;
      }
      .nav-link {
        padding: 0.25rem 0;
      }
    }
  </style>
</head>
<body>
  <nav class="navbar fixed top-0 w-full py-2 z-50">
    <div class="container mx-auto flex items-center justify-between px-3">
      <!-- Compact Brand -->
      <a class="text-white text-lg font-bold flex items-center" href="index.jsp">
        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/1200px-Flag_of_Bangladesh.svg.png" 
             alt="Logo" class="h-5 mr-1">
        <span class="hidden sm:inline">BD Explorer</span>
      </a>

      <!-- Toggler -->
      <button class="md:hidden text-white focus:outline-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16m-7 6h7"></path>
        </svg>
      </button>

      <!-- Desktop Nav -->
      <div class="hidden md:flex items-center space-x-1" id="navbarContent">
        <!-- Links -->
        <div class="flex space-x-1">
          <a class="nav-link text-white hover:text-yellow-300" href="index.jsp" title="Home"><i class="fa-solid fa-home"></i><span class="hidden lg:inline"> Home</span></a>
          <a class="nav-link text-white hover:text-yellow-300" href="scenery.jsp" title="Scenery"><i class="fa-solid fa-tree"></i><span class="hidden lg:inline"> Scenery</span></a>
          <a class="nav-link text-white hover:text-yellow-300" href="food.jsp" title="Cuisine"><i class="fa-solid fa-utensils"></i><span class="hidden lg:inline"> Food</span></a>
          <a class="nav-link text-white hover:text-yellow-300" href="movie.jsp" title="Cinema"><i class="fa-solid fa-film"></i><span class="hidden lg:inline"> Movies</span></a>
          <a class="nav-link text-white hover:text-yellow-300" href="sport.jsp" title="Sports"><i class="fa-solid fa-baseball-bat-ball"></i><span class="hidden lg:inline"> Sports</span></a>
          <a class="nav-link text-white hover:text-yellow-300" href="music.jsp" title="Music"><i class="fa-solid fa-music"></i><span class="hidden lg:inline"> Music</span></a>
        </div>

        <!-- Search -->
        <form action="index.jsp" method="get" class="flex items-center mx-2">
          <input type="search" name="query" placeholder="Search..." class="px-2 py-1 text-sm rounded-l border-none focus:ring-1 focus:ring-yellow-400 text-gray-800 w-32 sm:w-40" />
          <button type="submit" class="search-btn bg-yellow-500 text-white rounded-r"><i class="fa-solid fa-magnifying-glass text-sm"></i></button>
        </form>

        <!-- User/Language -->
        <div class="flex items-center space-x-2 border-l border-gray-300 pl-2">
          <% if (currentUser != null) { %>
            <span class="text-white text-sm flex items-center gap-1" title="<%= currentUser %>"><i class="fa-solid fa-user"></i><span class="hidden lg:inline"><%= currentUser %></span></span>
            <a class="nav-link text-white hover:text-yellow-300" href="auth/logout.jsp" title="Logout"><i class="fa-solid fa-sign-out-alt"></i><span class="hidden lg:inline"> Logout</span></a>
          <% } else { %>
            <a class="nav-link text-white hover:text-yellow-300" href="auth/login.jsp" title="Login"><i class="fa-solid fa-user"></i><span class="hidden lg:inline"> Login</span></a>
            <a class="nav-link text-white hover:text-yellow-300" href="auth/register.jsp" title="Register"><i class="fa-solid fa-user-plus"></i><span class="hidden lg:inline"> Register</span></a>
          <% } %>
          
          <!-- Language Dropdown -->
          <div class="relative group">
            <button class="nav-link text-white hover:text-yellow-300" title="Language">
              <i class="fa-solid fa-globe"></i><span class="hidden lg:inline"> EN</span>
            </button>
            <div class="absolute right-0 mt-1 bg-white rounded shadow-lg py-1 z-50 hidden group-hover:block language-menu">
              <a href="#" class="block px-3 py-1 text-sm text-gray-800 hover:bg-gray-100">বাংলা</a>
              <a href="#" class="block px-3 py-1 text-sm text-gray-800 hover:bg-gray-100">English</a>
              <a href="#" class="block px-3 py-1 text-sm text-gray-800 hover:bg-gray-100">عربي</a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Mobile Menu -->
    <div class="navbar-collapse collapse md:hidden" id="navbarContent">
      <div class="flex flex-col space-y-1 px-2 py-1">
        <a class="nav-link text-white hover:text-yellow-300" href="index.jsp"><i class="fa-solid fa-home"></i> Home</a>
        <a class="nav-link text-white hover:text-yellow-300" href="scenery.jsp"><i class="fa-solid fa-tree"></i> Scenery</a>
        <a class="nav-link text-white hover:text-yellow-300" href="food.jsp"><i class="fa-solid fa-utensils"></i> Food</a>
        <a class="nav-link text-white hover:text-yellow-300" href="movie.jsp"><i class="fa-solid fa-film"></i> Movies</a>
        <a class="nav-link text-white hover:text-yellow-300" href="sport.jsp"><i class="fa-solid fa-baseball-bat-ball"></i> Sports</a>
        <a class="nav-link text-white hover:text-yellow-300" href="music.jsp"><i class="fa-solid fa-music"></i> Music</a>
        
        <form action="index.jsp" method="get" class="flex mt-1">
          <input type="search" name="query" placeholder="Search..." class="px-2 py-1 text-sm rounded-l border-none focus:ring-1 focus:ring-yellow-400 text-gray-800 w-full" />
          <button type="submit" class="search-btn bg-yellow-500 text-white rounded-r"><i class="fa-solid fa-magnifying-glass text-sm"></i></button>
        </form>
        
        <% if (currentUser != null) { %>
          <div class="pt-1 border-t border-gray-600">
            <span class="text-white text-sm flex items-center gap-1"><i class="fa-solid fa-user"></i> <%= currentUser %></span>
            <a class="nav-link text-white hover:text-yellow-300" href="auth/logout.jsp"><i class="fa-solid fa-sign-out-alt"></i> Logout</a>
          </div>
        <% } else { %>
          <div class="pt-1 border-t border-gray-600">
            <a class="nav-link text-white hover:text-yellow-300" href="auth/login.jsp"><i class="fa-solid fa-user"></i> Login</a>
            <a class="nav-link text-white hover:text-yellow-300" href="auth/register.jsp"><i class="fa-solid fa-user-plus"></i> Register</a>
          </div>
        <% } %>
        
        <div class="pt-1 border-t border-gray-600">
          <p class="text-white text-sm mb-1"><i class="fa-solid fa-globe"></i> Language</p>
          <div class="grid grid-cols-3 gap-1">
            <a href="#" class="nav-link text-white hover:text-yellow-300 text-sm">বাংলা</a>
            <a href="#" class="nav-link text-white hover:text-yellow-300 text-sm">English</a>
            <a href="#" class="nav-link text-white hover:text-yellow-300 text-sm">عربي</a>
          </div>
        </div>
      </div>
    </div>
  </nav>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>