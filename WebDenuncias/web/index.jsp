<%-- 
    Document   : index
    Created on : 29 nov 2025, 19:22:43
    Author     : raiza
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar denuncia</title>
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<%
    if (session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<div class="form-container">
    <div class="top-bar">
        <div style="flex: 1;"></div>
        <div class="top-actions">
            <a href="Dashboard.jsp" class="btn-top btn-dashboard">
                📊 Dashboard
            </a>
            <a href="Logout.jsp" class="btn-top btn-logout">
                🚪 Cerrar sesión
            </a>
        </div>
    </div>
    
    <div class="form-card">
        <div class="form-header">
            <div class="form-icon">📝</div>
            <h1 class="form-title">Nueva Denuncia</h1>
            <p class="form-subtitle">Complete el formulario para registrar una denuncia ciudadana</p>
        </div>
        
        <div class="info-box">
            <span class="info-icon">ℹ️</span>
            <div class="info-text">
                Todos los campos marcados con <span class="required-mark">*</span> son obligatorios. 
                Asegúrese de proporcionar información precisa y detallada.
            </div>
        </div>
        
        <form action="DenunciaGuardar.jsp" method="post">
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">
                        <span class="label-icon">📌</span>
                        Título <span class="required-mark">*</span>
                    </label>
                    <input type="text" name="titulo" class="form-input" required 
                           placeholder="Resumen breve de la denuncia">
                </div>
                
                <div class="form-group">
                    <label class="form-label">
                        <span class="label-icon">📄</span>
                        Descripción <span class="required-mark">*</span>
                    </label>
                    <textarea name="descripcion" class="form-textarea" required 
                              placeholder="Describa detalladamente la situación o problema reportado..."></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            <span class="label-icon">📍</span>
                            Ubicación <span class="required-mark">*</span>
                        </label>
                        <input type="text" name="ubicacion" class="form-input" required 
                               placeholder="Dirección o referencia del lugar">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <span class="label-icon">🔄</span>
                            Estado <span class="required-mark">*</span>
                        </label>
                        <select name="estado" class="form-select" required>
                            <option value="pendiente" selected>⏳ Pendiente</option>
                            <option value="en proceso">⚙️ En proceso</option>
                            <option value="resuelto">✅ Resuelto</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">
                            <span class="label-icon">👤</span>
                            Nombre del ciudadano <span class="required-mark">*</span>
                        </label>
                        <input type="text" name="ciudadano" class="form-input" required 
                               placeholder="Nombre completo del denunciante">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">
                            <span class="label-icon">📞</span>
                            Teléfono de contacto <span class="required-mark">*</span>
                        </label>
                        <input type="tel" name="telefono" class="form-input" required 
                               placeholder="Número de teléfono">
                    </div>
                </div>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn-submit">
                    💾 Guardar Denuncia
                </button>
                <a href="DenunciasLista.jsp" class="btn-secondary">
                    📋 Ver Todas las Denuncias
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
