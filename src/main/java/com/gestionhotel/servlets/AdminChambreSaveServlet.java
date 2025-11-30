package com.gestionhotel.servlets;

import com.gestionhotel.dao.ChambreDao;
import com.gestionhotel.model.Chambre;
import com.gestionhotel.model.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet(name = "AdminChambreSaveServlet", value = "/admin/chambres/save")
@MultipartConfig
public class AdminChambreSaveServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Utilisateur utilisateur = session != null ? (Utilisateur) session.getAttribute("user") : null;
        if (utilisateur == null || utilisateur.getRole() == null || !"ADMIN".equalsIgnoreCase(utilisateur.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        String numero = request.getParameter("numero");
        String type = request.getParameter("type");
        String prixNuitStr = request.getParameter("prixNuit");
        String capaciteStr = request.getParameter("capacite");
        String description = request.getParameter("description");
        String statut = request.getParameter("statut");

        ChambreDao chambreDao = new ChambreDao();
        Chambre chambre;
        if (idParam != null && idParam.trim().length() > 0) {
            Long id = Long.valueOf(idParam);
            chambre = chambreDao.findById(id);
            if (chambre == null) {
                chambre = new Chambre();
            }
        } else {
            chambre = new Chambre();
        }

        chambre.setNumero(numero);
        chambre.setType(type);
        if (prixNuitStr != null && prixNuitStr.trim().length() > 0) {
            chambre.setPrixNuit(new BigDecimal(prixNuitStr));
        }
        if (capaciteStr != null && capaciteStr.trim().length() > 0) {
            chambre.setCapacite(Integer.parseInt(capaciteStr));
        }
        chambre.setDescription(description);
        chambre.setStatut(statut);

        Part photoPart = request.getPart("photo");
        if (photoPart != null && photoPart.getSize() > 0) {
            String submittedFileName = Paths.get(photoPart.getSubmittedFileName()).getFileName().toString();
            String uploadsDir = "/uploads/chambres";
            String realPath = getServletContext().getRealPath(uploadsDir);
            if (realPath != null) {
                Path uploadPath = Paths.get(realPath);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                String fileName = System.currentTimeMillis() + "_" + submittedFileName;
                Path filePath = uploadPath.resolve(fileName);
                photoPart.write(filePath.toString());
                chambre.setPhotoPath(uploadsDir + "/" + fileName);
            }
        }

        chambreDao.saveOrUpdate(chambre);

        response.sendRedirect(request.getContextPath() + "/admin/chambres");
    }
}
