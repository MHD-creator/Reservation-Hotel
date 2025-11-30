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
import java.util.List;

@WebServlet(name = "AdminReservationListServlet", value = "/admin/reservations")
public class AdminReservationListServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null || utilisateur.getRole() == null || !"ADMIN".equalsIgnoreCase(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ReservationDao reservationDao = new ReservationDao();
        List<Reservation> reservations = reservationDao.findAll();
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("/admin/reservations_list.jsp").forward(request, response);
    }
}
