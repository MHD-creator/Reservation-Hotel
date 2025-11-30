<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestionhotel.model.Chambre" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <title>Chambre - Formulaire</title>
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg,#f8fafc 0%, #eef2f7 100%); }
        .card { border-radius: 14px; box-shadow: 0 10px 30px rgba(15,23,42,0.08); }
        .form-label small { font-weight: normal; color: #6c757d; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/admin/dashboard">Hôtel Évasion - Admin</a>
    </div>
</nav>
<main class="container py-3">
    <%
        Chambre chambre = (Chambre) request.getAttribute("chambre");
        boolean isEdit = chambre != null && chambre.getId() != null;
    %>
    <div class="mb-3">
        <h1 class="h4 mb-1"><%= isEdit ? "Modifier la chambre" : "Nouvelle chambre" %></h1>
        <p class="text-muted mb-0">Complétez les informations de la chambre (type, capacité, prix, statut et photo).</p>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-4">
            <form method="post" action="<%= request.getContextPath() %>/admin/chambres/save" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= chambre != null && chambre.getId() != null ? chambre.getId() : "" %>">

                <h2 class="h6 text-uppercase text-muted mb-3">Informations principales</h2>
                <div class="row g-3 mb-3">
                    <div class="col-md-4">
                        <label class="form-label">Numéro <small>(ex : 101, A12)</small></label>
                        <input type="text" name="numero" class="form-control" required value="<%= chambre != null && chambre.getNumero() != null ? chambre.getNumero() : "" %>">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Type <small>(simple, double, suite)</small></label>
                        <select name="type" class="form-select" required>
                            <option value="">Choisir...</option>
                            <option value="SIMPLE" <%= chambre != null && "SIMPLE".equals(chambre.getType()) ? "selected" : "" %>>Simple</option>
                            <option value="DOUBLE" <%= chambre != null && "DOUBLE".equals(chambre.getType()) ? "selected" : "" %>>Double</option>
                            <option value="SUITE" <%= chambre != null && "SUITE".equals(chambre.getType()) ? "selected" : "" %>>Suite</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Capacité <small>(nombre maximum de personnes)</small></label>
                        <input type="number" name="capacite" class="form-control" min="1" required value="<%= chambre != null ? chambre.getCapacite() : 1 %>">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Prix / nuit (FCFA)</label>
                        <input type="number" step="0.01" min="0" name="prixNuit" class="form-control" required value="<%= chambre != null && chambre.getPrixNuit() != null ? chambre.getPrixNuit().toPlainString() : "" %>">
                    </div>
                <hr class="my-4">
                <h2 class="h6 text-uppercase text-muted mb-3">Détails</h2>
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Statut</label>
                        <select name="statut" class="form-select" required>
                            <option value="DISPONIBLE" <%= chambre != null && "DISPONIBLE".equals(chambre.getStatut()) ? "selected" : "" %>>Disponible</option>
                            <option value="OCCUPEE" <%= chambre != null && "OCCUPEE".equals(chambre.getStatut()) ? "selected" : "" %>>Occupée</option>
                            <option value="INDISPONIBLE" <%= chambre != null && "INDISPONIBLE".equals(chambre.getStatut()) ? "selected" : "" %>>Indisponible</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Photo <small>(présentation de la chambre)</small></label>
                        <input type="file" name="photo" class="form-control">
                        <% if (chambre != null && chambre.getPhotoPath() != null && !chambre.getPhotoPath().isEmpty()) { %>
                            <div class="mt-2">
                                <span class="text-muted small d-block mb-1">Photo actuelle :</span>
                                <img src="<%= request.getContextPath() + chambre.getPhotoPath() %>" alt="Photo chambre" class="img-thumbnail" style="max-height: 120px;">
                            </div>
                        <% } %>
                    </div>

                    <div class="col-12">
                        <label class="form-label">Description <small>(équipements, vue, services...)</small></label>
                        <textarea name="description" rows="4" class="form-control"><%= chambre != null && chambre.getDescription() != null ? chambre.getDescription() : "" %></textarea>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4">
                    <a href="<%= request.getContextPath() %>/admin/chambres" class="btn btn-outline-secondary">Annuler</a>
                    <button type="submit" class="btn btn-primary"><%= isEdit ? "Enregistrer les modifications" : "Créer la chambre" %></button>
                </div>
                </div>
            </form>
        </div>
    </div>
</main>
</body>
</html>
