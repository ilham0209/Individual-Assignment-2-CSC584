<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.profile.ProfileBean" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Profiles</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 30px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        h1 {
            color: #667eea;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th {
            background: #667eea;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background: #f5f5f5;
        }
        .no-data {
            text-align: center;
            padding: 20px;
            color: #999;
        }
        .btn-back {
            display: inline-block;
            padding: 10px 20px;
            background: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
        .btn-back:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>All Student Profiles</h1>
        
        <%
            // Database connection details
            String dbUrl = "jdbc:derby://localhost:1527/student_profiles";
            String dbUser = "sa";
            String dbPassword = "swizard";
            
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            try {
                // Load driver and connect
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                
                // Query to get all profiles
                String sql = "SELECT * FROM profiles ORDER BY id DESC";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);
                
                // Check if there are results by trying to move to first row
                boolean hasData = false;
        %>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Student ID</th>
                                <th>Program</th>
                                <th>Email</th>
                                <th>Hobbies</th>
                            </tr>
                        </thead>
                        <tbody>
        <%
                    while (rs.next()) {
                        hasData = true;
        %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("student_id") %></td>
                                <td><%= rs.getString("program") %></td>
                                <td><%= rs.getString("email") %></td>
                                <td><%= rs.getString("hobbies") %></td>
                            </tr>
        <%
                    }
                    
                    if (!hasData) {
        %>
                            <tr>
                                <td colspan="6" class="no-data">No profiles found. Add your first profile!</td>
                            </tr>
        <%
                    }
        %>
                        </tbody>
                    </table>
        <%
                
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                // Close connections
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        %>
        
        <div style="text-align: center;">
            <a href="index.html" class="btn-back">Back to Home</a>
            <a href="searchProfile.jsp" class="btn-back">Search Profiles</a>
        </div>
    </div>
</body>
</html>