<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.profile.ProfileBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 900px;
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
        .search-info {
            text-align: center;
            color: #666;
            margin-bottom: 20px;
        }
        .profile-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            background: #f9f9f9;
        }
        .profile-card h3 {
            color: #667eea;
            margin-top: 0;
        }
        .profile-detail {
            margin: 8px 0;
        }
        .label {
            font-weight: bold;
            color: #555;
            display: inline-block;
            width: 120px;
        }
        .no-results {
            text-align: center;
            padding: 40px;
            color: #999;
        }
        .btn-group {
            text-align: center;
            margin-top: 30px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background: #5568d3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Search Results</h1>
        
        <%
            String searchQuery = (String) request.getAttribute("searchQuery");
            ArrayList<ProfileBean> results = (ArrayList<ProfileBean>) request.getAttribute("searchResults");
        %>
        
        <p class="search-info">
            Showing results for: <strong>"<%= searchQuery %>"</strong>
            (Found <%= results.size() %> profile<%= results.size() != 1 ? "s" : "" %>)
        </p>
        
        <%
            if (results.isEmpty()) {
        %>
                <div class="no-results">
                    <h3>No profiles found</h3>
                    <p>Try searching with a different name or student ID</p>
                </div>
        <%
            } else {
                for (ProfileBean profile : results) {
        %>
                    <div class="profile-card">
                        <h3><%= profile.getName() %></h3>
                        
                        <div class="profile-detail">
                            <span class="label">Student ID:</span>
                            <%= profile.getStudentId() %>
                        </div>
                        
                        <div class="profile-detail">
                            <span class="label">Program:</span>
                            <%= profile.getProgram() %>
                        </div>
                        
                        <div class="profile-detail">
                            <span class="label">Email:</span>
                            <%= profile.getEmail() %>
                        </div>
                        
                        <div class="profile-detail">
                            <span class="label">Hobbies:</span>
                            <%= profile.getHobbies() %>
                        </div>
                        
                        <div class="profile-detail">
                            <span class="label">Introduction:</span>
                            <%= profile.getIntroduction() %>
                        </div>
                    </div>
        <%
                }
            }
        %>
        
        <div class="btn-group">
            <a href="searchProfile.jsp" class="btn">New Search</a>
            <a href="viewProfiles.jsp" class="btn">View All Profiles</a>
            <a href="index.html" class="btn">Back to Home</a>
        </div>
    </div>
</body>
</html>