<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestionhotel.model.Utilisateur" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <title>Admin - Modifier un utilisateur</title>
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<main class="container py-4">
    <h1 class="h4 mb-3">Modifier un utilisateur</h1>
    <%
        Utilisateur u = (Utilisateur) request.getAttribute("utilisateur");
        if (u == null) {
    %>
    <div class="alert alert-danger">Utilisateur introuvable.</div>
    <a href="<%= request.getContextPath() %>/admin/clients" class="btn btn-secondary">Retour</a>
    <%
        } else {
    %>
    <form method="post" action="#">
        <div class="mb-3">
            <label class="form-label">Nom</label>
            <input type="text" class="form-control" name="nom" value="<%= u.getNom() != null ? u.getNom() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" value="<%= u.getEmail() != null ? u.getEmail() : "" %>">
        </div>
        <div class="mb-3">
            <label class="form-label">Téléphone</label>
            <input type="text" class="form-control" name="telephone" value="<%= u.getTelephone() != null ? u.getTelephone() : "" %>">
        </div>
        <a href="<%= request.getContextPath() %>/admin/clients" class="btn btn-link">Annuler</a>
        <button type="submit" class="btn btn-primary">Enregistrer</button>
    </form>
    <%
        }
    %>
</main>
</body>
</html>
