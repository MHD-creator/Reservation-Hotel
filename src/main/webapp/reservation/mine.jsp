<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.gestionhotel.model.Reservation" %>
<%@ include file="/WEB-INF/layout/client_header.jspf" %>
    <h1 class="h4 mb-4">Mes réservations</h1>

    <%
        if (user != null) {
    %>
    <p class="text-muted">Connecté en tant que <strong><%= user.getNom() != null ? user.getNom() : user.getEmail() %></strong></p>
    <%
        }

        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
        LocalDate today = LocalDate.now();
        boolean hasUpcoming = false;
        boolean hasPast = false;
        if (reservations != null) {
            for (Reservation r : reservations) {
                if (r.getDateFin() == null || !r.getDateFin().isBefore(today)) {
                    hasUpcoming = true;
                } else {
                    hasPast = true;
                }
            }
        }
        if (reservations != null && !reservations.isEmpty()) {
    %>

    <% if (hasUpcoming) { %>
    <h2 class="h5 mt-3 mb-3">À venir</h2>
    <div class="table-responsive mb-4">
        <table class="table align-middle">
            <thead>
            <tr>
                <th>Photo</th>
                <th>Chambre</th>
                <th>Période</th>
                <th>Personnes</th>
                <th>Statut</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Reservation r : reservations) {
                    if (r.getDateFin() != null && r.getDateFin().isBefore(today)) {
                        continue;
                    }
                    String photoPath = (r.getChambre() != null) ? r.getChambre().getPhotoPath() : null;
            %>
            <tr>
                <td style="width: 80px;">
                    <% if (photoPath != null && photoPath.trim().length() > 0) { %>
                        <img src="<%= request.getContextPath() + photoPath %>" alt="Photo chambre" class="img-thumbnail" style="max-width:70px; cursor:pointer;" data-bs-toggle="modal" data-bs-target="#photoModal_<%= r.getId() %>">
                    <% } %>
                </td>
                <td>
                    Chambre <%= r.getChambre() != null ? r.getChambre().getNumero() : "" %>
                    <br>
                    <small class="text-muted"><%= r.getChambre() != null ? r.getChambre().getType() : "" %></small>
                </td>
                <td>
                    <%= r.getDateDebut() %> → <%= r.getDateFin() %>
                </td>
                <td><%= r.getNbPersonnes() %></td>
                <td>
                    <%
                        String statut = r.getStatut();
                        String badgeClass = "bg-secondary";
                        if (statut != null) {
                            if ("EN_ATTENTE".equalsIgnoreCase(statut)) {
                                badgeClass = "bg-warning text-dark";
                            } else if ("CONFIRMEE".equalsIgnoreCase(statut)) {
                                badgeClass = "bg-success";
                            } else if ("ANNULEE".equalsIgnoreCase(statut)) {
                                badgeClass = "bg-secondary";
                            } else if ("TERMINEE".equalsIgnoreCase(statut)) {
                                badgeClass = "bg-dark";
                            }
                        }
                    %>
                    <span class="badge <%= badgeClass %>"><%= statut %></span>
                </td>
                <td class="text-end">
                    <%
                        String statutBtn = r.getStatut();
                        if (statutBtn != null && !"ANNULEE".equalsIgnoreCase(statutBtn)) {
                    %>
                    <form method="post" action="<%= request.getContextPath() %>/reservations/cancel" class="d-inline">
                        <input type="hidden" name="id" value="<%= r.getId() %>">
                        <button type="submit" class="btn btn-outline-danger btn-sm" onclick="return confirm('Annuler cette réservation ?');">Annuler</button>
                    </form>
                    <%
                        }
                    %>
                </td>
            </tr>

            <!-- Modal photo pour cette réservation -->
            <div class="modal fade" id="photoModal_<%= r.getId() %>" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Chambre <%= r.getChambre() != null ? r.getChambre().getNumero() : "" %></h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                        </div>
                        <div class="modal-body text-center">
                            <% if (photoPath != null && photoPath.trim().length() > 0) { %>
                                <img src="<%= request.getContextPath() + photoPath %>" alt="Photo chambre" class="img-fluid">
                            <% } else { %>
                                <p class="text-muted">Aucune photo disponible pour cette chambre.</p>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>

            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <% } %>

    <% if (hasPast) { %>
    <h2 class="h6 mt-4 mb-2 text-muted">Historique</h2>
    <div class="table-responsive">
        <table class="table align-middle table-sm">
            <thead>
            <tr>
                <th>Chambre</th>
                <th>Période</th>
                <th>Personnes</th>
                <th>Statut</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Reservation r : reservations) {
                    if (r.getDateFin() == null || !r.getDateFin().isBefore(today)) {
                        continue;
                    }
                    String statutHist = r.getStatut();
                    String badgeClassHist = "bg-secondary";
                    if (statutHist != null) {
                        if ("EN_ATTENTE".equalsIgnoreCase(statutHist)) {
                            badgeClassHist = "bg-warning text-dark";
                        } else if ("CONFIRMEE".equalsIgnoreCase(statutHist)) {
                            badgeClassHist = "bg-success";
                        } else if ("ANNULEE".equalsIgnoreCase(statutHist)) {
                            badgeClassHist = "bg-secondary";
                        } else if ("TERMINEE".equalsIgnoreCase(statutHist)) {
                            badgeClassHist = "bg-dark";
                        }
                    }
            %>
            <tr>
                <td>
                    Chambre <%= r.getChambre() != null ? r.getChambre().getNumero() : "" %>
                    <br>
                    <small class="text-muted"><%= r.getChambre() != null ? r.getChambre().getType() : "" %></small>
                </td>
                <td><%= r.getDateDebut() %> → <%= r.getDateFin() %></td>
                <td><%= r.getNbPersonnes() %></td>
                <td><span class="badge <%= badgeClassHist %>"><%= statutHist %></span></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <% } %>

    <%
        } else {
    %>
    <div class="alert alert-secondary">Vous n'avez pas encore de réservation.</div>
    <a href="<%= request.getContextPath() %>/rooms/search" class="btn btn-primary">Rechercher une chambre</a>
    <%
        }
    %>
</main>
<%@ include file="/WEB-INF/layout/client_footer.jspf" %>
