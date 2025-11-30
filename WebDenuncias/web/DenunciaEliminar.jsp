<%-- 
    Document   : DenunciaEliminar
    Created on : 29 nov 2025, 19:33:33
    Author     : raiza
--%>

<%@page import="dao.DenunciaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Denuncia eliminada</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<%
    if (session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    DenunciaDAO dao = new DenunciaDAO();
    dao.eliminar(id);
%>

<div class="form-container">
    <div class="top-bar">
        <div style="flex:1;"></div>
        <div class="top-actions">
            <a href="Dashboard.jsp" class="btn-top btn-dashboard">📊 Dashboard</a>
            <a href="Logout.jsp" class="btn-top btn-logout">🚪 Cerrar sesión</a>
        </div>
    </div>

    <div class="form-card">
        <div class="form-header">
            <div class="form-icon">🗑️</div>
            <h1 class="form-title">Denuncia eliminada</h1>
            <p class="form-subtitle">La denuncia se ha eliminado del sistema</p>
        </div>

        <div class="mensaje-exito">
            Denuncia eliminada correctamente.
        </div>

        <div class="form-actions">
            <a href="DenunciasLista.jsp" class="btn-secondary">📋 Volver al listado</a>
        </div>
    </div>
</div>
</body>
</html>

