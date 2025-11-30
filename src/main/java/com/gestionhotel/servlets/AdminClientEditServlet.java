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
        Utilisateur cible = dao.findById(id);
        if (cible == null) {
            response.sendRedirect(request.getContextPath() + "/admin/clients");
            return;
        }

        if ("ADMIN".equalsIgnoreCase(cible.getRole()) && (cible.getId() == null || !cible.getId().equals(admin.getId()))) {
            request.setAttribute("errorMessage", "Vous ne pouvez pas modifier le compte administrateur d'un autre hôtel.");
            response.sendRedirect(request.getContextPath() + "/admin/clients");
            return;
        }

        request.setAttribute("utilisateur", cible);
        request.getRequestDispatcher("/admin/client_edit.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        Utilisateur cible = dao.findById(id);
        if (cible == null) {
            response.sendRedirect(request.getContextPath() + "/admin/clients");
            return;
        }

        if ("ADMIN".equalsIgnoreCase(cible.getRole()) && (cible.getId() == null || !cible.getId().equals(admin.getId()))) {
            request.setAttribute("errorMessage", "Vous ne pouvez pas modifier le compte administrateur d'un autre hôtel.");
            response.sendRedirect(request.getContextPath() + "/admin/clients");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");

        StringBuilder error = new StringBuilder();
        if (nom == null || nom.trim().length() == 0) {
            error.append("Le nom est obligatoire. ");
        }
        if (email == null || email.trim().length() == 0) {
            error.append("L'email est obligatoire. ");
        }

        if (error.length() > 0) {
            request.setAttribute("errorMessage", error.toString());
            request.setAttribute("utilisateur", cible);
            request.getRequestDispatcher("/admin/client_edit.jsp").forward(request, response);
            return;
        }

        cible.setNom(nom);
        cible.setEmail(email);
        cible.setTelephone(telephone);
        dao.saveOrUpdate(cible);

        if (admin.getId() != null && admin.getId().equals(cible.getId())) {
            session.setAttribute("user", cible);
        }

        response.sendRedirect(request.getContextPath() + "/admin/clients");
    }
}
