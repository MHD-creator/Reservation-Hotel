<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestionhotel.model.Reservation" %>
<%@ include file="/WEB-INF/layout/admin_header.jspf" %>
    <h1 class="h4 mb-4">Toutes les réservations</h1>

    <%
        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
        if (reservations != null && !reservations.isEmpty()) {
    %>
    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>#</th>
                <th>Client</th>
                <th>Email</th>
                <th>Chambre</th>
                <th>Période</th>
                <th>Personnes</th>
                <th>Statut</th>
                <th class="text-end">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                int i = 1;
                for (Reservation r : reservations) {
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
            <tr>
                <td><%= i++ %></td>
                <td><%= r.getClient() != null ? (r.getClient().getNom() != null ? r.getClient().getNom() : "") : "" %></td>
                <td><%= r.getClient() != null ? r.getClient().getEmail() : "" %></td>
                <td>
                    Chambre <%= r.getChambre() != null ? r.getChambre().getNumero() : "" %>
                    <br>
                    <small class="text-muted"><%= r.getChambre() != null ? r.getChambre().getType() : "" %></small>
                </td>
                <td><%= r.getDateDebut() %> → <%= r.getDateFin() %></td>
                <td><%= r.getNbPersonnes() %></td>
                <td><span class="badge <%= badgeClass %>"><%= statut %></span></td>
                <td class="text-end">
                    <form method="post" action="<%= request.getContextPath() %>/admin/reservations/action" class="d-inline">
                        <input type="hidden" name="id" value="<%= r.getId() %>">
                        <% if (statut == null || "EN_ATTENTE".equalsIgnoreCase(statut)) { %>
                            <button type="submit" name="action" value="confirmer" class="btn btn-sm btn-outline-success">Confirmer</button>
                        <% } %>
                        <% if ("CONFIRMEE".equalsIgnoreCase(statut)) { %>
                            <button type="submit" name="action" value="terminer" class="btn btn-sm btn-outline-primary">Terminer</button>
                        <% } %>
                        <% if (!"TERMINEE".equalsIgnoreCase(statut)) { %>
                            <button type="submit" name="action" value="annuler" class="btn btn-sm btn-outline-danger" onclick="return confirm('Annuler cette réservation ?');">Annuler</button>
                        <% } %>
                    </form>
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
    <div class="alert alert-secondary">Aucune réservation enregistrée pour le moment.</div>
    <%
        }
    %>
<%@ include file="/WEB-INF/layout/admin_footer.jspf" %>
