<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestionhotel.model.Utilisateur" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <title>Mon profil - Hôtel Évasion</title>
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h1 class="h4 mb-3">Mon profil</h1>
                    <p class="text-muted mb-4">Consultez et mettez à jour vos informations personnelles.</p>

                    <%
                        Utilisateur u = (Utilisateur) request.getAttribute("utilisateur");
                        if (u == null) {
                            u = (Utilisateur) session.getAttribute("user");
                        }
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        String successMessage = (String) request.getAttribute("successMessage");
                        if (errorMessage != null && errorMessage.trim().length() > 0) {
                    %>
                    <div class="alert alert-danger"><%= errorMessage %></div>
                    <%
                        }
                        if (successMessage != null && successMessage.trim().length() > 0) {
                    %>
                    <div class="alert alert-success"><%= successMessage %></div>
                    <%
                        }
                    %>

                    <form method="post" action="<%= request.getContextPath() %>/profile">
                        <div class="mb-3">
                            <label class="form-label" for="nom">Nom</label>
                            <input type="text" class="form-control" id="nom" name="nom" value="<%= u != null && u.getNom() != null ? u.getNom() : "" %>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="<%= u != null && u.getEmail() != null ? u.getEmail() : "" %>">
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="telephone">Téléphone</label>
                            <input type="text" class="form-control" id="telephone" name="telephone" value="<%= u != null && u.getTelephone() != null ? u.getTelephone() : "" %>">
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <a href="<%= request.getContextPath() %>/" class="btn btn-link">Retour à l'accueil</a>
                            <button type="submit" class="btn btn-primary">Enregistrer</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
