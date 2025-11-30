package com.gestionhotel.servlets;

import com.gestionhotel.dao.ChambreDao;
import com.gestionhotel.dao.ReservationDao;
import com.gestionhotel.dao.UtilisateurDao;
import com.gestionhotel.model.Chambre;
import com.gestionhotel.model.Reservation;
import com.gestionhotel.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@WebServlet(name = "ReservationCreateServlet", value = "/reservation/create")
public class ReservationCreateServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String chambreIdStr = request.getParameter("chambreId");
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        String motDePasseConfirm = request.getParameter("motDePasseConfirm");
        String telephone = request.getParameter("telephone");
        String dateDebutStr = request.getParameter("dateDebut");
        String dateFinStr = request.getParameter("dateFin");
        String nbPersonnesStr = request.getParameter("nbPersonnes");
        String commentaire = request.getParameter("commentaire");

        if (chambreIdStr == null || chambreIdStr.trim().length() == 0) {
            response.sendRedirect(request.getContextPath() + "/rooms/search");
            return;
        }

        Long chambreId = Long.valueOf(chambreIdStr);
        ChambreDao chambreDao = new ChambreDao();
        Chambre chambre = chambreDao.findById(chambreId);
        if (chambre == null) {
            response.sendRedirect(request.getContextPath() + "/rooms/search");
            return;
        }

        StringBuilder error = new StringBuilder();
        if (nom == null || nom.trim().length() == 0) {
            error.append("Veuillez saisir votre nom. ");
        }
        if (email == null || email.trim().length() == 0) {
            error.append("Veuillez saisir votre email. ");
        }
        if (dateDebutStr == null || dateDebutStr.trim().length() == 0 ||
                dateFinStr == null || dateFinStr.trim().length() == 0) {
            error.append("Veuillez choisir vos dates d'arrivée et de départ. ");
        }
        if (nbPersonnesStr == null || nbPersonnesStr.trim().length() == 0) {
            error.append("Veuillez indiquer le nombre de personnes. ");
        }

        LocalDate dateDebut = null;
        LocalDate dateFin = null;
        int nbPersonnes = 0;
        int duree = 0;

        UtilisateurDao utilisateurDao = new UtilisateurDao();
        Utilisateur client = null;

        // Priorité : utilisateur déjà connecté en session (client)
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object sessionUserObj = session.getAttribute("user");
            if (sessionUserObj instanceof Utilisateur) {
                Utilisateur sessionUser = (Utilisateur) sessionUserObj;
                if (sessionUser.getRole() != null && "CLIENT".equalsIgnoreCase(sessionUser.getRole())) {
                    client = sessionUser;
                    // on force nom/email/tel sur ceux du compte
                    nom = sessionUser.getNom();
                    email = sessionUser.getEmail();
                    telephone = sessionUser.getTelephone();
                }
            }
        }

        // Sinon, on tente de retrouver un client par email
        if (client == null && email != null && email.trim().length() > 0) {
            client = utilisateurDao.findByEmail(email);
        }

        if (error.length() == 0) {
            try {
                dateDebut = LocalDate.parse(dateDebutStr);
                dateFin = LocalDate.parse(dateFinStr);
                if (!dateFin.isAfter(dateDebut)) {
                    error.append("La date de départ doit être après la date d'arrivée. ");
                }
            } catch (Exception e) {
                error.append("Dates invalides. ");
            }

            try {
                nbPersonnes = Integer.parseInt(nbPersonnesStr);
                if (nbPersonnes <= 0) {
                    error.append("Le nombre de personnes doit être supérieur à 0. ");
                } else if (nbPersonnes > chambre.getCapacite()) {
                    error.append("Le nombre de personnes dépasse la capacité de la chambre. ");
                }
            } catch (NumberFormatException e) {
                error.append("Nombre de personnes invalide. ");
            }
        }

        // Validation spécifique au mot de passe : uniquement si on crée un nouveau client
        if (error.length() == 0 && client == null) {
            if (motDePasse == null || motDePasse.trim().length() == 0) {
                error.append("Veuillez choisir un mot de passe. ");
            } else if (motDePasseConfirm == null || motDePasseConfirm.trim().length() == 0) {
                error.append("Veuillez confirmer votre mot de passe. ");
            } else if (!motDePasse.equals(motDePasseConfirm)) {
                error.append("Les mots de passe ne correspondent pas. ");
            }
        }

        if (error.length() > 0) {
            request.setAttribute("chambre", chambre);
            request.setAttribute("errorMessage", error.toString());
            request.setAttribute("nom", nom);
            request.setAttribute("email", email);
            request.setAttribute("telephone", telephone);
            request.setAttribute("dateDebut", dateDebutStr);
            request.setAttribute("dateFin", dateFinStr);
            request.setAttribute("nbPersonnes", nbPersonnesStr);
            request.setAttribute("commentaire", commentaire);
            request.getRequestDispatcher("/rooms/details_room.jsp").forward(request, response);
            return;
        }

        duree = (int) ChronoUnit.DAYS.between(dateDebut, dateFin);
        if (client == null) {
            client = new Utilisateur();
            client.setNom(nom);
            client.setEmail(email);
            client.setTelephone(telephone);
            client.setMotDePasse(motDePasse);
            client.setRole("CLIENT");
            utilisateurDao.saveOrUpdate(client);
        }

        Reservation reservation = new Reservation();
        reservation.setClient(client);
        reservation.setChambre(chambre);
        reservation.setDateDebut(dateDebut);
        reservation.setDateFin(dateFin);
        reservation.setNbPersonnes(nbPersonnes);
        reservation.setCommentaire(commentaire);
        reservation.setDuree(duree);
        reservation.setStatut("EN_ATTENTE");

        new ReservationDao().save(reservation);

        response.sendRedirect(request.getContextPath() + "/reservation/confirmation.jsp");
    }
}
