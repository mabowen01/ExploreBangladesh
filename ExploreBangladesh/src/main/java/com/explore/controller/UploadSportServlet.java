package com.explore.controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;

import db.DBConnection;

@WebServlet("/uploadSport")
@MultipartConfig
public class UploadSportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String description = request.getParameter("description");

        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Image is required.");
            request.getRequestDispatcher("add_sport.jsp").forward(request, response);
            return;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String uploadPath = getServletContext().getRealPath("/") + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO sport (name, description, image) VALUES (?, ?, ?)"
            );
            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setString(3, "uploads/" + fileName);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("add_sport.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/manage_sport.jsp");
    }
}