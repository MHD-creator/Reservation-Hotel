<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/layout/admin_header.jspf" %>
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h1 class="h4 mb-1">Chambres</h1>
            <p class="text-muted mb-0">Liste des chambres disponibles dans l'hôtel.</p>
        </div>
        <a href="<%= request.getContextPath() %>/admin/chambres/form" class="btn btn-primary">+ Nouvelle chambre</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <table class="table mb-0 align-middle table-hover">
                <thead class="table-light">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Photo</th>
                    <th scope="col">Numéro</th>
                    <th scope="col">Type</th>
                    <th scope="col">Capacité</th>
                    <th scope="col">Prix/nuit</th>
                    <th scope="col">Statut</th>
                    <th scope="col" class="text-end">Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    java.util.List<com.gestionhotel.model.Chambre> chambres =
                            (java.util.List<com.gestionhotel.model.Chambre>) request.getAttribute("chambres");
                    if (chambres != null && !chambres.isEmpty()) {
                        int index = 1;
                        for (com.gestionhotel.model.Chambre c : chambres) {
                %>
                <tr>
                    <th scope="row"><%= index++ %></th>
                    <td>
                        <% if (c.getPhotoPath() != null && !c.getPhotoPath().isEmpty()) { %>
                            <img src="<%= request.getContextPath() + c.getPhotoPath() %>" alt="Photo" class="img-thumbnail" style="max-height: 60px;">
                        <% } else { %>
                            <span class="text-muted small">Aucune</span>
                        <% } %>
                    </td>
                    <td><%= c.getNumero() %></td>
                    <td><%= c.getType() %></td>
                    <td><%= c.getCapacite() %></td>
                    <td><%= c.getPrixNuit() != null ? c.getPrixNuit().toPlainString() : "-" %> €</td>
                    <td><span class="badge bg-<%= "DISPONIBLE".equalsIgnoreCase(c.getStatut()) ? "success" : "secondary" %>"><%= c.getStatut() %></span></td>
                    <td class="text-end">
                        <a href="<%= request.getContextPath() %>/admin/chambres/form?id=<%= c.getId() %>" class="btn btn-sm btn-outline-primary me-1">Modifier</a>
                        <form action="<%= request.getContextPath() %>/admin/chambres/delete" method="post" class="d-inline">
                            <input type="hidden" name="id" value="<%= c.getId() %>">
                            <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Supprimer cette chambre ?');">Supprimer</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" class="text-center text-muted py-4">Aucune chambre pour le moment. Ajoutez votre première chambre.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
<%@ include file="/WEB-INF/layout/admin_footer.jspf" %>
