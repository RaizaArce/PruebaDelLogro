/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import conexion.ConexionSQL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Denuncia;

/**
 *
 * @author raiza
 */


public class DenunciaDAO {

    // INSERTAR
    public void insertar(Denuncia d) {
        String sql = "INSERT INTO denuncias " +
                     "(titulo, descripcion, ubicacion, estado, ciudadano, telefono_ciudadano) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionSQL.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, d.getTitulo());
            ps.setString(2, d.getDescripcion());
            ps.setString(3, d.getUbicacion());
            ps.setString(4, d.getEstado());
            ps.setString(5, d.getCiudadano());
            ps.setString(6, d.getTelefonoCiudadano());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // LISTAR TODAS
    public List<Denuncia> listar() {
        List<Denuncia> lista = new ArrayList<>();
        String sql = "SELECT * FROM denuncias ORDER BY fecha_registro DESC";

        try (Connection con = ConexionSQL.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Denuncia d = new Denuncia();
                d.setId(rs.getInt("id"));
                d.setTitulo(rs.getString("titulo"));
                d.setDescripcion(rs.getString("descripcion"));
                d.setUbicacion(rs.getString("ubicacion"));
                d.setEstado(rs.getString("estado"));
                d.setCiudadano(rs.getString("ciudadano"));
                d.setTelefonoCiudadano(rs.getString("telefono_ciudadano"));
                d.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                lista.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    // OBTENER POR ID
    public Denuncia obtenerPorId(int id) {
        Denuncia d = null;
        String sql = "SELECT * FROM denuncias WHERE id = ?";

        try (Connection con = ConexionSQL.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    d = new Denuncia();
                    d.setId(rs.getInt("id"));
                    d.setTitulo(rs.getString("titulo"));
                    d.setDescripcion(rs.getString("descripcion"));
                    d.setUbicacion(rs.getString("ubicacion"));
                    d.setEstado(rs.getString("estado"));
                    d.setCiudadano(rs.getString("ciudadano"));
                    d.setTelefonoCiudadano(rs.getString("telefono_ciudadano"));
                    d.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return d;
    }

    // ACTUALIZAR
    public void actualizar(Denuncia d) {
        String sql = "UPDATE denuncias SET " +
                     "titulo = ?, descripcion = ?, ubicacion = ?, estado = ?, " +
                     "ciudadano = ?, telefono_ciudadano = ? " +
                     "WHERE id = ?";

        try (Connection con = ConexionSQL.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, d.getTitulo());
            ps.setString(2, d.getDescripcion());
            ps.setString(3, d.getUbicacion());
            ps.setString(4, d.getEstado());
            ps.setString(5, d.getCiudadano());
            ps.setString(6, d.getTelefonoCiudadano());
            ps.setInt(7, d.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ELIMINAR
    public void eliminar(int id) {
        String sql = "DELETE FROM denuncias WHERE id = ?";

        try (Connection con = ConexionSQL.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // LISTAR CON FILTROS (titulo, ciudadano, ubicacion)
public List<Denuncia> listarFiltrado(String titulo, String ciudadano, String ubicacion) {
    List<Denuncia> lista = new ArrayList<>();

    String sql = "SELECT * FROM denuncias WHERE 1=1 ";
    if (titulo != null && !titulo.trim().isEmpty()) {
        sql += "AND titulo LIKE ? ";
    }
    if (ciudadano != null && !ciudadano.trim().isEmpty()) {
        sql += "AND ciudadano LIKE ? ";
    }
    if (ubicacion != null && !ubicacion.trim().isEmpty()) {
        sql += "AND ubicacion LIKE ? ";
    }
    sql += "ORDER BY fecha_registro DESC";

    try (Connection con = ConexionSQL.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        int idx = 1;
        if (titulo != null && !titulo.trim().isEmpty()) {
            ps.setString(idx++, "%" + titulo + "%");
        }
        if (ciudadano != null && !ciudadano.trim().isEmpty()) {
            ps.setString(idx++, "%" + ciudadano + "%");
        }
        if (ubicacion != null && !ubicacion.trim().isEmpty()) {
            ps.setString(idx++, "%" + ubicacion + "%");
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Denuncia d = new Denuncia();
                d.setId(rs.getInt("id"));
                d.setTitulo(rs.getString("titulo"));
                d.setDescripcion(rs.getString("descripcion"));
                d.setUbicacion(rs.getString("ubicacion"));
                d.setEstado(rs.getString("estado"));
                d.setCiudadano(rs.getString("ciudadano"));
                d.setTelefonoCiudadano(rs.getString("telefono_ciudadano"));
                d.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                lista.add(d);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

        return lista;
    }

    // LISTAR CON FILTROS Y PAGINACIÓN
public List<Denuncia> listarFiltradoPaginado(String titulo, String ciudadano,
                                             String ubicacion, int offset, int limit) {
    List<Denuncia> lista = new ArrayList<>();

    String sql = "SELECT * FROM denuncias WHERE 1=1 ";
    if (titulo != null && !titulo.trim().isEmpty()) {
        sql += "AND titulo LIKE ? ";
    }
    if (ciudadano != null && !ciudadano.trim().isEmpty()) {
        sql += "AND ciudadano LIKE ? ";
    }
    if (ubicacion != null && !ubicacion.trim().isEmpty()) {
        sql += "AND ubicacion LIKE ? ";
    }
    sql += "ORDER BY fecha_registro DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try (Connection con = ConexionSQL.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        int idx = 1;
        if (titulo != null && !titulo.trim().isEmpty()) {
            ps.setString(idx++, "%" + titulo + "%");
        }
        if (ciudadano != null && !ciudadano.trim().isEmpty()) {
            ps.setString(idx++, "%" + ciudadano + "%");
        }
        if (ubicacion != null && !ubicacion.trim().isEmpty()) {
            ps.setString(idx++, "%" + ubicacion + "%");
        }

        ps.setInt(idx++, offset);
        ps.setInt(idx, limit);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Denuncia d = new Denuncia();
                d.setId(rs.getInt("id"));
                d.setTitulo(rs.getString("titulo"));
                d.setDescripcion(rs.getString("descripcion"));
                d.setUbicacion(rs.getString("ubicacion"));
                d.setEstado(rs.getString("estado"));
                d.setCiudadano(rs.getString("ciudadano"));
                d.setTelefonoCiudadano(rs.getString("telefono_ciudadano"));
                d.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                lista.add(d);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return lista;
}

    // CONTAR TOTAL DE REGISTROS CON FILTROS
public int contarFiltrado(String titulo, String ciudadano, String ubicacion) {
    int total = 0;

    String sql = "SELECT COUNT(*) FROM denuncias WHERE 1=1 ";
    if (titulo != null && !titulo.trim().isEmpty()) {
        sql += "AND titulo LIKE ? ";
    }
    if (ciudadano != null && !ciudadano.trim().isEmpty()) {
        sql += "AND ciudadano LIKE ? ";
    }
    if (ubicacion != null && !ubicacion.trim().isEmpty()) {
        sql += "AND ubicacion LIKE ? ";
    }

    try (Connection con = ConexionSQL.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        int idx = 1;
        if (titulo != null && !titulo.trim().isEmpty()) {
            ps.setString(idx++, "%" + titulo + "%");
        }
        if (ciudadano != null && !ciudadano.trim().isEmpty()) {
            ps.setString(idx++, "%" + ciudadano + "%");
        }
        if (ubicacion != null && !ubicacion.trim().isEmpty()) {
            ps.setString(idx++, "%" + ubicacion + "%");
        }

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return total;
}



}

