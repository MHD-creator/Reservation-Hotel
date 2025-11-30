<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestionhotel.dao.ChambreDao" %>
<%@ page import="com.gestionhotel.model.Chambre" %>
<%@ include file="/WEB-INF/layout/client_header.jspf" %>

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

<!-- HERO + SEARCH -->
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
                        Des chambres confortables, des services premium, et une réservation en quelques clics.
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
                        <!-- <div class="col-12 col-md-6">
                            <label class="form-label visually-hidden" for="destination">Destination</label>
                            <input id="destination" name="destination" class="form-control" placeholder="Ville ou hôtel (ex: Ouagadougou)" aria-label="Destination">
                        </div> -->

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
            <div class="col-lg-8">
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
        </div>
    </section>

    <!-- CALL TO ACTION / NEWSLETTER
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
    </section> -->

<%@ include file="/WEB-INF/layout/client_footer.jspf" %>

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
