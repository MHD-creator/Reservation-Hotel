<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <title>Confirmation de réservation</title>
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/">Hôtel Évasion</a>
    </div>
</nav>
<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body text-center p-4">
                    <h1 class="h4 mb-3">Votre réservation est bien enregistrée</h1>
                    <p class="text-muted mb-4">Vous recevrez un e-mail de confirmation avec les détails de votre séjour.</p>
                    <a href="<%= request.getContextPath() %>/rooms/search" class="btn btn-primary">Revenir aux chambres</a>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
