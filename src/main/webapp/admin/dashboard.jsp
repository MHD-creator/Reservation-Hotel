<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/layout/admin_header.jspf" %>
    <div class="mb-4">
        <h1 class="h3 mb-1">Tableau de bord restaurant</h1>
        <p class="text-muted mb-0">Gérez vos chambres, vos réservations et vos clients.</p>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card card-nav h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Chambres</h5>
                    <p class="card-text text-muted flex-grow-1">Ajoutez, modifiez ou supprimez les chambres de l'hôtel.</p>
                    <a href="<%= request.getContextPath() %>/admin/chambres" class="btn btn-primary mt-2">Gérer les chambres</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-nav h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Réservations</h5>
                    <p class="card-text text-muted flex-grow-1">Consultez les réservations et mettez à jour leur statut.</p>
                    <a href="<%= request.getContextPath() %>/admin/reservations" class="btn btn-outline-primary mt-2">Gérer les réservations</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-nav h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Clients</h5>
                    <p class="card-text text-muted flex-grow-1">Visualisez et gérez vos clients réguliers.</p>
                    <a href="<%= request.getContextPath() %>/admin/clients" class="btn btn-outline-primary mt-2">Voir les clients</a>
                </div>
            </div>
        </div>
    </div>
<%@ include file="/WEB-INF/layout/admin_footer.jspf" %>
