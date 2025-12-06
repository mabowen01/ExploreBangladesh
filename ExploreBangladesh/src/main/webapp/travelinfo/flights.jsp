<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@ include file="../header.jsp" %>
<head>
  <title>Flights to Bangladesh</title>
  <style>
    .flights-container {
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
      .flights-container {
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
    <div class="flights-container">
      <!-- Introduction Section -->
      <h2 class="section-title text-center">Flights to Bangladesh</h2>
      <p class="content-text">
        Bangladesh offers excellent air connectivity, making it an accessible destination for travelers worldwide. The country is served by three major international airports: Hazrat Shahjalal International Airport in Dhaka, Shah Amanat International Airport in Chattogram, and Osmani International Airport in Sylhet. These gateways provide seamless access to the rich culture, stunning landscapes, and vibrant markets of Bangladesh.
      </p>

      <!-- Airlines Section -->
      <h3 class="section-title">Major Airlines</h3>
      <p class="content-text">
        A variety of renowned airlines operate regular flights to Bangladesh, ensuring a comfortable travel experience. These include:
        <ul class="list-item">
          <li><strong>Biman Bangladesh Airlines</strong> - The national carrier, offering domestic and international routes.</li>
          <li><strong>Emirates</strong> - Known for luxury and extensive global connectivity.</li>
          <li><strong>Qatar Airways</strong> - Providing world-class service with connections via Doha.</li>
          <li><strong>Singapore Airlines</strong> - Offering premium flights with stops in Singapore.</li>
          <li><strong>Turkish Airlines</strong> - Connecting Bangladesh through Istanbul with competitive fares.</li>
        </ul>
      </p>

      <!-- Booking Information Section -->
      <h3 class="section-title">Booking Your Flight</h3>
      <p class="content-text">
        Plan your journey with ease by booking flights well in advance to secure the best rates and availability. As of today, Tuesday, June 03, 2025, 10:52 AM CEST, flight prices may vary based on demand and season. We recommend checking with airline websites or trusted travel platforms for real-time updates and special offers.
      </p>
      <div class="text-center">
        <a href="book_flights.jsp" class="cta-button">Book Your Flight Now</a>
      </div>

      <!-- Travel Tips Section -->
      <h3 class="section-title">Travel Tips</h3>
      <p class="content-text">
        To ensure a smooth travel experience, consider the following:
        <ul class="list-item">
          <li>Check visa requirements based on your nationality before booking.</li>
          <li>Arrive at the airport at least 2-3 hours prior to international flights.</li>
          <li>Pack light and carry essential travel documents, including passports and itineraries.</li>
          <li>Monitor weather conditions, especially during the monsoon season (June-September).</li>
        </ul>
      </p>
    </div>
  </div>
</body>
</html>