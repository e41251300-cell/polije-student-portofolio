<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laravel</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700;800&family=Satisfy&display=swap" rel="stylesheet">
    <style>
        body { 
            font-family: 'Open Sans', sans-serif; 
            background-color: #f9fbfd; 
            color: #444; 
            margin: 0;
            padding: 0;
        }
        .navbar-brand { 
            font-family: 'Satisfy', cursive; 
            font-size: 2.2rem; 
            color: #4992eb !important; 
            font-weight: bold; 
            text-decoration: none;
        }
        .nav-link { 
            font-size: 0.75rem; 
            font-weight: 700; 
            color: #444444 !important; 
            letter-spacing: 0.5px; 
            transition: color 0.3s ease;
        }
        .nav-link.active, .nav-link:hover { 
            color: #4992eb !important; 
        }
        .hero-title { 
            font-weight: 800; 
            color: #2c3e50; 
            font-size: 2.3rem; 
            line-height: 1.25; 
            letter-spacing: 0.5px; 
        }
        .hero-text { 
            font-size: 0.9rem; 
            color: #7f8c8d; 
            line-height: 1.6; 
        }
        .btn-custom { 
            background-color: #4992eb; 
            color: white !important; 
            border-radius: 4px; 
            padding: 10px 28px; 
            font-size: 0.8rem; 
            font-weight: 700; 
            border: none; 
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s ease, transform 0.1s ease;
            box-shadow: 0 4px 6px rgba(73, 146, 235, 0.2);
        }
        .btn-custom:hover { 
            background-color: #357ae8; 
            transform: translateY(-2px);
        }
        .btn-custom:active {
            transform: translateY(0);
        }
        .dropdown-menu a:hover {
            background-color: #f1f7fe;
            color: #4992eb;
        }
    </style>
</head>
<body>

    <!-- Navbar Navigation -->
    <nav class="navbar navbar-expand-lg bg-white py-3 px-5 shadow-sm sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand ms-4" href="#">Butterfly</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="ms-auto d-flex gap-4 me-4 align-items-center">
                    <a class="nav-link active" href="#">HOME</a>
                    <a class="nav-link" href="#about" onclick="alert('Menu About diklik!')">ABOUT</a>
                    <a class="nav-link" href="#services" onclick="alert('Menu Services diklik!')">SERVICES</a>
                    <a class="nav-link" href="#portfolio" onclick="alert('Menu Portfolio diklik!')">PORTFOLIO</a>
                    <a class="nav-link" href="#team" onclick="alert('Menu Team diklik!')">TEAM</a>
                    
                    <!-- Dropdown Menu -->
                    <div class="dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            DROP DOWN
                        </a>
                        <ul class="dropdown-menu border-0 shadow-sm" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="/api/mahasiswa">API Mahasiswa</a></li>
                            <li><a class="dropdown-item" href="#">Option 2</a></li>
                        </ul>
                    </div>

                    <a class="nav-link" href="#contact" onclick="alert('Menu Contact diklik!')">CONTACT</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="container my-5 py-4">
        <div class="row align-items-center px-4">
            <!-- Left Text Column -->
            <div class="col-md-6 pe-lg-5">
                <h1 class="hero-title mb-3">
                    CREATING WEBSITES THAT<br>MAKE YOU STOP & STARE
                </h1>
                <p class="hero-text mb-4">
                    Accusantium quam, aliquam ultricies eget tempor id, aliquam eget<br>
                    nibh et. Maecen aliquam, risus at semper. Proin iaculis purus<br>
                    consequat sem cure digni ssim. Donec porttitora entum.
                </p>
                <!-- Interactive Button: Redirects to API endpoint -->
                <a href="/api/mahasiswa" class="btn btn-custom">GET STARTED</a>
            </div>

            <!-- Right Column with Original Butterfly Illustration -->
            <div class="col-md-6 text-center mt-4 mt-md-0">
                <img src="https://bootstrapmade.com/demo/templates/Butterfly/assets/img/hero-img.png" 
                     alt="Butterfly Hero Illustration" 
                     class="img-fluid" 
                     style="max-height: 380px;">
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.bundle.min.js"></script>
</body>
</html>