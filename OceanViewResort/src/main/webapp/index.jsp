<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort | Galle, Sri Lanka - Luxury Beachside Accommodation</title>
    <link rel="stylesheet" href="assets/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* ===== HERO SECTION ===== */
        .hero {
            position: relative;
            height: 100vh;
            width: 100%;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: white;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(rgba(0, 50, 100, 0.5), rgba(0, 100, 150, 0.5)), 
                        url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1920 1080"><defs><linearGradient id="grad1" x1="0%25" y1="0%25" x2="100%25" y2="100%25"><stop offset="0%25" style="stop-color:rgb(0,150,200);stop-opacity:1" /><stop offset="100%25" style="stop-color:rgb(0,80,120);stop-opacity:1" /></linearGradient></defs><rect width="1920" height="1080" fill="url(%23grad1)"/><path d="M0,540 Q480,480 960,540 T1920,540 L1920,1080 L0,1080 Z" fill="rgba(255,255,255,0.1)"/><path d="M0,600 Q480,550 960,600 T1920,600 L1920,1080 L0,1080 Z" fill="rgba(255,255,255,0.05)"/></svg>') center/cover;
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            animation: slideInBackground 20s ease-in-out infinite;
            z-index: 0;
        }

        @keyframes slideInBackground {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .hero-content {
            position: relative;
            z-index: 5;
            animation: fadeInUp 1s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero h1 {
            font-size: clamp(2.5rem, 8vw, 5rem);
            font-weight: 800;
            letter-spacing: 3px;
            margin-bottom: 15px;
            text-shadow: 2px 2px 20px rgba(0, 0, 0, 0.4);
            background: linear-gradient(135deg, #ffffff 0%, #e0f0ff 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero .subtitle {
            font-size: 1.5rem;
            font-weight: 300;
            margin-bottom: 40px;
            text-shadow: 1px 1px 10px rgba(0, 0, 0, 0.3);
            letter-spacing: 1px;
            opacity: 0.95;
        }

        .hero-buttons {
            display: flex;
            gap: 25px;
            justify-content: center;
            flex-wrap: wrap;
            animation: fadeInUp 1.2s ease-out;
        }

        .hero-buttons .btn {
            padding: 16px 40px;
            font-size: 1.1rem;
            font-weight: 600;
            border: 2px solid white;
            border-radius: 50px;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .btn-explore {
            background: linear-gradient(135deg, #ff6b35 0%, #ff8c5a 100%);
            color: white;
            border-color: transparent;
        }

        .btn-explore:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(255, 107, 53, 0.4);
            background: linear-gradient(135deg, #ff8c5a 0%, #ffb380 100%);
        }

        .btn-staff {
            background: transparent;
            color: white;
        }

        .btn-staff:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: white;
            transform: translateY(-3px);
        }

        /* ===== NAVBAR ===== */
        .navbar {
            position: absolute;
            top: 0;
            width: 100%;
            padding: 25px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 100;
            background: linear-gradient(180deg, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0) 100%);
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 900;
            letter-spacing: 3px;
            color: white;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        }

        .navbar-brand i {
            color: #ff6b35;
            margin-right: 10px;
        }

        /* ===== ACCOMMODATIONS SECTION ===== */
        #rooms {
            padding: 100px 50px;
            background: linear-gradient(135deg, #f0f4f8 0%, #e2e8f0 100%);
            position: relative;
        }

        #rooms h2 {
            font-size: clamp(2rem, 5vw, 3rem);
            color: #003366;
            margin-bottom: 20px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        .section-subtitle {
            font-size: 1.1rem;
            color: #667eaa;
            margin-bottom: 50px;
            font-weight: 300;
            letter-spacing: 0.5px;
        }

        .accommodation-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(330px, 1fr));
            gap: 35px;
            margin-top: 40px;
        }

        .room-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            transition: all 0.4s cubic-bezier(0.23, 1, 0.320, 1);
            transform: translateY(0);
        }

        .room-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 20px 50px rgba(0, 102, 204, 0.25);
        }

        .room-image-wrapper {
            position: relative;
            height: 280px;
            overflow: hidden;
            background: linear-gradient(135deg, #667eaa 0%, #764ba2 100%);
        }

        .room-image-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .room-card:hover .room-image-wrapper img {
            transform: scale(1.08);
        }

        .room-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(135deg, #ff6b35 0%, #ff8c5a 100%);
            color: white;
            padding: 8px 18px;
            border-radius: 30px;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
        }

        .room-content {
            padding: 30px;
        }

        .room-content h3 {
            font-size: 1.5rem;
            color: #003366;
            margin-bottom: 12px;
            font-weight: 700;
        }

        .room-content p {
            color: #667eaa;
            margin-bottom: 20px;
            font-size: 1rem;
            line-height: 1.6;
        }

        .room-features {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .feature-tag {
            background: #f0f4f8;
            color: #003366;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .room-price {
            font-size: 1.8rem;
            color: #ff6b35;
            font-weight: 800;
            margin-bottom: 20px;
        }

        .btn-book {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #0066cc 0%, #003399 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 102, 204, 0.3);
            background: linear-gradient(135deg, #003399 0%, #001f66 100%);
        }

        /* ===== ABOUT SECTION ===== */
        #about {
            padding: 100px 50px;
            background: white;
            text-align: center;
        }

        #about h2 {
            font-size: clamp(2rem, 5vw, 3rem);
            color: #003366;
            margin-bottom: 20px;
            font-weight: 800;
        }

        #about p {
            font-size: 1.2rem;
            color: #667eaa;
            margin-bottom: 40px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }

        .about-card {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .about-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        /* ===== AMENITIES SECTION ===== */
        #amenities {
            padding: 100px 50px;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        }

        #amenities h2 {
            font-size: clamp(2rem, 5vw, 3rem);
            color: #003366;
            margin-bottom: 20px;
            font-weight: 800;
        }

        #amenities p {
            font-size: 1.1rem;
            color: #667eaa;
            margin-bottom: 40px;
        }

        .amenity-item {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.3s ease;
        }

        .amenity-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        /* ===== LOCATION SECTION ===== */
        #location {
            padding: 100px 50px;
            background: white;
        }

        #location h2 {
            font-size: clamp(2rem, 5vw, 3rem);
            color: #003366;
            margin-bottom: 20px;
            font-weight: 800;
        }

        #location p {
            color: #667eaa;
            margin-bottom: 30px;
            line-height: 1.6;
            font-size: 1.1rem;
        }

        /* ===== FOOTER ===== */
        footer {
            background: linear-gradient(135deg, #003366 0%, #001f4d 100%);
            color: white;
            padding: 60px 50px 30px;
        }

        footer h3 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            font-weight: 800;
        }

        footer p {
            color: #b8c5d6;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        footer a {
            color: #b8c5d6;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        footer a:hover {
            color: white;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .navbar {
                padding: 15px 20px;
            }
            
            #rooms {
                padding: 60px 20px;
            }

            .hero-buttons {
                gap: 15px;
            }

            .accommodation-grid {
                grid-template-columns: 1fr;
                gap: 25px;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero .subtitle {
                font-size: 1.1rem;
            }

            #about h2, #amenities h2, #location h2 {
                font-size: 2rem;
            }

            #about p, #amenities p, #location p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

    <!-- ===== NAVIGATION ===== -->
    <nav class="navbar">
        <div class="navbar-brand">
            <i class="fas fa-water"></i>OCEAN VIEW
        </div>
        <div>
            <a href="staff/stafflogin.jsp" class="btn btn-staff">
                <i class="fas fa-lock"></i> Staff Portal
            </a>
        </div>
    </nav>

    <!-- ===== HERO SECTION ===== -->
    <div class="hero">
        <div class="hero-content">
            <h1>Experience Paradise</h1>
            <p class="subtitle">Galle's Premier Luxury Beachside Resort</p>
            <div class="hero-buttons">
                <a href="#rooms" class="btn btn-explore">
                    <i class="fas fa-door-open"></i> Explore Suites
                </a>
                <a href="staff/stafflogin.jsp" class="btn btn-staff">
                    <i class="fas fa-sign-in-alt"></i> Staff Login
                </a>
            </div>
        </div>
    </div>

    <!-- ===== ACCOMMODATIONS SECTION ===== -->
    <section id="rooms">
        <div style="text-align: center;">
            <h2>Our Luxurious Accommodations</h2>
            <p class="section-subtitle">Choose from our carefully curated collection of premium room types</p>
        </div>

        <div class="accommodation-grid">
            <!-- Standard Room -->
            <div class="room-card">
                <div class="room-image-wrapper">
                    <img src="https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=600&h=400&fit=crop&auto=format" alt="Standard Room">
                    <span class="room-badge">Most Popular</span>
                </div>
                <div class="room-content">
                    <h3>Standard Room</h3>
                    <p>A comfortable room with essential amenities.</p>
                    <div class="room-features">
                        <span class="feature-tag"><i class="fas fa-ruler-combined"></i> 35m²</span>
                        <span class="feature-tag"><i class="fas fa-tv"></i> Smart TV</span>
                        <span class="feature-tag"><i class="fas fa-wifi"></i> Free WiFi</span>
                    </div>
                    <div class="room-price">LKR 12,000<span style="font-size: 0.5em;">/night</span></div>
                    <button class="btn-book">Book Now</button>
                </div>
            </div>

            <!-- Deluxe Ocean View -->
            <div class="room-card">
                <div class="room-image-wrapper">
                    <img src="https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=600&h=400&fit=crop&auto=format" alt="Deluxe Ocean View">
                    <span class="room-badge">Premium</span>
                </div>
                <div class="room-content">
                    <h3>Deluxe Ocean View</h3>
                    <p>A premium room with a stunning view of the ocean.</p>
                    <div class="room-features">
                        <span class="feature-tag"><i class="fas fa-ruler-combined"></i> 50m²</span>
                        <span class="feature-tag"><i class="fas fa-binoculars"></i> Ocean View</span>
                        <span class="feature-tag"><i class="fas fa-hot-tub"></i> Jacuzzi</span>
                    </div>
                    <div class="room-price">LKR 20,000<span style="font-size: 0.5em;">/night</span></div>
                    <button class="btn-book">Book Now</button>
                </div>
            </div>

            <!-- Presidential Suite -->
            <div class="room-card">
                <div class="room-image-wrapper">
                    <img src="https://images.unsplash.com/photo-1584132967334-10e028bd69f7?w=600&h=400&fit=crop&auto=format" alt="Presidential Suite">
                    <span class="room-badge">Luxury</span>
                </div>
                <div class="room-content">
                    <h3>Presidential Suite</h3>
                    <p>The ultimate luxury experience.</p>
                    <div class="room-features">
                        <span class="feature-tag"><i class="fas fa-ruler-combined"></i> 120m²</span>
                        <span class="feature-tag"><i class="fas fa-crown"></i> Luxury</span>
                        <span class="feature-tag"><i class="fas fa-concierge-bell"></i> Concierge</span>
                    </div>
                    <div class="room-price">LKR 50,000<span style="font-size: 0.5em;">/night</span></div>
                    <button class="btn-book">Book Now</button>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== ABOUT SECTION ===== -->
    <section id="about" style="padding: 100px 50px; background: white; text-align: center;">
        <div style="max-width: 1200px; margin: 0 auto;">
            <h2 style="font-size: clamp(2rem, 5vw, 3rem); color: #003366; margin-bottom: 20px; font-weight: 800;">About Ocean View Resort</h2>
            <p style="font-size: 1.2rem; color: #667eaa; margin-bottom: 40px; max-width: 800px; margin-left: auto; margin-right: auto; line-height: 1.6;">
                Nestled along the pristine coastline of Galle, Sri Lanka, Ocean View Resort offers an unparalleled luxury experience where modern elegance meets tropical paradise.
            </p>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 40px; margin-top: 60px;">
                <div class="about-card">
                    <div style="font-size: 3rem; color: #ff6b35; margin-bottom: 20px;"><i class="fas fa-umbrella-beach"></i></div>
                    <h3 style="color: #003366; margin-bottom: 15px; font-size: 1.3rem;">Private Beach Access</h3>
                    <p style="color: #667eaa; line-height: 1.6;">Direct access to our exclusive stretch of golden sand beach with crystal-clear waters perfect for swimming and water sports.</p>
                </div>
                <div class="about-card">
                    <div style="font-size: 3rem; color: #ff6b35; margin-bottom: 20px;"><i class="fas fa-spa"></i></div>
                    <h3 style="color: #003366; margin-bottom: 15px; font-size: 1.3rem;">World-Class Spa</h3>
                    <p style="color: #667eaa; line-height: 1.6;">Indulge in rejuvenating treatments using traditional Sri Lankan therapies combined with modern wellness techniques.</p>
                </div>
                <div class="about-card">
                    <div style="font-size: 3rem; color: #ff6b35; margin-bottom: 20px;"><i class="fas fa-utensils"></i></div>
                    <h3 style="color: #003366; margin-bottom: 15px; font-size: 1.3rem;">Fine Dining</h3>
                    <p style="color: #667eaa; line-height: 1.6;">Experience culinary excellence with our multiple restaurants offering international cuisine and authentic Sri Lankan flavors.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== AMENITIES SECTION ===== -->
    <section id="amenities" style="padding: 100px 50px; background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);">
        <div style="text-align: center; margin-bottom: 60px;">
            <h2 style="font-size: clamp(2rem, 5vw, 3rem); color: #003366; margin-bottom: 20px; font-weight: 800;">Resort Amenities</h2>
            <p style="font-size: 1.1rem; color: #667eaa;">Everything you need for an unforgettable stay</p>
        </div>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 30px; max-width: 1200px; margin: 0 auto;">
            <div class="amenity-item" style="text-align: center; padding: 30px; background: white; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); transition: transform 0.3s ease;">
                <i class="fas fa-swimming-pool" style="font-size: 2.5rem; color: #0066cc; margin-bottom: 15px;"></i>
                <h4 style="color: #003366; margin-bottom: 10px;">Infinity Pool</h4>
                <p style="color: #667eaa; font-size: 0.9rem;">Overlooking the Indian Ocean</p>
            </div>
            <div class="amenity-item" style="text-align: center; padding: 30px; background: white; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); transition: transform 0.3s ease;">
                <i class="fas fa-dumbbell" style="font-size: 2.5rem; color: #0066cc; margin-bottom: 15px;"></i>
                <h4 style="color: #003366; margin-bottom: 10px;">Fitness Center</h4>
                <p style="color: #667eaa; font-size: 0.9rem;">24/7 equipped gym facility</p>
            </div>
            <div class="amenity-item" style="text-align: center; padding: 30px; background: white; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); transition: transform 0.3s ease;">
                <i class="fas fa-wifi" style="font-size: 2.5rem; color: #0066cc; margin-bottom: 15px;"></i>
                <h4 style="color: #003366; margin-bottom: 10px;">High-Speed WiFi</h4>
                <p style="color: #667eaa; font-size: 0.9rem;">Complimentary throughout resort</p>
            </div>
            <div class="amenity-item" style="text-align: center; padding: 30px; background: white; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); transition: transform 0.3s ease;">
                <i class="fas fa-concierge-bell" style="font-size: 2.5rem; color: #0066cc; margin-bottom: 15px;"></i>
                <h4 style="color: #003366; margin-bottom: 10px;">24/7 Concierge</h4>
                <p style="color: #667eaa; font-size: 0.9rem;">Personalized service anytime</p>
            </div>
            <div class="amenity-item" style="text-align: center; padding: 30px; background: white; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); transition: transform 0.3s ease;">
                <i class="fas fa-car" style="font-size: 2.5rem; color: #0066cc; margin-bottom: 15px;"></i>
                <h4 style="color: #003366; margin-bottom: 10px;">Airport Transfer</h4>
                <p style="color: #667eaa; font-size: 0.9rem;">Complimentary pickup service</p>
            </div>
            <div class="amenity-item" style="text-align: center; padding: 30px; background: white; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); transition: transform 0.3s ease;">
                <i class="fas fa-child" style="font-size: 2.5rem; color: #0066cc; margin-bottom: 15px;"></i>
                <h4 style="color: #003366; margin-bottom: 10px;">Kids Club</h4>
                <p style="color: #667eaa; font-size: 0.9rem;">Activities for young guests</p>
            </div>
        </div>
    </section>

    <!-- ===== LOCATION SECTION ===== -->
    <section id="location" style="padding: 100px 50px; background: white;">
        <div style="max-width: 1200px; margin: 0 auto; display: grid; grid-template-columns: 1fr 1fr; gap: 60px; align-items: center;">
            <div>
                <h2 style="font-size: clamp(2rem, 5vw, 3rem); color: #003366; margin-bottom: 20px; font-weight: 800;">Prime Location</h2>
                <p style="color: #667eaa; margin-bottom: 30px; line-height: 1.6; font-size: 1.1rem;">
                    Located in the heart of Galle's UNESCO World Heritage Site, our resort offers the perfect blend of historic charm and modern luxury.
                </p>
                <div style="display: flex; flex-direction: column; gap: 15px;">
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <i class="fas fa-map-marker-alt" style="color: #ff6b35; font-size: 1.2rem;"></i>
                        <span style="color: #003366;">Galle Fort, Sri Lanka</span>
                    </div>
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <i class="fas fa-plane" style="color: #ff6b35; font-size: 1.2rem;"></i>
                        <span style="color: #003366;">15 minutes from Bandaranaike International Airport</span>
                    </div>
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <i class="fas fa-clock" style="color: #ff6b35; font-size: 1.2rem;"></i>
                        <span style="color: #003366;">Check-in: 2:00 PM | Check-out: 11:00 AM</span>
                    </div>
                </div>
            </div>
            <div style="background: linear-gradient(135deg, #667eaa 0%, #764ba2 100%); border-radius: 15px; height: 400px; display: flex; align-items: center; justify-content: center; color: white; text-align: center;">
                <div>
                    <i class="fas fa-map-marked-alt" style="font-size: 4rem; margin-bottom: 20px; opacity: 0.8;"></i>
                    <h3 style="font-size: 1.5rem; margin-bottom: 10px;">Interactive Map</h3>
                    <p style="opacity: 0.9;">View our location and nearby attractions</p>
                    <button style="margin-top: 20px; padding: 12px 25px; background: #ff6b35; border: none; border-radius: 25px; color: white; font-weight: 600; cursor: pointer;">View Map</button>
                </div>
            </div>
        </div>
    </section>

    <!-- ===== FOOTER ===== -->
    <footer style="background: linear-gradient(135deg, #003366 0%, #001f4d 100%); color: white; padding: 60px 50px 30px;">
        <div style="max-width: 1200px; margin: 0 auto;">
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 40px; margin-bottom: 40px;">
                <div>
                    <h3 style="font-size: 1.5rem; margin-bottom: 20px; font-weight: 800;"><i class="fas fa-water" style="color: #ff6b35; margin-right: 10px;"></i>Ocean View Resort</h3>
                    <p style="color: #b8c5d6; line-height: 1.6; margin-bottom: 20px;">
                        Experience luxury redefined at Sri Lanka's premier beachside resort. Where paradise meets perfection.
                    </p>
                    <div style="display: flex; gap: 15px;">
                        <a href="#" style="color: #b8c5d6; font-size: 1.5rem; transition: color 0.3s ease;"><i class="fab fa-facebook"></i></a>
                        <a href="#" style="color: #b8c5d6; font-size: 1.5rem; transition: color 0.3s ease;"><i class="fab fa-instagram"></i></a>
                        <a href="#" style="color: #b8c5d6; font-size: 1.5rem; transition: color 0.3s ease;"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="color: #b8c5d6; font-size: 1.5rem; transition: color 0.3s ease;"><i class="fab fa-tripadvisor"></i></a>
                    </div>
                </div>
                <div>
                    <h4 style="margin-bottom: 20px; font-weight: 700;">Quick Links</h4>
                    <ul style="list-style: none; padding: 0;">
                        <li style="margin-bottom: 10px;"><a href="#rooms" style="color: #b8c5d6; text-decoration: none; transition: color 0.3s ease;">Our Rooms</a></li>
                        <li style="margin-bottom: 10px;"><a href="#about" style="color: #b8c5d6; text-decoration: none; transition: color 0.3s ease;">About Us</a></li>
                        <li style="margin-bottom: 10px;"><a href="#amenities" style="color: #b8c5d6; text-decoration: none; transition: color 0.3s ease;">Amenities</a></li>
                        <li style="margin-bottom: 10px;"><a href="#location" style="color: #b8c5d6; text-decoration: none; transition: color 0.3s ease;">Location</a></li>
                        <li style="margin-bottom: 10px;"><a href="staff/stafflogin.jsp" style="color: #b8c5d6; text-decoration: none; transition: color 0.3s ease;">Staff Portal</a></li>
                    </ul>
                </div>
                <div>
                    <h4 style="margin-bottom: 20px; font-weight: 700;">Contact Info</h4>
                    <div style="display: flex; flex-direction: column; gap: 15px;">
                        <div style="display: flex; align-items: center; gap: 15px;">
                            <i class="fas fa-phone" style="color: #ff6b35; width: 20px;"></i>
                            <span style="color: #b8c5d6;">+94 11 123 4567</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 15px;">
                            <i class="fas fa-envelope" style="color: #ff6b35; width: 20px;"></i>
                            <span style="color: #b8c5d6;">reservations@oceanview.lk</span>
                        </div>
                        <div style="display: flex; align-items: center; gap: 15px;">
                            <i class="fas fa-map-marker-alt" style="color: #ff6b35; width: 20px;"></i>
                            <span style="color: #b8c5d6;">Galle Fort, Sri Lanka</span>
                        </div>
                    </div>
                </div>
                <div>
                    <h4 style="margin-bottom: 20px; font-weight: 700;">Newsletter</h4>
                    <p style="color: #b8c5d6; margin-bottom: 15px; font-size: 0.9rem;">Stay updated with our latest offers and events.</p>
                    <div style="display: flex; gap: 10px;">
                        <input type="email" placeholder="Your email" style="flex: 1; padding: 10px; border: none; border-radius: 5px; background: rgba(255,255,255,0.1); color: white; placeholder-color: #b8c5d6;">
                        <button style="padding: 10px 15px; background: #ff6b35; border: none; border-radius: 5px; color: white; cursor: pointer;">Subscribe</button>
                    </div>
                </div>
            </div>
            <div style="border-top: 1px solid rgba(255,255,255,0.1); padding-top: 30px; text-align: center;">
                <p style="color: #b8c5d6; margin: 0; font-size: 0.9rem;">
                    &copy; 2026 Ocean View Resort. All rights reserved. | Designed with <i class="fas fa-heart" style="color: #ff6b35;"></i> for luxury experiences
                </p>
            </div>
        </div>
    </footer>
</body>
</html>