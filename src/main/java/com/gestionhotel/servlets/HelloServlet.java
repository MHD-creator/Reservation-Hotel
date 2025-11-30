package com.gestionhotel.servlets;

import jakarta.servlet.annotation.WebServlet; // Import manquant
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

// Annotation qui définit l'URL d'accès : http://localhost:8080/hello
@WebServlet(name = "helloServlet", value = "/hello")
public class HelloServlet extends HttpServlet { // Hérite de HttpServlet pour devenir une servlet
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
         response.sendRedirect("index.jsp");
    }
}
