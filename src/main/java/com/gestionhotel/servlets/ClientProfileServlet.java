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

@WebServlet(name = "ClientProfileServlet", value = "/profile")
public class ClientProfileServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.setAttribute("utilisateur", utilisateur);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login");
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

        if (error.length() == 0) {
            utilisateur.setNom(nom);
            utilisateur.setEmail(email);
            utilisateur.setTelephone(telephone);
            new UtilisateurDao().saveOrUpdate(utilisateur);
            session.setAttribute("user", utilisateur);
            request.setAttribute("successMessage", "Profil mis à jour avec succès.");
        } else {
            request.setAttribute("errorMessage", error.toString());
        }

        request.setAttribute("utilisateur", utilisateur);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}
