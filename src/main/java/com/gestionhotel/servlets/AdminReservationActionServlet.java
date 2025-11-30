package com.gestionhotel.servlets;

import com.gestionhotel.dao.ReservationDao;
import com.gestionhotel.model.Reservation;
import com.gestionhotel.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AdminReservationActionServlet", value = "/admin/reservations/action")
public class AdminReservationActionServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null || utilisateur.getRole() == null || !"ADMIN".equalsIgnoreCase(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        String action = request.getParameter("action");
        if (idParam != null && idParam.trim().length() > 0 && action != null) {
            Long id = Long.valueOf(idParam);
            ReservationDao reservationDao = new ReservationDao();
            Reservation reservation = reservationDao.findById(id);
            if (reservation != null) {
                String statut = reservation.getStatut();
                if ("confirmer".equalsIgnoreCase(action)) {
                    if (statut == null || "EN_ATTENTE".equalsIgnoreCase(statut)) {
                        reservation.setStatut("CONFIRMEE");
                        reservationDao.save(reservation);
                    }
                } else if ("terminer".equalsIgnoreCase(action)) {
                    if ("CONFIRMEE".equalsIgnoreCase(statut)) {
                        reservation.setStatut("TERMINEE");
                        reservationDao.save(reservation);
                    }
                } else if ("annuler".equalsIgnoreCase(action)) {
                    if (!"TERMINEE".equalsIgnoreCase(statut)) {
                        reservation.setStatut("ANNULEE");
                        reservationDao.save(reservation);
                    }
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/reservations");
    }
}
