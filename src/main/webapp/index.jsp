<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestionhotel.model.Utilisateur" %>
<%@ page import="com.gestionhotel.dao.ChambreDao" %>
<%@ page import="com.gestionhotel.model.Chambre" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Hôtel Évasion — Réservez votre séjour</title>

    <!-- Bootstrap 5 local -->
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Google Font (subtle, classy) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        :root{
            --accent:#0d6efd;
            --muted:#6c757d;
            --bg-soft:#f8f9fb;
            --card-radius:18px;
            --glass: rgba(255,255,255,0.65);
        }
        html,body {font-family: "Inter", system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial; background: linear-gradient(180deg,#ffffff 0%, var(--bg-soft) 100%); color:#212529;}
        .navbar-brand {font-weight:700; letter-spacing: .3px;}
        /* Hero */
        .hero{
            background: linear-gradient(135deg, rgba(13,110,253,0.08) 0%, rgba(13,110,253,0.03) 100%);
            border-radius: 20px;
            padding: 48px;
            box-shadow: 0 10px 30px rgba(13,110,253,0.05);
        }
        .search-card{
            background: var(--glass);
            backdrop-filter: blur(6px);
            border-radius: 14px;
            padding: 18px;
            box-shadow: 0 6px 18px rgba(16,24,40,0.06);
        }
        .room-card { border-radius:12px; overflow:hidden; transition: transform .28s ease, box-shadow .28s ease;}
        .room-card:hover{ transform: translateY(-6px); box-shadow: 0 14px 40px rgba(16,24,40,0.12);}
        .feature-icon{ font-size: 1.6rem; color: var(--accent); }
        .badge-feature{ background: rgba(13,110,253,0.09); color:var(--accent); border-radius:10px; padding:4px 8px; font-weight:600;}
        .cta{
            border-radius:14px;
            padding:14px 20px;
            font-weight:700;
            box-shadow: 0 8px 30px rgba(13,110,253,0.08);
        }
        footer{ font-size:.95rem; color:var(--muted); }
        /* small helpful UI niceties */
        .sr-only-focusable:focus { outline: 3px solid rgba(13,110,253,0.2); outline-offset: 2px; border-radius:6px;}
        .testimonial{ background: white; border-radius:12px; padding:18px; box-shadow: 0 8px 26px rgba(16,24,40,0.06);}
        /* responsive tweaks */
        @media (max-width:767px){
            .hero { padding: 24px; }
        }
    </style>
    </style>
</head>
<body>
<%
    Utilisateur user = (Utilisateur) session.getAttribute("user");
    boolean isClient = user != null && user.getRole() != null && "CLIENT".equalsIgnoreCase(user.getRole());
%>

<!-- NAVBAR -->
<header class="mb-5">
    <nav class="navbar navbar-expand-lg navbar-light bg-transparent container">
        <a class="navbar-brand d-flex align-items-center gap-2" href="<%= request.getContextPath() %>/">
            <span class="fs-4 text-primary"><i class="bi bi-bank2"></i></span>
            <span>Hôtel <strong>Évasion</strong></span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav"
                aria-controls="mainNav" aria-expanded="false" aria-label="Basculer la navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item"><a class="nav-link active" href="<%= request.getContextPath() %>/">Accueil</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/rooms/search">Chambres</a></li>
                <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
                <li class="nav-item"><a class="nav-link" href="#avis">Avis</a></li>
                <% if (isClient) { %>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/reservations/mine">Mes réservations</a></li>
                <% } %>
                <li class="nav-item ms-lg-3">
                    <% if (user == null) { %>
                        <a class="btn btn-outline-primary" href="<%= request.getContextPath() %>/login">Se connecter</a>
                    <% } else { %>
                        <span class="me-2 small text-muted d-none d-lg-inline">Bonjour, <strong><%= user.getNom() != null ? user.getNom() : user.getEmail() %></strong></span>
                        <a class="btn btn-outline-secondary btn-sm" href="<%= request.getContextPath() %>/logout">Se déconnecter</a>
                    <% } %>
                </li>
            </ul>
        </div>
    </nav>
</header>

<!-- HERO + SEARCH -->
<main class="container">
    <section class="hero mb-4">
        <div class="row align-items-center g-4">
            <div class="col-lg-7">
                <h1 class="display-6 fw-bold mb-3">
                    <% if (isClient) { %>
                        Heureux de vous revoir, <%= user.getNom() != null ? user.getNom() : user.getEmail() %>.
                    <% } else { %>
                        Voyagez léger. Réservez malin.
                    <% } %>
                </h1>
                <p class="lead text-muted mb-4">
                    <% if (isClient) { %>
                        Retrouvez vos prochaines réservations ou réservez un nouveau séjour en quelques clics.
                    <% } else { %>
                        Des chambres confortables, des services premium, et une réservation en quelques clics. Offre petit-déjeuner inclus.
                    <% } %>
                </p>

                <!-- Quick benefits (micro-copy for persuasion) -->
                <div class="d-flex gap-3 flex-wrap mb-4">
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge-feature"><i class="bi bi-calendar-check-fill me-1"></i> Annulation flexible</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge-feature"><i class="bi bi-coin me-1"></i> Meilleur prix garanti</span>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="badge-feature"><i class="bi bi-headset me-1"></i> Support 24/7</span>
                    </div>
                </div>

                <!-- CTA -->
                <div class="d-flex gap-3">
                    <a href="<%= request.getContextPath() %>/rooms/search" class="btn btn-primary cta">Chercher une chambre</a>
                    <% if (isClient) { %>
                        <a href="<%= request.getContextPath() %>/reservations/mine" class="btn btn-outline-secondary align-items-center d-flex">Mes réservations</a>
                    <% } else { %>
                        <a href="#rooms" class="btn btn-outline-secondary align-items-center d-flex">Voir nos chambres</a>
                    <% } %>
                </div>
            </div>

            <!-- Search card: simple, accessible, visible (great UX) -->
            <div class="col-lg-5">
                <form class="search-card" role="search" aria-label="Formulaire de recherche d'hébergement" id="searchForm" method="get" action="<%= request.getContextPath() %>/rooms/search">
                    <div class="mb-2 d-flex justify-content-between align-items-center">
                        <strong>Réservez en 30 secondes</strong>
                        <small class="text-muted">Meilleur tarif en direct</small>
                    </div>

                    <div class="row g-2">
                        <div class="col-12 col-md-6">
                            <label class="form-label visually-hidden" for="destination">Destination</label>
                            <input id="destination" name="destination" class="form-control" placeholder="Ville ou hôtel (ex: Ouagadougou)" aria-label="Destination">
                        </div>

                        <div class="col-6 col-md-3">
                            <label class="form-label visually-hidden" for="checkin">Arrivée</label>
                            <input id="checkin" name="dateDebut" type="date" class="form-control" aria-label="Date d'arrivée">
                        </div>

                        <div class="col-6 col-md-3">
                            <label class="form-label visually-hidden" for="checkout">Départ</label>
                            <input id="checkout" name="dateFin" type="date" class="form-control" aria-label="Date de départ">
                        </div>

                        <div class="col-6">
                            <label class="form-label visually-hidden" for="guests">Personnes</label>
                            <select id="guests" name="capacite" class="form-select" aria-label="Nombre de personnes">
                                <option value="1">1 personne</option>
                                <option value="2" selected>2 personnes</option>
                                <option value="3">3 personnes</option>
                                <option value="4">4 personnes</option>
                            </select>
                        </div>

                        <div class="col-6 d-flex align-items-center">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="breakfast" checked>
                                <label class="form-check-label" for="breakfast">Petit-déjeuner</label>
                            </div>
                        </div>

                        <div class="col-12">
                            <button type="submit" class="btn btn-primary w-100" id="reserver">Rechercher</button>
                        </div>
                    </div>
                </form>

                <div class="mt-3 d-flex gap-3">
                    <div class="text-center">
                        <div class="fw-bold">4.8/5</div>
                        <small class="text-muted">Basé sur 2 342 avis</small>
                    </div>
                    <div class="text-center">
                        <div class="fw-bold">Petit-déjeuner</div>
                        <small class="text-muted">Inclus</small>
                    </div>
                    <div class="text-center">
                        <div class="fw-bold">Check-in 14:00</div>
                        <small class="text-muted">Check-out 12:00</small>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ROOMS / OFFERS SECTION -->
    <section id="rooms" class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="h4 mb-0">Nos chambres populaires</h2>
            <a href="<%= request.getContextPath() %>/rooms/search" class="small text-decoration-none">Voir tout <i class="bi bi-chevron-right"></i></a>
        </div>

        <div class="row g-4">
            <%
                ChambreDao chambreDao = new ChambreDao();
                java.util.List<Chambre> chambresAccueil = chambreDao.findAll();
                int maxCards = 3;
                int count = 0;
                if (chambresAccueil != null) {
                    for (Chambre c : chambresAccueil) {
                        if (count >= maxCards) {
                            break;
                        }
                        count++;
                        String photoPath = c.getPhotoPath();
            %>
            <div class="col-md-6 col-lg-4">
                <article class="room-card bg-white h-100">
                    <% if (photoPath != null && photoPath.trim().length() > 0) { %>
                        <img src="<%= request.getContextPath() + photoPath %>" class="img-fluid" alt="Chambre <%= c.getNumero() %>">
                    <% } else { %>
                        <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?q=80&w=1200&auto=format&fit=crop" class="img-fluid" alt="Chambre">
                    <% } %>
                    <div class="p-3">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h3 class="h6 mb-0">Chambre <%= c.getNumero() %></h3>
                            <div class="text-end">
                                <div class="fw-bold">
                                    <%= c.getPrixNuit() != null ? c.getPrixNuit().toPlainString() : "-" %> €
                                </div>
                                <small class="text-muted">/ nuit</small>
                            </div>
                        </div>
                        <p class="text-muted small mb-2">
                            <% if (c.getDescription() != null && c.getDescription().trim().length() > 0) { %>
                                <%= c.getDescription() %>
                            <% } else { %>
                                Chambre <%= c.getType() != null ? c.getType() : "" %> pour <%= c.getCapacite() %> personne(s).
                            <% } %>
                        </p>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex gap-3">
                                <span class="feature-icon" title="Capacité"><i class="bi bi-people"></i></span>
                                <span class="feature-icon" title="Type"><i class="bi bi-door-open"></i></span>
                            </div>
                            <a href="<%= request.getContextPath() %>/room?id=<%= c.getId() %>" class="btn btn-outline-primary btn-sm">Voir détails / Réserver</a>
                        </div>
                    </div>
                </article>
            </div>
            <%
                    }
                }
            %>
        </div>
    </section>

    <!-- SERVICES -->
    <section id="services" class="mb-5">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h2 class="h4">Services & équipements</h2>
                <p class="text-muted">Des équipements pensés pour votre confort et votre productivité — travaillez, détendez-vous, et profitez.</p>
                <ul class="list-unstyled">
                    <li class="d-flex gap-3 mb-2 align-items-start">
                        <i class="bi bi-speedometer2 feature-icon"></i>
                        <div>
                            <strong>Wi-Fi haute vitesse</strong>
                            <div class="text-muted small">Connexion fiable pour télétravail et streaming.</div>
                        </div>
                    </li>
                    <li class="d-flex gap-3 mb-2 align-items-start">
                        <i class="bi bi-water feature-icon"></i>
                        <div>
                            <strong>Piscine & spa</strong>
                            <div class="text-muted small">Moments de détente après une journée active.</div>
                        </div>
                    </li>
                    <li class="d-flex gap-3 mb-2 align-items-start">
                        <i class="bi bi-bag-check feature-icon"></i>
                        <div>
                            <strong>Salle de sport & business center</strong>
                            <div class="text-muted small">Garder la forme et rester productif.</div>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- small promo card -->
            <div class="col-lg-6">
                <div class="p-4 bg-white rounded-4 shadow-sm">
                    <h3 class="h6">Offre spéciale semaine</h3>
                    <p class="text-muted small mb-2">Séjournez 3 nuits, la 4ᵉ offerte.</p>
                    <div class="d-flex gap-3 align-items-center">
                        <a href="#reserver" class="btn btn-primary">Profiter de l'offre</a>
                        <small class="text-muted">Valable jusqu'au 31 Décembre 2025</small>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- TESTIMONIALS -->
    <section id="avis" class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="h4 mb-0">Ce que disent nos clients</h2>
            <small class="text-muted">Expériences réelles</small>
        </div>

        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <div class="testimonial">
                    <div class="d-flex gap-3 align-items-start">
                        <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop&ixlib=rb-4.0.3&s=0a8db6bcf5e0db6b8d1d6b9c6a2f3b4a" alt="Photo client" class="rounded-circle" width="52" height="52">
                        <div>
                            <strong>Amadou</strong>
                            <div class="text-muted small">Séjour en famille</div>
                            <p class="mb-0 mt-2 small text-muted">"Hôtel propre, personnel chaleureux, petit-déjeuner excellent — nous reviendrons!"</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="testimonial">
                    <div class="d-flex gap-3 align-items-start">
                        <img src="https://images.unsplash.com/photo-1545996124-1f2a7a9d5a3e?q=80&w=200&auto=format&fit=crop&ixlib=rb-4.0.3&s=7b5a5c1c9b3eb8ee8a7c4f1df7f9d4a8" alt="Photo client" class="rounded-circle" width="52" height="52">
                        <div>
                            <strong>Fatou</strong>
                            <div class="text-muted small">Voyage d'affaires</div>
                            <p class="mb-0 mt-2 small text-muted">"Calme, internet rapide — parfait pour travailler. Service très pro."</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="testimonial">
                    <div class="d-flex gap-3 align-items-start">
                        <img src="https://images.unsplash.com/photo-1544723795-3fb6469f5b39?q=80&w=200&auto=format&fit=crop&ixlib=rb-4.0.3&s=0c6c1a3f7b9f6c7a5b4d6a7f8c9e0d1b" alt="Photo client" class="rounded-circle" width="52" height="52">
                        <div>
                            <strong>Marie</strong>
                            <div class="text-muted small">Weekend</div>
                            <p class="mb-0 mt-2 small text-muted">"Ambiance cosy et endroit très bien situé. Très bon rapport qualité/prix."</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CALL TO ACTION / NEWSLETTER -->
    <section class="mb-5">
        <div class="rounded-4 p-4 d-flex flex-column flex-md-row align-items-center justify-content-between bg-white shadow-sm">
            <div>
                <h3 class="h6 mb-1">Inscrivez-vous et recevez 10% de réduction</h3>
                <p class="text-muted small mb-0">Offres exclusives, promotions et idées d'escapade.</p>
            </div>
            <form class="d-flex gap-2 mt-3 mt-md-0" onsubmit="event.preventDefault(); alert('Merci — vous êtes inscrit(e) !');">
                <label for="newsletter" class="visually-hidden">Email</label>
                <input id="newsletter" type="email" class="form-control" placeholder="Votre email" required aria-label="Email pour la newsletter">
                <button class="btn btn-primary">S'inscrire</button>
            </form>
        </div>
    </section>

</main>

<!-- FOOTER -->
<footer class="mt-5 pt-5 pb-4">
    <div class="container">
        <div class="row gy-4">
            <div class="col-md-4">
                <a class="d-flex align-items-center gap-2 mb-3 text-dark text-decoration-none" href="#">
                    <i class="bi bi-bank2 fs-4 text-primary"></i>
                    <span class="fw-bold">Hôtel Évasion</span>
                </a>
                <p class="text-muted small">Adresse fictive • Ouagadougou, Burkina Faso<br>Tel: +226 00 00 00 00</p>
            </div>

            <div class="col-md-2">
                <h6>Liens</h6>
                <ul class="list-unstyled small">
                    <li><a href="#rooms" class="text-decoration-none">Chambres</a></li>
                    <li><a href="#services" class="text-decoration-none">Services</a></li>
                    <li><a href="#avis" class="text-decoration-none">Avis</a></li>
                </ul>
            </div>

            <div class="col-md-3">
                <h6>Support</h6>
                <ul class="list-unstyled small">
                    <li><a href="#" class="text-decoration-none">Contact</a></li>
                    <li><a href="#" class="text-decoration-none">FAQ</a></li>
                    <li><a href="#" class="text-decoration-none">Conditions</a></li>
                </ul>
            </div>

            <div class="col-md-3">
                <h6>Suivez-nous</h6>
                <div class="d-flex gap-2">
                    <a class="btn btn-outline-secondary btn-sm" href="#" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
                    <a class="btn btn-outline-secondary btn-sm" href="#" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
                    <a class="btn btn-outline-secondary btn-sm" href="#" aria-label="Twitter"><i class="bi bi-twitter"></i></a>
                </div>
            </div>
        </div>

        <div class="pt-4 mt-4 border-top d-flex justify-content-between small">
            <div>© 2025 Hôtel Évasion. Tous droits réservés.</div>
            <div>Conçu pour une expérience utilisateur fluide.</div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS + tiny custom script -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Basic front-end behavior: quick validation and focus for accessibility
    (function(){
        const form = document.getElementById('searchForm');
        const checkin = document.getElementById('checkin');
        const checkout = document.getElementById('checkout');

        if (form) {
            form.addEventListener('submit', function(){
                // Simple validation without blocking submit
                if (checkin && checkout && checkin.value && checkout.value) {
                    if (new Date(checkout.value) <= new Date(checkin.value)){
                        alert('La date de départ doit être après la date d\'arrivée.');
                        checkout.focus();
                    }
                }
            });
        }

        // Accessible keyboard focus indicators for interactive items
        document.querySelectorAll('a, button, input, select').forEach(function(el){
            el.classList.add('sr-only-focusable');
        });
    })();
</script>
</body>
</html>
