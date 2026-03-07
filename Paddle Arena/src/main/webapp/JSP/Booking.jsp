<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="de.hwg_lu.bwi520.bean.Userbean" %>
<%@ page import="de.hwg_lu.bwi520.bean.Bookingbean" %>
<%@ page import="de.hwg_lu.bwi520.modell.Booking" %>
<%@ page import="de.hwg_lu.bwi520.modell.Courts" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    Userbean userbean = (Userbean) session.getAttribute("userbean");
    if (userbean == null || !userbean.isLoggedIn()) {
        response.sendRedirect("Login.jsp");
        return;
    }
    Bookingbean bookingbean = (Bookingbean) request.getAttribute("bookingbean");
    String error = (String) request.getAttribute("error");
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Padel Colosseum - Buchungen</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Booking.css" />
    <style>
        .navbar {
            background-color: #000000;
            padding: 25px 40px;
            min-height: 110px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin: 0 20px;
            font-size: 16px;
            font-weight: 500;
        }
        .navbar a:hover {
            text-decoration: underline;
        }
        .navbar img {
            height: 90px;
            margin-right: 40px;
            cursor: pointer;
        }
        .navbar > div {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .navbar > div:last-child {
            gap: 15px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <img src="${pageContext.request.contextPath}/img/logo.png" alt="Padel Colosseum Logo">
        <div>
            <a href="${pageContext.request.contextPath}/JSP/Startseite.jsp">Startseite</a>
            <a href="${pageContext.request.contextPath}/RatingServlet">Bewertungen</a>
            <a href="${pageContext.request.contextPath}/BookingServlet">Buchungen</a>
            
        </div>
        <div>
            <span style="color:white">Hallo, <%= userbean.getUser().getUsername() %></span> |
            <a href="${pageContext.request.contextPath}/LoginServlet?action=logout" style="color:white">Abmelden</a>
        </div>
    </div>

    <div class="container">
        <div class="card">
            <h2>Neue Buchung</h2>
            <% if (error != null) { %>
                <div class="error"><%= error %></div>
            <% } %>
            <form action="${pageContext.request.contextPath}/BookingServlet" method="post">
                <div class="form-group">
                    <label for="courtId">Platz</label>
                    <select id="courtId" name="courtId" required>
                        <option value="">-- Platz waehlen --</option>
                        <% if (bookingbean != null) {
                            for (Courts court : bookingbean.getCourts()) { %>
                                <option value="<%= court.getCourtId() %>"><%= court.getName() %></option>
                        <%  }
                        } %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="start">Startzeit</label>
                    <input type="datetime-local" id="start" name="start" required>
                </div>
                <div class="form-group">
                    <label for="ende">Endzeit</label>
                    <input type="datetime-local" id="ende" name="ende" required>
                </div>
                <button type="submit" class="btn btn-primary">Buchen</button>
            </form>
        </div>

        <div class="card">
            <h2>Meine Buchungen</h2>
            <% 
            if (bookingbean != null && !bookingbean.getBookings().isEmpty()) { 
                // Filter bookings to show only current user's bookings
                String currentUsername = userbean.getUser().getUsername();
                boolean hasUserBookings = false;
                
                for (Booking b : bookingbean.getBookings()) {
                    if (b.getUser().getUsername().equals(currentUsername)) {
                        hasUserBookings = true;
                        break;
                    }
                }
                
                if (hasUserBookings) {
            %>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Platz</th>
                        <th>Start</th>
                        <th>Ende</th>
                        <th>Aktion</th>
                    </tr>
                    <% for (Booking b : bookingbean.getBookings()) { 
                        if (b.getUser().getUsername().equals(currentUsername)) { %>
                        <tr>
                            <td><%= b.getBookingId() %></td>
                            <td><%= b.getCourt().getName() %></td>
                            <td><%= b.getStart().format(fmt) %></td>
                            <td><%= b.getEnde().format(fmt) %></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/BookingServlet?action=delete&bookingId=<%= b.getBookingId() %>" class="btn btn-danger">Loeschen</a>
                            </td>
                        </tr>
                    <% } 
                    } %>
                </table>
            <% } else { %>
                <p>Du hast noch keine Buchungen.</p>
            <% }
            } else { %>
                <p>Du hast noch keine Buchungen.</p>
            <% } %>
        </div>
    </div>
</body>
</html>