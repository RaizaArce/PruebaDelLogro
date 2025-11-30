<%-- 
    Document   : Dashboard
    Created on : 29 nov 2025, 21:06:08
    Author     : raiza
--%>

<%@page import="java.util.List"%>
<%@page import="dao.DenunciaDAO"%>
<%@page import="model.Denuncia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Denuncias</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/estilos.css">
    <style>
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .dashboard-header {
            text-align: center;
            margin-bottom: 40px;
            color: #1e293b;
        }
        
        .dashboard-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 700;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            border-left: 4px solid;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        
        .stat-card.total {
            border-left-color: #6366f1;
        }
        
        .stat-card.pendiente {
            border-left-color: #f59e0b;
        }
        
        .stat-card.proceso {
            border-left-color: #3b82f6;
        }
        
        .stat-card.resuelto {
            border-left-color: #10b981;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .stat-value {
            font-size: 3rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 5px;
        }
        
        .stat-description {
            font-size: 0.85rem;
            color: #94a3b8;
        }
        
        .actions-section {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .actions-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }
        
        .action-button {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px 20px;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s;
            border: 2px solid transparent;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .action-button:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        .action-button.secondary {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
        }
        
        .action-button.secondary:hover {
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.4);
        }
        
        .action-button.danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        }
        
        .action-button.danger:hover {
            box-shadow: 0 10px 25px rgba(239, 68, 68, 0.4);
        }
        
        .action-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .action-text {
            font-size: 1.1rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
<%
    // Proteger con login
    if (session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    DenunciaDAO dao = new DenunciaDAO();
    int total = dao.contarFiltrado(null, null, null);

    // Contar por estado
    int totalPend = 0, totalProc = 0, totalRes = 0;
    List<Denuncia> todas = dao.listarFiltradoPaginado(null, null, null, 0, 1000);
    for (Denuncia d : todas) {
        String e = d.getEstado().toLowerCase();
        if (e.contains("pendiente")) totalPend++;
        else if (e.contains("proceso")) totalProc++;
        else if (e.contains("resuelto")) totalRes++;
    }
%>

<div class="dashboard-container">
    <div class="dashboard-header">
        <h1>📊 Dashboard de Denuncias</h1>
        <p style="color: #64748b; font-size: 1.1rem;">Panel de control y estadísticas</p>
    </div>

    <div class="stats-grid">
        <div class="stat-card total">
            <div class="stat-label">Total de Denuncias</div>
            <div class="stat-value"><%= total %></div>
            <div class="stat-description">Registradas en el sistema</div>
        </div>

        <div class="stat-card pendiente">
            <div class="stat-label">Pendientes</div>
            <div class="stat-value"><%= totalPend %></div>
            <div class="stat-description">Esperando atención</div>
        </div>

        <div class="stat-card proceso">
            <div class="stat-label">En Proceso</div>
            <div class="stat-value"><%= totalProc %></div>
            <div class="stat-description">Siendo atendidas</div>
        </div>

        <div class="stat-card resuelto">
            <div class="stat-label">Resueltas</div>
            <div class="stat-value"><%= totalRes %></div>
            <div class="stat-description">Completadas</div>
        </div>
    </div>

    <div class="actions-section">
        <h2 class="actions-title">¿Qué deseas hacer?</h2>
        <div class="actions-grid">
            <a href="index.jsp" class="action-button">
                <div class="action-icon">➕</div>
                <div class="action-text">Registrar Denuncia</div>
            </a>

            <a href="DenunciasLista.jsp" class="action-button secondary">
                <div class="action-icon">📋</div>
                <div class="action-text">Ver Todas las Denuncias</div>
            </a>

            <a href="Logout.jsp" class="action-button danger">
                <div class="action-icon">🚪</div>
                <div class="action-text">Cerrar Sesión</div>
            </a>
        </div>
    </div>
</div>

</body>
</html>