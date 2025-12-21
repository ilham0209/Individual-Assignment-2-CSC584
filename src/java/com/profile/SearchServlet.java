package com.profile;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:derby://localhost:1527/student_profiles";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "swizard";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchQuery = request.getParameter("searchQuery");
        
        // Search database for matching profiles
        ArrayList<ProfileBean> results = searchProfiles(searchQuery);
        
        // Set results as request attribute
        request.setAttribute("searchResults", results);
        request.setAttribute("searchQuery", searchQuery);
        
        // Forward to results page
        request.getRequestDispatcher("searchResults.jsp").forward(request, response);
    }
    
    /**
     * Search for profiles by name or student ID
     */
    private ArrayList<ProfileBean> searchProfiles(String query) {
        ArrayList<ProfileBean> profiles = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            // Load driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // SQL query with LIKE for partial matching
            String sql = "SELECT * FROM profiles WHERE LOWER(name) LIKE ? OR LOWER(student_id) LIKE ?";
            pstmt = conn.prepareStatement(sql);
            
            String searchPattern = "%" + query.toLowerCase() + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            rs = pstmt.executeQuery();
            
            // Build ProfileBean objects from results
            while (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setId(rs.getInt("id"));
                profile.setName(rs.getString("name"));
                profile.setStudentId(rs.getString("student_id"));
                profile.setProgram(rs.getString("program"));
                profile.setEmail(rs.getString("email"));
                profile.setHobbies(rs.getString("hobbies"));
                profile.setIntroduction(rs.getString("introduction"));
                
                profiles.add(profile);
            }
            
            System.out.println("Search found " + profiles.size() + " results");
            
        } catch (ClassNotFoundException e) {
            System.out.println("Driver error: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Search error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }
        
        return profiles;
    }
}