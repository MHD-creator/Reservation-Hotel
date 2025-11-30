<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Connexion / Inscription — Exemple Bootstrap</title>
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg,#f8fafc 0%, #eef2f7 100%); }
        .auth-card { max-width: 900px; border-radius: 14px; box-shadow: 0 8px 30px rgba(16,24,40,0.08); }
        .brand { font-weight:700; letter-spacing: .4px; }
        .or-divider { position: relative; text-align: center; }
        .or-divider::before { content: ""; position: absolute; left: 0; top: 50%; width: 100%; height: 1px; background: #e9eef5; z-index: 0; }
        .or-divider span { background: white; padding: 0 .75rem; position: relative; z-index: 1; color: #6b7280; }
    </style>
</head>
<body>
<main class="d-flex align-items-center justify-content-center vh-100">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-10 col-lg-9">
                <div class="row g-0 auth-card overflow-hidden bg-white">
                    <!-- Left: Illustration / Branding -->
                    <div class="col-md-5 d-none d-md-flex flex-column justify-content-center align-items-start p-4 bg-light">
                        <h2 class="brand mb-2">MonApp</h2>
                        <p class="text-muted">Gère facilement ton compte. Connexion rapide ou crée un nouveau profil en quelques secondes.</p>
                        <ul class="list-unstyled small text-muted mt-3">
                            <li>✔ Réactif sur mobile et desktop</li>
                            <li>✔ Validation côté client</li>
                            <li>✔ Bonnes pratiques d'UX</li>
                        </ul>
                        <img src="https://cdn.jsdelivr.net/gh/stevenvo/illustrations@main/undraw_secure_login_pdn4.svg" alt="illustration" style="width:85%; margin-top:1rem; opacity:.95">
                    </div>

                    <!-- Right: Forms -->
                    <div class="col-12 col-md-7 p-4">
                        <ul class="nav nav-pills mb-3" id="auth-tab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="login-tab" data-bs-toggle="pill" data-bs-target="#login" type="button" role="tab" aria-controls="login" aria-selected="true">Connexion</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="signup-tab" data-bs-toggle="pill" data-bs-target="#signup" type="button" role="tab" aria-controls="signup" aria-selected="false">Inscription</button>
                            </li>
                        </ul>

                        <div class="tab-content" id="auth-tabContent">
                            <!-- Login -->
                            <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
                                <h4>Bienvenue</h4>
                                <p class="text-muted">Connecte-toi pour continuer sur ton tableau de bord.</p>

                                <form id="loginForm" method="post" action="<%= request.getContextPath() %>/login" novalidate>
                                    <div class="mb-3">
                                        <label for="loginEmail" class="form-label">Adresse e-mail</label>
                                        <input type="email" class="form-control" id="loginEmail" name="email" placeholder="nom@exemple.com" required>
                                        <div class="invalid-feedback">Merci de saisir une adresse e‑mail valide.</div>
                                    </div>

                                    <div class="mb-3 position-relative">
                                        <label for="loginPassword" class="form-label">Mot de passe</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="loginPassword" name="password" placeholder="••••••••" required>
                                            <button class="btn btn-outline-secondary" type="button" id="toggleLoginPwd" title="Afficher/masquer le mot de passe">👁️</button>
                                            <div class="invalid-feedback">Le mot de passe est requis.</div>
                                        </div>
                                    </div>
                                    <% if ("1".equals(request.getParameter("error"))) { %>
                                        <div class="alert alert-danger py-2">Identifiants incorrects.</div>
                                    <% } %>

                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="remember">
                                            <label class="form-check-label small" for="remember">Se souvenir</label>
                                        </div>
                                        <a href="#" class="small">Mot de passe oublié ?</a>
                                    </div>

                                    <div class="d-grid mb-2">
                                        <button type="submit" class="btn btn-primary">Se connecter</button>
                                    </div>

                                    <div class="or-divider text-center my-3"><span>ou</span></div>

                                    <div class="d-grid gap-2">
                                        <button type="button" class="btn btn-outline-secondary">Continuer avec Google</button>
                                        <button type="button" class="btn btn-outline-secondary">Continuer avec GitHub</button>
                                    </div>

                                </form>
                            </div>

                            <!-- Signup -->
                            <div class="tab-pane fade" id="signup" role="tabpanel" aria-labelledby="signup-tab">
                                <h4>Crée ton compte</h4>
                                <p class="text-muted">Inscris-toi — c'est rapide et simple.</p>

                                <form id="signupForm" novalidate>
                                    <div class="row g-2">
                                        <div class="col-md-6 mb-3">
                                            <label for="firstName" class="form-label">Prénom</label>
                                            <input type="text" class="form-control" id="firstName" required>
                                            <div class="invalid-feedback">Le prénom est requis.</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="lastName" class="form-label">Nom</label>
                                            <input type="text" class="form-control" id="lastName" required>
                                            <div class="invalid-feedback">Le nom est requis.</div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="signupEmail" class="form-label">Adresse e-mail</label>
                                        <input type="email" class="form-control" id="signupEmail" placeholder="nom@exemple.com" required>
                                        <div class="invalid-feedback">Merci de saisir une adresse e‑mail valide.</div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Téléphone (optionnel)</label>
                                        <input type="tel" class="form-control" id="phone" placeholder="+226 70 00 00 00">
                                    </div>

                                    <div class="row g-2">
                                        <div class="col-md-6 mb-3">
                                            <label for="signupPassword" class="form-label">Mot de passe</label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="signupPassword" required minlength="6" placeholder="Au moins 6 caractères">
                                                <button class="btn btn-outline-secondary" type="button" id="toggleSignupPwd">👁️</button>
                                                <div class="invalid-feedback">Le mot de passe doit contenir au moins 6 caractères.</div>
                                            </div>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="confirmPassword" class="form-label">Confirmer le mot de passe</label>
                                            <input type="password" class="form-control" id="confirmPassword" required placeholder="Retapez le mot de passe">
                                            <div class="invalid-feedback">Les mots de passe doivent correspondre.</div>
                                        </div>
                                    </div>

                                    <div class="form-check mb-3">
                                        <input class="form-check-input" type="checkbox" id="terms" required>
                                        <label class="form-check-label small" for="terms">J'accepte les <a href="#">conditions d'utilisation</a>.</label>
                                        <div class="invalid-feedback">Vous devez accepter les conditions pour continuer.</div>
                                    </div>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-success">S'inscrire</button>
                                    </div>

                                </form>
                            </div>

                        </div>

                        <p class="text-center small text-muted mt-3">© <span id="year"></span> MonApp — Tous droits réservés</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Bootstrap JS + petites fonctions JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Year
    document.getElementById('year').textContent = new Date().getFullYear();

    // Toggle password visibility
    document.getElementById('toggleLoginPwd').addEventListener('click', function(){
        const p = document.getElementById('loginPassword');
        p.type = p.type === 'password' ? 'text' : 'password';
    });
    document.getElementById('toggleSignupPwd').addEventListener('click', function(){
        const p = document.getElementById('signupPassword');
        p.type = p.type === 'password' ? 'text' : 'password';
    });

    // Simple validation and password match check
    (function () {
        'use strict'
        // Fetch forms
        const loginForm = document.getElementById('loginForm');
        const signupForm = document.getElementById('signupForm');

        loginForm.addEventListener('submit', function (e) {
            if (!loginForm.checkValidity()) {
                e.preventDefault(); e.stopPropagation();
            }
            loginForm.classList.add('was-validated');
        });

        signupForm.addEventListener('submit', function (e) {
            const pwd = document.getElementById('signupPassword');
            const conf = document.getElementById('confirmPassword');
            let valid = signupForm.checkValidity();

            if (pwd.value !== conf.value) {
                valid = false;
                conf.classList.add('is-invalid');
                conf.nextElementSibling && (conf.nextElementSibling.textContent = 'Les mots de passe ne correspondent pas.');
            } else {
                conf.classList.remove('is-invalid');
            }

            if (!valid) {
                e.preventDefault(); e.stopPropagation();
            }
            signupForm.classList.add('was-validated');
        });
    })();
</script>
</body>
</html>
