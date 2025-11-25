<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Your Profile</title>
  <style>
    body { background: linear-gradient(135deg,#89f7fe,#66a6ff); font-family:Arial; display:flex; justify-content:center; padding-top:40px; }
    .card { background:white; width:520px; padding:24px; border-radius:12px; box-shadow:0 10px 20px rgba(0,0,0,0.2); }
    h2 { text-align:center; margin-bottom:12px; }
    .item { margin:10px 0; font-size:16px; }
    .label { font-weight:bold; color:#333; }
    .intro { white-space:pre-wrap; margin-top:6px; }
  </style>
</head>
<body>
  <div class="card">
    <h2>Your Submitted Profile</h2>
    <div class="item"><span class="label">Name:</span> ${name}</div>
    <div class="item"><span class="label">Student ID:</span> ${studentID}</div>
    <div class="item"><span class="label">Program:</span> ${program}</div>
    <div class="item"><span class="label">Email:</span> ${email}</div>
    <div class="item"><span class="label">Hobbies:</span> ${hobbies}</div>
    <div class="item"><span class="label">Introduction:</span>
      <div class="intro">${intro}</div>
    </div>
    <div style="text-align:center; margin-top:14px;">
      <a href="index.html">Submit another</a>
    </div>
  </div>
</body>
</html>
