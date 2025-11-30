package com.gestionhotel.servlets;

import com.gestionhotel.dao.ChambreDao;
import com.gestionhotel.model.Chambre;
import com.gestionhotel.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AdminChambreFormServlet", value = "/admin/chambres/form")
public class AdminChambreFormServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null || utilisateur.getRole() == null || !"ADMIN".equalsIgnoreCase(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        Chambre chambre = null;
        if (idParam != null && idParam.trim().length() > 0) {
            try {
                Long id = Long.valueOf(idParam);
                chambre = new ChambreDao().findById(id);
            } catch (NumberFormatException ignored) {
            }
        }
        if (chambre == null) {
            chambre = new Chambre();
        }
        request.setAttribute("chambre", chambre);
        request.getRequestDispatcher("/admin/chambre_form.jsp").forward(request, response);
    }
}
