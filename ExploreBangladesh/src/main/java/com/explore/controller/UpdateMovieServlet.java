package com.explore.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import db.DBConnection;

@WebServlet("/admin/updateMovie")  // <-- Servlet mapped to /admin/updateMovie URL
@MultipartConfig
public class UpdateMovieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/manage_movie.jsp");
            return;
        }

        int id = Integer.parseInt(idStr);
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        Part filePart = request.getPart("image");
        String newFileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            newFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + newFileName);
        }

        try (Connection conn = DBConnection.getConnection()) {
            String currentImage = null;

            // Get current image path from DB
            PreparedStatement selectStmt = conn.prepareStatement("SELECT image FROM movie WHERE id = ?");
            selectStmt.setInt(1, id);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                currentImage = rs.getString("image");
            }

            String sql;
            PreparedStatement updateStmt;

            if (newFileName != null) {
                sql = "UPDATE movie SET name = ?, description = ?, image = ? WHERE id = ?";
                updateStmt = conn.prepareStatement(sql);
                updateStmt.setString(1, name);
                updateStmt.setString(2, description);
                updateStmt.setString(3, "uploads/" + newFileName);
                updateStmt.setInt(4, id);
            } else {
                sql = "UPDATE movie SET name = ?, description = ? WHERE id = ?";
                updateStmt = conn.prepareStatement(sql);
                updateStmt.setString(1, name);
                updateStmt.setString(2, description);
                updateStmt.setInt(3, id);
            }

            updateStmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to manage page
        response.sendRedirect(request.getContextPath() + "/admin/manage_movie.jsp");
    }
}