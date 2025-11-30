<%-- 
    Document   : LoginProcesar
    Created on : 29 nov 2025, 21:04:47
    Author     : raiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String usuario = request.getParameter("usuario");
    String clave   = request.getParameter("clave");

    if ("admin".equals(usuario) && "1234".equals(clave)) {
        session.setAttribute("usuarioLogueado", usuario);
        response.sendRedirect("Dashboard.jsp");
    } else {
        response.sendRedirect("Login.jsp?error=1");
    }
%>
sip

