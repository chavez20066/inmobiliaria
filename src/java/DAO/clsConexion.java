/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class clsConexion {

    public Connection con;
    //protected Statement stmt;
    /* private String serverName = "localhost";
    private String portNumber = "3306";
    private String databaseName = "textil_db";
    private String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + databaseName;
    private String userName = "root";
    private String password = "root";*/

    //public String errString = "";
    private String serverName = "10.0.2.62";//UCSM00230
    private String portNumber = "1433";
    private String databaseName = "BIBLIO_UCSM";
    private String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + databaseName;
    // String url = "jdbc:sqlserver://UCSM00230;databaseName=BIBLIO_UCSM";
    //admin admin
    private String userName = "admin_sql";
    private String password = "admin_sql4U";

    public Connection ConectarMysql() {
        con = null;
        String url = "jdbc:mysql://localhost:3306/BDINMOBILIARIA";
        try {
            Class.forName("org.gjt.mm.mysql.Driver");
            con = DriverManager.getConnection(url, "root", "root");
            //stmt = con.createStatement();
            System.out.println("Conectado");
        } catch (Exception e) {
            //errString = "Error Mientras se conectaba a la Base de Datos";
            //System.out.println(errString);
            e.printStackTrace();
            return null;
        }
        return con;
    }

    public Connection ConectarPostgres() {
        con = null;
        String url = "jdbc:postgresql://127.0.0.1:5433/BDINMOBILIARIA";
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(url, "postgres", "postgres");
            System.out.println("Conectado");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(clsConexion.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println("Error coonexion: " + ex.getMessage());
            return null;
        }
        return con;
    }

    public Connection Conectar() {
        con = null;
        //String URL_bd = "jdbc:sqlserver://D1360\\SQLEXPRESS;databaseName=BDINMOBILIARIA";
        String URL_bd = "jdbc:sqlserver://UCSM00230;databaseName=BDINMOBILIARIA";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            //con = DriverManager.getConnection(url, userName, password);
            con = DriverManager.getConnection(URL_bd, "admin", "admin");
            //stmt = con.createStatement();
            System.out.println("Conectado");
        } catch (Exception e) {
            //errString = "Error Mientras se conectaba a la Base de Datos";
            System.out.println(e.getMessage());
            e.printStackTrace();
            return null;
        }
        return con;
    }

    public void Desconectar() {
        try {
            //stmt.close();
            con.close();
            System.out.println("Desonectado");
        } catch (SQLException e) {
            //errString = "Error Mientras se Cerraba la Conexion a la Base de Datos";
        }
    }

}
