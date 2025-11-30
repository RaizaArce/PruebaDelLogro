<%-- 
    Document   : DenunciaEditar
    Created on : 29 nov 2025, 19:23:17
    Author     : raiza
--%>

<%@page import="dao.DenunciaDAO"%>
<%@page import="model.Denuncia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar denuncia</title>
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
    Denuncia d = dao.obtenerPorId(id);
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
            <div class="form-icon">✏️</div>
            <h1 class="form-title">Editar denuncia</h1>
            <p class="form-subtitle">Actualiza la información de la denuncia seleccionada</p>
        </div>

        <form action="DenunciaActualizar.jsp" method="post">
            <input type="hidden" name="id" value="<%= d.getId() %>">

            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Título</label>
                    <input type="text" name="titulo" class="form-input"
                           value="<%= d.getTitulo() %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Descripción</label>
                    <textarea name="descripcion" class="form-textarea" required><%= d.getDescripcion() %></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Ubicación</label>
                        <input type="text" name="ubicacion" class="form-input"
                               value="<%= d.getUbicacion() %>" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Estado</label>
                        <select name="estado" class="form-select" required>
                            <option value="pendiente" <%= "pendiente".equalsIgnoreCase(d.getEstado()) ? "selected" : "" %>>⏳ Pendiente</option>
                            <option value="en proceso" <%= "en proceso".equalsIgnoreCase(d.getEstado()) ? "selected" : "" %>>⚙️ En proceso</option>
                            <option value="resuelto" <%= "resuelto".equalsIgnoreCase(d.getEstado()) ? "selected" : "" %>>✅ Resuelto</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Nombre del ciudadano</label>
                        <input type="text" name="ciudadano" class="form-input"
                               value="<%= d.getCiudadano() %>" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Teléfono de contacto</label>
                        <input type="text" name="telefono" class="form-input"
                               value="<%= d.getTelefonoCiudadano() %>" required>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-submit">💾 Actualizar</button>
                <a href="DenunciasLista.jsp" class="btn-secondary">↩ Volver al listado</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

