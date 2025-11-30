<%-- 
    Document   : DenunciaActualizar
    Created on : 29 nov 2025, 19:33:13
    Author     : raiza
--%>

<%@page import="dao.DenunciaDAO"%>
<%@page import="model.Denuncia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Denuncia actualizada</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<%
    if (session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    Denuncia d = new Denuncia();
    d.setId(Integer.parseInt(request.getParameter("id")));
    d.setTitulo(request.getParameter("titulo"));
    d.setDescripcion(request.getParameter("descripcion"));
    d.setUbicacion(request.getParameter("ubicacion"));
    d.setEstado(request.getParameter("estado"));
    d.setCiudadano(request.getParameter("ciudadano"));
    d.setTelefonoCiudadano(request.getParameter("telefono"));

    DenunciaDAO dao = new DenunciaDAO();
    dao.actualizar(d);
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
            <div class="form-icon">✅</div>
            <h1 class="form-title">Denuncia actualizada</h1>
            <p class="form-subtitle">Los datos se han guardado correctamente</p>
        </div>

        <div class="mensaje-exito">
            Denuncia actualizada correctamente.
        </div>

        <div class="form-actions">
            <a href="DenunciasLista.jsp" class="btn-secondary">📋 Volver al listado</a>
        </div>
    </div>
</div>
</body>
</html>

