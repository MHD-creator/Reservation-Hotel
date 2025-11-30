<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/layout/client_header.jspf" %>

<style>
    body { background: linear-gradient(180deg,#ffffff 0%, #f8f9fb 100%); }
    .room-card { border-radius:12px; overflow:hidden; box-shadow:0 10px 30px rgba(15,23,42,0.08); }
    .room-card img { object-fit:cover; height:180px; }
</style>

<div class="row g-4">
    <div class="col-lg-3">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="h6 mb-3">Filtrer les chambres</h2>
                <form method="get" action="<%= request.getContextPath() %>/rooms/search">
                    <div class="mb-3">
                        <label class="form-label">Type</label>
                        <select name="type" class="form-select">
                            <option value="">Tous</option>
                            <option value="SIMPLE" <%= "SIMPLE".equals(request.getAttribute("type")) ? "selected" : "" %>>Simple</option>
                            <option value="DOUBLE" <%= "DOUBLE".equals(request.getAttribute("type")) ? "selected" : "" %>>Double</option>
                            <option value="SUITE" <%= "SUITE".equals(request.getAttribute("type")) ? "selected" : "" %>>Suite</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Capacité min.</label>
                        <input type="number" min="1" name="capacite" class="form-control"
                               value="<%= request.getAttribute("capacite") != null ? request.getAttribute("capacite") : "" %>">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Prix max. (€)</label>
                        <input type="number" step="0.01" min="0" name="prixMax" class="form-control"
                               value="<%= request.getAttribute("prixMax") != null ? request.getAttribute("prixMax") : "" %>">
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Rechercher</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-lg-9">
        <h1 class="h4 mb-3">Résultats</h1>
        <div class="row g-3">
            <%
                java.util.List<com.gestionhotel.model.Chambre> chambres =
                        (java.util.List<com.gestionhotel.model.Chambre>) request.getAttribute("chambres");
                if (chambres != null && !chambres.isEmpty()) {
                    for (com.gestionhotel.model.Chambre c : chambres) {
            %>
            <div class="col-md-6">
                <div class="card room-card h-100">
                    <% if (c.getPhotoPath() != null && !c.getPhotoPath().isEmpty()) { %>
                        <img src="<%= request.getContextPath() + c.getPhotoPath() %>" class="card-img-top" alt="Photo chambre">
                    <% } %>
                    <div class="card-body">
                        <h5 class="card-title">Chambre <%= c.getNumero() %></h5>
                        <p class="card-text text-muted mb-1"><%= c.getType() %> • <%= c.getCapacite() %> pers.</p>
                        <p class="card-text fw-bold mb-2">
                            <%= c.getPrixNuit() != null ? c.getPrixNuit().toPlainString() : "-" %> FCFA / nuit
                        </p>
                        <p class="card-text small text-muted">
                            <%= c.getDescription() != null ? c.getDescription() : "" %>
                        </p>
                        <a href="<%= request.getContextPath() %>/room?id=<%= c.getId() %>"
                           class="btn btn-outline-primary btn-sm">Voir détails / Réserver</a>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-12">
                <div class="alert alert-secondary">Aucune chambre ne correspond à votre recherche.</div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/layout/client_footer.jspf" %>