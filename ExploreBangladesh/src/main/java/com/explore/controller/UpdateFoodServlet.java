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

@WebServlet("/admin/updateFood")
@MultipartConfig
public class UpdateFoodServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/manage_food.jsp");
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
            PreparedStatement updateStmt;

            if (newFileName != null) {
                updateStmt = conn.prepareStatement("UPDATE food SET name = ?, description = ?, image = ? WHERE id = ?");
                updateStmt.setString(1, name);
                updateStmt.setString(2, description);
                updateStmt.setString(3, "uploads/" + newFileName);
                updateStmt.setInt(4, id);
            } else {
                updateStmt = conn.prepareStatement("UPDATE food SET name = ?, description = ? WHERE id = ?");
                updateStmt.setString(1, name);
                updateStmt.setString(2, description);
                updateStmt.setInt(3, id);
            }

            updateStmt.executeUpdate();
            updateStmt.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/manage_food.jsp");
    }
}