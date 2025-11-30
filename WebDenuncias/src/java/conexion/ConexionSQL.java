/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author raiza
 */

public class ConexionSQL {

    // Ajustada a tu servidor e instancia
    private static final String URL =
        "jdbc:sqlserver://Raiza\\SqlExpress:1433;databaseName=DenunciasDB;";
    private static final String USER = "sa";
    private static final String PASS = "dba";

    // Cargar el driver una sola vez
    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Método para obtener conexiones
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}

