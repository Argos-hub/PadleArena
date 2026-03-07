<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Padel Colosseum - Registrieren</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Register.css" />
    <style>
        .navbar {
            padding: 25px 40px;
            min-height: 110px;
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }
        .navbar img {
            height: 90px;
            cursor: pointer;
        }
        .navbar a {
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/JSP/Startseite.jsp">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="Padel Colosseum Logo">
        </a>
    </div>

    <div class="login-box">
        <h2>Registrieren</h2>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <input type="hidden" name="action" value="register">
            <div class="form-group">
                <label for="username">Benutzername</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="firstName">Vorname</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
            <div class="form-group">
                <label for="lastName">Nachname</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
            <div class="form-group">
                <label for="email">E-Mail</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Telefonnummer</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="password">Passwort</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="passwordConfirm">Passwort bestätigen</label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required>
            </div>
            <button type="submit" class="btn btn-success">Registrieren</button>
        </form>
        <div class="link">
            <p>Bereits ein Konto? <a href="${pageContext.request.contextPath}/JSP/Login.jsp">Anmelden</a></p>
            <p><a href="${pageContext.request.contextPath}/JSP/Startseite.jsp">Zurueck zur Startseite</a></p>
        </div>
    </div>
</body>
</html>