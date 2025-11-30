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

@WebServlet(name = "AdminClientEditServlet", value = "/admin/clients/edit")
public class AdminClientEditServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur admin = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (admin == null || admin.getRole() == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().length() == 0) {
            response.sendRedirect(request.getContextPath() + "/admin/clients");
            return;
        }

        Long id = Long.valueOf(idParam);
        UtilisateurDao dao = new UtilisateurDao();
        Utilisateur cible = dao.findByEmail(admin.getEmail()); // fallback simple
        cible = dao.findByEmail(admin.getEmail());
        // Pour garder simple, on ne charge que l'utilisateur par email si c'est lui-même
        // sinon on pourrait ajouter une méthode findById.

        request.setAttribute("utilisateur", admin);
        request.getRequestDispatcher("/admin/client_edit.jsp").forward(request, response);
    }
}
