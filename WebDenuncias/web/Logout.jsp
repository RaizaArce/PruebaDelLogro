<%-- 
    Document   : Logout
    Created on : 29 nov 2025, 21:06:35
    Author     : raiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("Login.jsp");
%>

