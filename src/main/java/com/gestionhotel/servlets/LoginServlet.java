package com.gestionhotel.servlets;

import com.gestionhotel.dao.UtilisateurDao;
import com.gestionhotel.model.Utilisateur;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
//Declaration du servlet
@WebServlet(name="LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    public void doGet (HttpServletRequest request, HttpServletResponse response) throws IOException {
        //on retourne la page de connexion
        response.sendRedirect(response.encodeRedirectURL("authentication/login.jsp"));
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("password");

        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur utilisateur = utilisateurDao.findByEmailAndPassword(email, motDePasse);

        if (utilisateur == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=1");
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("user", utilisateur);

        if ("ADMIN".equalsIgnoreCase(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
