<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestionhotel.model.Utilisateur" %>
<%@ include file="/WEB-INF/layout/admin_header.jspf" %>
    <h1 class="h4 mb-3">Modifier un utilisateur</h1>
    <%
        Utilisateur u = (Utilisateur) request.getAttribute("utilisateur");
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (u == null) {
    %>
    <div class="alert alert-danger">Utilisateur introuvable.</div>
    <a href="<%= request.getContextPath() %>/admin/clients" class="btn btn-secondary">Retour</a>
    <%
        } else {
            if (errorMessage != null && errorMessage.trim().length() > 0) {
    %>
    <div class="alert alert-danger"><%= errorMessage %></div>
    <%
            }
    %>
    <form method="post" action="<%= request.getContextPath() %>/admin/clients/edit">
        <input type="hidden" name="id" value="<%= u.getId() %>">
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
<%@ include file="/WEB-INF/layout/admin_footer.jspf" %>
