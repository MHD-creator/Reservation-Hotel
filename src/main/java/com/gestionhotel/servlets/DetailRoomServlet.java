package com.gestionhotel.servlets;

import com.gestionhotel.dao.ChambreDao;
import com.gestionhotel.model.Chambre;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "detailRoomServlet", value = "/room")
public class DetailRoomServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().length() == 0) {
            response.sendRedirect(request.getContextPath() + "/rooms/search");
            return;
        }

        Long id;
        try {
            id = Long.valueOf(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/rooms/search");
            return;
        }

        ChambreDao chambreDao = new ChambreDao();
        Chambre chambre = chambreDao.findById(id);
        if (chambre == null) {
            response.sendRedirect(request.getContextPath() + "/rooms/search");
            return;
        }

        request.setAttribute("chambre", chambre);
        request.getRequestDispatcher("/rooms/details_room.jsp").forward(request, response);
    }
}
