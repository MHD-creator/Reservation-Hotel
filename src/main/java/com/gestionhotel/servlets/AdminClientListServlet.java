package com.gestionhotel.servlets;

import com.gestionhotel.dao.UtilisateurDao;
import com.gestionhotel.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminClientListServlet", value = "/admin/clients")
public class AdminClientListServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null || utilisateur.getRole() == null || !"ADMIN".equalsIgnoreCase(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UtilisateurDao utilisateurDao = new UtilisateurDao();
        List<Utilisateur> utilisateurs = utilisateurDao.findAll();
        request.setAttribute("utilisateurs", utilisateurs);
        request.getRequestDispatcher("/admin/clients_list.jsp").forward(request, response);
    }
}
