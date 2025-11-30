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
import java.util.List;

@WebServlet(name = "AdminChambreListServlet", value = "/admin/chambres")
public class AdminChambreListServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null || utilisateur.getRole() == null || !"ADMIN".equalsIgnoreCase(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ChambreDao chambreDao = new ChambreDao();
        List<Chambre> chambres = chambreDao.findAll();
        request.setAttribute("chambres", chambres);
        request.getRequestDispatcher("/admin/chambres_list.jsp").forward(request, response);
    }
}
