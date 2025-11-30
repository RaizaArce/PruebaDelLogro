<%-- 
    Document   : DenunciasLista
    Created on : 29 nov 2025, 19:23:07
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
    <title>Listado de denuncias</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/estilos.css">
    <style>
        body {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0e7ff 100%);
            min-height: 100vh;
            padding: 20px;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }
        
        .list-container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 16px;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1e293b;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .top-actions {
            display: flex;
            gap: 12px;
        }
        
        .btn-top {
            padding: 10px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s;
            border: 2px solid transparent;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-dashboard {
            background: white;
            color: #667eea;
            border-color: #667eea;
        }
        
        .btn-dashboard:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }
        
        .btn-logout {
            background: #ef4444;
            color: white;
        }
        
        .btn-logout:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        .filter-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 24px;
        }
        
        .filter-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            font-size: 1.3rem;
            font-weight: 700;
            color: #1e293b;
        }
        
        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
        }
        
        .filter-label {
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .filter-input {
            padding: 12px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 0.95rem;
            transition: all 0.3s;
            font-family: inherit;
        }
        
        .filter-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .filter-actions {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
        }
        
        .btn-filter {
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-filter-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }
        
        .btn-filter-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(102, 126, 234, 0.4);
        }
        
        .table-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 16px;
        }
        
        .table-info {
            color: #64748b;
            font-size: 0.95rem;
        }
        
        .btn-new {
            padding: 12px 24px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }
        
        .btn-new:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
        }
        
        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        
        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        thead th {
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: white;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }
        
        tbody tr {
            border-bottom: 1px solid #f1f5f9;
            transition: background 0.2s;
        }
        
        tbody tr:hover {
            background: #f8fafc;
        }
        
        tbody td {
            padding: 16px;
            color: #334155;
            font-size: 0.9rem;
            vertical-align: middle;
        }
        
        .estado-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
            white-space: nowrap;
        }
        
        .estado-pendiente {
            background: #fef3c7;
            color: #92400e;
        }
        
        .estado-proceso {
            background: #dbeafe;
            color: #1e40af;
        }
        
        .estado-resuelto {
            background: #d1fae5;
            color: #065f46;
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        
        .btn-action {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s;
            font-size: 1.2rem;
        }
        
        .btn-edit {
            background: #e0e7ff;
            color: #4f46e5;
        }
        
        .btn-edit:hover {
            background: #4f46e5;
            color: white;
            transform: scale(1.1);
        }
        
        .btn-delete {
            background: #fee2e2;
            color: #dc2626;
        }
        
        .btn-delete:hover {
            background: #dc2626;
            color: white;
            transform: scale(1.1);
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 24px;
            flex-wrap: wrap;
        }
        
        .pagination a {
            padding: 10px 16px;
            background: white;
            color: #667eea;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s;
        }
        
        .pagination a:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
            transform: translateY(-2px);
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #94a3b8;
        }
        
        .empty-icon {
            font-size: 4rem;
            margin-bottom: 16px;
        }
        
        .empty-text {
            font-size: 1.2rem;
            font-weight: 600;
            color: #64748b;
        }
        
        @media (max-width: 768px) {
            .filter-grid {
                grid-template-columns: 1fr;
            }
            
            .table-header {
                flex-direction: column;
                align-items: stretch;
            }
            
            .btn-new {
                width: 100%;
                justify-content: center;
            }
            
            .pagination {
                gap: 6px;
            }
            
            .pagination a {
                padding: 8px 12px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
<%
    if (session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<div class="list-container">
    <div class="top-bar">
        <h1 class="page-title">
            📋 Listado de Denuncias
        </h1>
        <div class="top-actions">
            <a href="Dashboard.jsp" class="btn-top btn-dashboard">
                📊 Dashboard
            </a>
            <a href="Logout.jsp" class="btn-top btn-logout">
                🚪 Cerrar sesión
            </a>
        </div>
    </div>
    
    <div class="filter-card">
        <div class="filter-header">
            🔍 Filtros de búsqueda
        </div>
        <form action="DenunciasLista.jsp" method="get">
            <div class="filter-grid">
                <div class="filter-group">
                    <label class="filter-label">
                        📌 Título
                    </label>
                    <input type="text" name="titulo" class="filter-input"
                           placeholder="Buscar por título..."
                           value="<%= request.getParameter("titulo") != null ? request.getParameter("titulo") : "" %>">
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">
                        👤 Ciudadano
                    </label>
                    <input type="text" name="ciudadano" class="filter-input"
                           placeholder="Buscar por ciudadano..."
                           value="<%= request.getParameter("ciudadano") != null ? request.getParameter("ciudadano") : "" %>">
                </div>
                
                <div class="filter-group">
                    <label class="filter-label">
                        📍 Ubicación
                    </label>
                    <input type="text" name="ubicacion" class="filter-input"
                           placeholder="Buscar por ubicación..."
                           value="<%= request.getParameter("ubicacion") != null ? request.getParameter("ubicacion") : "" %>">
                </div>
            </div>
            
            <div class="filter-actions">
                <button type="submit" class="btn-filter btn-filter-primary">
                    🔎 Aplicar Filtros
                </button>
            </div>
        </form>
    </div>

    <%
        String titulo = request.getParameter("titulo");
        String ciudadano = request.getParameter("ciudadano");
        String ubicacion = request.getParameter("ubicacion");

        int pagina = 1;
        int tamPagina = 10;
        try {
            if (request.getParameter("pagina") != null) {
                pagina = Integer.parseInt(request.getParameter("pagina"));
                if (pagina < 1) pagina = 1;
            }
        } catch (NumberFormatException e) {
            pagina = 1;
        }
        int offset = (pagina - 1) * tamPagina;

        DenunciaDAO dao = new DenunciaDAO();
        int totalRegistros = dao.contarFiltrado(titulo, ciudadano, ubicacion);
        int totalPaginas = (int) Math.ceil((double) totalRegistros / tamPagina);
        if (totalPaginas == 0) totalPaginas = 1;

        List<Denuncia> lista = dao.listarFiltradoPaginado(titulo, ciudadano, ubicacion, offset, tamPagina);
    %>

    <div class="table-card">
        <div class="table-header">
            <div class="table-info">
                📊 <strong><%= totalRegistros %></strong> registros encontrados | 
                Página <strong><%= pagina %></strong> de <strong><%= totalPaginas %></strong>
            </div>
            <a href="index.jsp" class="btn-new">
                ➕ Nueva Denuncia
            </a>
        </div>
        
        <% if (lista.isEmpty()) { %>
            <div class="empty-state">
                <div class="empty-icon">🔍</div>
                <div class="empty-text">No se encontraron denuncias</div>
                <p style="color: #94a3b8; margin-top: 8px;">
                    Intenta ajustar los filtros de búsqueda o registra una nueva denuncia
                </p>
            </div>
        <% } else { %>
            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Título</th>
                        <th>Descripción</th>
                        <th>Ubicación</th>
                        <th>Estado</th>
                        <th>Ciudadano</th>
                        <th>Teléfono</th>
                        <th>Fecha</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Denuncia d : lista) {
                            String estado = d.getEstado();
                            String claseEstado =
                                "pendiente".equalsIgnoreCase(estado) ? "estado-pendiente" :
                                "en proceso".equalsIgnoreCase(estado) ? "estado-proceso" :
                                "estado-resuelto";
                    %>
                    <tr>
                        <td><strong>#<%= d.getId() %></strong></td>
                        <td><%= d.getTitulo() %></td>
                        <td><%= d.getDescripcion() %></td>
                        <td><%= d.getUbicacion() %></td>
                        <td>
                            <span class="estado-badge <%= claseEstado %>">
                                <%= d.getEstado() %>
                            </span>
                        </td>
                        <td><%= d.getCiudadano() %></td>
                        <td><%= d.getTelefonoCiudadano() %></td>
                        <td><%= d.getFechaRegistro() %></td>
                        <td>
                            <div class="action-buttons">
                                <a href="DenunciaEditar.jsp?id=<%= d.getId() %>"
                                   class="btn-action btn-edit"
                                   title="Editar">✏️</a>
                                <a href="DenunciaEliminar.jsp?id=<%= d.getId() %>"
                                   class="btn-action btn-delete"
                                   title="Eliminar"
                                   onclick="return confirm('¿Está seguro de eliminar esta denuncia?');">🗑️</a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <%
                String params = "";
                if (titulo != null && !titulo.trim().isEmpty()) {
                    params += "&titulo=" + java.net.URLEncoder.encode(titulo, "UTF-8");
                }
                if (ciudadano != null && !ciudadano.trim().isEmpty()) {
                    params += "&ciudadano=" + java.net.URLEncoder.encode(ciudadano, "UTF-8");
                }
                if (ubicacion != null && !ubicacion.trim().isEmpty()) {
                    params += "&ubicacion=" + java.net.URLEncoder.encode(ubicacion, "UTF-8");
                }
            %>

            <div class="pagination">
                <% if (pagina > 1) { %>
                    <a href="DenunciasLista.jsp?pagina=1<%= params %>">⏮️ Primera</a>
                    <a href="DenunciasLista.jsp?pagina=<%= (pagina - 1) %><%= params %>">⬅️ Anterior</a>
                <% } %>
                <span style="color: #64748b; font-weight: 600; padding: 0 8px;">
                    Página <%= pagina %> de <%= totalPaginas %>
                </span>
                <% if (pagina < totalPaginas) { %>
                    <a href="DenunciasLista.jsp?pagina=<%= (pagina + 1) %><%= params %>">Siguiente ➡️</a>
                    <a href="DenunciasLista.jsp?pagina=<%= totalPaginas %><%= params %>">Última ⏭️</a>
                <% } %>
            </div>
        <% } %>
    </div>
</div>
</body>
</html>