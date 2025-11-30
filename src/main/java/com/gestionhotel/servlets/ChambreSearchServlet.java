package com.gestionhotel.servlets;

import com.gestionhotel.dao.ChambreDao;
import com.gestionhotel.model.Chambre;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(name = "ChambreSearchServlet", value = "/rooms/search")
public class ChambreSearchServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String type = request.getParameter("type");
        String capaciteStr = request.getParameter("capacite");
        String prixMaxStr = request.getParameter("prixMax");

        Integer capacite = null;
        if (capaciteStr != null && capaciteStr.trim().length() > 0) {
            try {
                capacite = Integer.valueOf(capaciteStr);
            } catch (NumberFormatException ignored) {}
        }

        BigDecimal prixMax = null;
        if (prixMaxStr != null && prixMaxStr.trim().length() > 0) {
            try {
                prixMax = new BigDecimal(prixMaxStr);
            } catch (NumberFormatException ignored) {}
        }

        ChambreDao chambreDao = new ChambreDao();
        List<Chambre> chambres = chambreDao.search(type, capacite, prixMax);
        request.setAttribute("chambres", chambres);
        request.setAttribute("type", type);
        request.setAttribute("capacite", capaciteStr);
        request.setAttribute("prixMax", prixMaxStr);

        request.getRequestDispatcher("/rooms/search.jsp").forward(request, response);
    }
}
