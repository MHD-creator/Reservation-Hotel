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

@WebServlet(name = "ReservationCancelServlet", value = "/reservations/cancel")
public class ReservationCancelServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null || utilisateur.getRole() == null || !"CLIENT".equalsIgnoreCase(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam != null && idParam.trim().length() > 0) {
            Long id = Long.valueOf(idParam);
            ReservationDao reservationDao = new ReservationDao();
            Reservation reservation = reservationDao.findById(id);
            if (reservation != null && reservation.getClient() != null && utilisateur.getId().equals(reservation.getClient().getId())) {
                // Only allow cancellation for future or current stays (simple rule: dateDebut >= today)
                reservation.setStatut("ANNULEE");
                reservationDao.save(reservation);
            }
        }

        response.sendRedirect(request.getContextPath() + "/reservations/mine");
    }
}
