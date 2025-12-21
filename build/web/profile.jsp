<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.profile.ProfileBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile Saved</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        h1 {
            color: #667eea;
            text-align: center;
            margin-bottom: 10px;
        }
        .success-msg {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .profile-info {
            margin: 20px 0;
        }
        .info-row {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .info-label {
            font-weight: bold;
            color: #555;
            display: inline-block;
            width: 150px;
        }
        .info-value {
            color: #333;
        }
        .button-group {
            text-align: center;
            margin-top: 30px;
        }
        .btn {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✓ Profile Saved Successfully!</h1>
        
        <div class="success-msg">
            Your profile has been saved to the database.
        </div>
        
        <%
            ProfileBean profile = (ProfileBean) request.getAttribute("profile");
            if (profile != null) {
        %>
        
        <div class="profile-info">
            <div class="info-row">
                <span class="info-label">Name:</span>
                <span class="info-value"><%= profile.getName() %></span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Student ID:</span>
                <span class="info-value"><%= profile.getStudentId() %></span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Program:</span>
                <span class="info-value"><%= profile.getProgram() %></span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Email:</span>
                <span class="info-value"><%= profile.getEmail() %></span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Hobbies:</span>
                <span class="info-value"><%= profile.getHobbies() %></span>
            </div>
            
            <div class="info-row">
                <span class="info-label">Introduction:</span>
                <span class="info-value"><%= profile.getIntroduction() %></span>
            </div>
        </div>
        
        <%
            }
        %>
        
        <div class="button-group">
            <a href="viewProfiles.jsp" class="btn btn-primary">View All Profiles</a>
            <a href="index.html" class="btn btn-secondary">Add New Profile</a>
            <a href="searchProfile.jsp" class="btn btn-secondary">Search Profiles</a>
        </div>
    </div>
</body>
</html>