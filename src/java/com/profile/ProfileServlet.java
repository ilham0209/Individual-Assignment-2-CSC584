package com.profile;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet for handling profile form submission
 */
public class ProfileServlet extends HttpServlet {
    
    // Derby database connection details
    private static final String DB_URL = "jdbc:derby://localhost:1527/student_profiles";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "swizard";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form data
        String name = request.getParameter("name");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String hobbies = request.getParameter("hobbies");
        String introduction = request.getParameter("introduction");
        
        // Create ProfileBean object
        ProfileBean profile = new ProfileBean(name, studentId, program, 
                                             email, hobbies, introduction);
        
        // Save to database
        boolean saved = saveProfile(profile);
        
        if (saved) {
            // Set profile as request attribute
            request.setAttribute("profile", profile);
            // Forward to profile.jsp to display
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        } else {
            // If save failed, show error
            response.getWriter().println("<h3>Error saving profile. Please try again.</h3>");
        }
    }
    
    /**
     * Method to save profile to database using JDBC
     */
    private boolean saveProfile(ProfileBean profile) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            // Load Derby driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            
            // Establish connection
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // SQL insert query
            String sql = "INSERT INTO profiles (name, student_id, program, email, hobbies, introduction) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, profile.getName());
            pstmt.setString(2, profile.getStudentId());
            pstmt.setString(3, profile.getProgram());
            pstmt.setString(4, profile.getEmail());
            pstmt.setString(5, profile.getHobbies());
            pstmt.setString(6, profile.getIntroduction());
            
            // Execute insert
            int rows = pstmt.executeUpdate();
            
            // Debug output
            System.out.println("Profile saved! Rows affected: " + rows);
            
            return rows > 0;
            
        } catch (ClassNotFoundException e) {
            System.out.println("Derby driver not found: " + e.getMessage());
            return false;
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
            return false;
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}