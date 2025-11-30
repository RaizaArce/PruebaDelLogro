<%-- 
    Document   : Login
    Created on : 29 nov 2025, 21:04:18
    Author     : raiza
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ingreso al sistema</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/estilos.css">
</head>
<body class="login-body">
<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <div class="login-icon">🔐</div>
            <h1 class="login-title">Bienvenido</h1>
            <p class="login-subtitle">Ingresa tus credenciales para continuar</p>
        </div>
        
        <%
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
        <div class="error-message">
            <span class="error-icon">⚠️</span>
            <span>Usuario o contraseña incorrectos</span>
        </div>
        <%
            }
        %>
        
        <form action="LoginProcesar.jsp" method="post">
            <div class="form-group">
                <label class="form-label">Usuario</label>
                <div class="input-icon-wrapper">
                    <span class="input-icon">👤</span>
                    <input type="text" name="usuario" class="form-input with-icon" required 
                           placeholder="Ingresa tu usuario" autocomplete="username">
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">Contraseña</label>
                <div class="input-icon-wrapper">
                    <span class="input-icon">🔒</span>
                    <input type="password" name="clave" id="password" class="form-input with-icon" 
                           required placeholder="Ingresa tu contraseña" autocomplete="current-password">
                    <button type="button" class="password-toggle" onclick="togglePassword()">👁️</button>
                </div>
            </div>
            
            <button type="submit" class="btn-login">Ingresar al Sistema</button>
        </form>
        
        <div class="login-footer">
            Sistema de Gestión de Denuncias
        </div>
    </div>
</div>

<script>
function togglePassword() {
    const passwordInput = document.getElementById('password');
    const toggleButton = document.querySelector('.password-toggle');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        toggleButton.textContent = '👁️‍🗨️';
    } else {
        passwordInput.type = 'password';
        toggleButton.textContent = '👁️';
    }
}
</script>
</body>
</html>
