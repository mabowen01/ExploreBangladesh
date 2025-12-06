package com.explore.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import db.DBConnection;

@WebServlet("/admin/updateMusic")
@MultipartConfig
public class UpdateMusicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/manage_music.jsp");
            return;
        }
        int id = Integer.parseInt(idStr);

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
            String sql;
            PreparedStatement updateStmt;

            if (newFileName != null) {
                sql = "UPDATE music SET name = ?, description = ?, image = ? WHERE id = ?";
                updateStmt = conn.prepareStatement(sql);
                updateStmt.setString(1, name);
                updateStmt.setString(2, description);
                updateStmt.setString(3, "uploads/" + newFileName);
                updateStmt.setInt(4, id);
            } else {
                sql = "UPDATE music SET name = ?, description = ? WHERE id = ?";
                updateStmt = conn.prepareStatement(sql);
                updateStmt.setString(1, name);
                updateStmt.setString(2, description);
                updateStmt.setInt(3, id);
            }

            updateStmt.executeUpdate();
            updateStmt.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("edit_music.jsp?id=" + id).forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/manage_music.jsp");
    }
}