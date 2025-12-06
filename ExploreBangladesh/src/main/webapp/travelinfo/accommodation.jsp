<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../header.jsp" %>
<html>
<head>
  <title>Accommodation in Bangladesh</title>
  <style>
    .accommodation-container {
      background: #ffffff;
      padding: 3rem 2rem;
      border-radius: 0.5rem;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
      margin: 2rem 0;
    }
    .section-title {
      font-size: 1.75rem;
      font-weight: 700;
      color: #1a3c34;
      margin-bottom: 1.5rem;
      border-bottom: 2px solid #d4a017;
      padding-bottom: 0.5rem;
    }
    .content-text {
      font-size: 1rem;
      color: #343a40;
      line-height: 1.8;
      margin-bottom: 1.5rem;
    }
    .list-item {
      margin-left: 1.5rem;
      color: #495057;
    }
    .cta-button {
      background-color: #4a7043;
      color: #ffffff;
      padding: 0.9rem 2rem;
      border-radius: 0.25rem;
      border: none;
      font-weight: 600;
      transition: background-color 0.2s ease, transform 0.2s ease;
      text-decoration: none;
      display: inline-block;
    }
    .cta-button:hover {
      background-color: #d4a017;
      transform: translateY(-2px);
    }
    @media (max-width: 768px) {
      .accommodation-container {
        padding: 1.5rem 1rem;
        margin: 1rem 0;
      }
      .section-title {
        font-size: 1.4rem;
      }
      .content-text {
        font-size: 0.9rem;
      }
      .list-item {
        margin-left: 1rem;
      }
      .cta-button {
        padding: 0.6rem 1.5rem;
        font-size: 0.9rem;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="accommodation-container">
      <!-- Introduction Section -->
      <h2 class="section-title text-center">Accommodation in Bangladesh</h2>
      <p class="content-text">
        Bangladesh offers a diverse range of accommodation options tailored to every traveler’s needs, from luxurious hotels in bustling cities to serene eco-resorts in scenic regions. Whether you seek comfort, affordability, or an authentic cultural experience, the country’s hospitality industry ensures a memorable stay.
      </p>

      <!-- Accommodation Types Section -->
      <h3 class="section-title">Types of Accommodation</h3>
      <p class="content-text">
        Explore a variety of lodging options across Bangladesh, including:
        <ul class="list-item">
          <li><strong>Luxury Hotels</strong> - Found in Dhaka and Chattogram, offering world-class amenities.</li>
          <li><strong>Eco-Resorts</strong> - Located in Sylhet and Cox’s Bazar, blending nature with comfort.</li>
          <li><strong>Budget Hostels</strong> - Affordable stays in major cities and tourist hubs.</li>
          <li><strong>Guesthouses</strong> - Ideal for an authentic local experience with personalized service.</li>
        </ul>
      </p>

      <!-- Regional Highlights Section -->
      <h3 class="section-title">Regional Highlights</h3>
      <p class="content-text">
        Each region offers unique accommodation experiences:
        <ul class="list-item">
          <li><strong>Dhaka</strong> - Stay in modern 5-star hotels like InterContinental or upscale boutique options.</li>
          <li><strong>Cox’s Bazar</strong> - Enjoy beachfront resorts with stunning sea views.</li>
          <li><strong>Sylhet</strong> - Relax in tea garden resorts surrounded by lush greenery.</li>
          <li><strong>Chattogram</strong> - Discover hilltop hotels with panoramic cityscapes.</li>
        </ul>
      </p>

      <!-- Booking Tips Section -->
      <h3 class="section-title">Booking Tips</h3>
      <p class="content-text">
        Plan your stay efficiently with these tips. As of Tuesday, June 03, 2025, 10:55 AM CEST, rates may fluctuate due to seasonal demand. Book early through hotel websites or reputable travel platforms for the best deals, and consider packages that include meals or local tours.
      </p>
      <div class="text-center">
        <a href="book_accommodation.jsp" class="cta-button">Book Your Stay Now</a>
      </div>
    </div>
  </div>
</body>
</html>