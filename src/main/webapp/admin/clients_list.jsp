<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestionhotel.model.Utilisateur" %>
<!doctype html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <title>Admin - Clients</title>
    <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
    <div class="container">
        <a class="navbar-brand" href="<%= request.getContextPath() %>/admin/dashboard">Hôtel Évasion - Admin</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/admin/chambres">Chambres</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/admin/reservations">Réservations</a></li>
                <li class="nav-item"><a class="nav-link active" href="<%= request.getContextPath() %>/admin/clients">Clients</a></li>
            </ul>
        </div>
    </div>
</nav>

<main class="container">
    <h1 class="h4 mb-4">Clients</h1>

    <%
        List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("utilisateurs");
        if (utilisateurs != null && !utilisateurs.isEmpty()) {
    %>
    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>#</th>
                <th>Nom</th>
                <th>Email</th>
                <th>Téléphone</th>
                <th>Rôle</th>
            </tr>
            </thead>
            <tbody>
            <%
                int i = 1;
                for (Utilisateur u : utilisateurs) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= u.getNom() != null ? u.getNom() : "" %></td>
                <td><%= u.getEmail() != null ? u.getEmail() : "" %></td>
                <td><%= u.getTelephone() != null ? u.getTelephone() : "" %></td>
                <td><span class="badge <%= "ADMIN".equalsIgnoreCase(u.getRole()) ? "bg-danger" : "bg-primary" %>"><%= u.getRole() %></span></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <%
        } else {
    %>
    <div class="alert alert-secondary">Aucun client enregistré pour le moment.</div>
    <%
        }
    %>
</main>
</body>
</html>
