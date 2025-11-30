<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestionhotel.model.Utilisateur" %>
<%@ include file="/WEB-INF/layout/admin_header.jspf" %>
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
                <th class="text-end">Actions</th>
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
                <td class="text-end">
                    <a href="<%= request.getContextPath() %>/admin/clients/edit?id=<%= u.getId() %>" class="btn btn-sm btn-outline-primary">Modifier</a>
                </td>
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
<%@ include file="/WEB-INF/layout/admin_footer.jspf" %>
