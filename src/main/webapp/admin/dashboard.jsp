<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <title>Tableau de bord - Restaurant</title>
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg,#f8fafc 0%, #eef2f7 100%); }
        .card-nav { border-radius: 14px; box-shadow: 0 10px 30px rgba(15,23,42,0.08); }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">Hôtel Évasion - Admin</a>
    </div>
</nav>

<main class="container py-4">
    <div class="mb-4">
        <h1 class="h3 mb-1">Tableau de bord restaurant</h1>
        <p class="text-muted mb-0">Gérez vos chambres, vos réservations et vos clients.</p>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card card-nav h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Chambres</h5>
                    <p class="card-text text-muted flex-grow-1">Ajoutez, modifiez ou supprimez les chambres de l'hôtel.</p>
                    <a href="<%= request.getContextPath() %>/admin/chambres" class="btn btn-primary mt-2">Gérer les chambres</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-nav h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Réservations</h5>
                    <p class="card-text text-muted flex-grow-1">Consultez les réservations et mettez à jour leur statut.</p>
                    <a href="<%= request.getContextPath() %>/admin/reservations" class="btn btn-outline-primary mt-2">Gérer les réservations</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-nav h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Clients</h5>
                    <p class="card-text text-muted flex-grow-1">Visualisez et gérez vos clients réguliers.</p>
                    <a href="<%= request.getContextPath() %>/admin/clients" class="btn btn-outline-primary mt-2">Voir les clients</a>
                </div>
            </div>
        </div>
    </div>
</main>

</body>
</html>
