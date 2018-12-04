/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import VO.Asesor;
import VO.Candidato;
import VO.Cliente;
import VO.Egreso;
import VO.Etapa;
import VO.Localidad;
import VO.Manzana;
import VO.Pago;
import VO.PagosServicios;
import VO.PagosUnicos;
import VO.SubTipoEgreso;
import VO.Terreno;
import VO.TipoEgreso;
import VO.Usuario;
import VO.Venta;
import VO.Visita;
import VO.cuota;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//import java.time.Clock;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

/**
 *
 * @author jbasurco
 */
public class CRUD {

    private clsConexion varClsConexion;
    private Statement stmt;
    private ResultSet varResultado;
    private Connection con;

    //private Docente varDocente=null;
    public CRUD() {
        varClsConexion = new clsConexion();
        //varDocente=new Docente();
    }

    public Connection getConexion() {
        return varClsConexion.con;
    }

    public void abrirConsulta() throws SQLException {
        if (stmt == null) {
            stmt = varClsConexion.ConectarMysql().createStatement();
        }
    }

    public void cerrarConsulta() throws SQLException {
        if (varResultado != null) {
            varResultado.close();
            varResultado = null;
        }
        if (stmt != null) {
            stmt.close();
            stmt = null;
        }

        if (varClsConexion != null) {
            varClsConexion.Desconectar();
        }

    }

    public JSONObject getLista() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT * FROM usuario WHERE estado=1 ORDER BY idUsuario desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));
                varJsonObjectP.put("nombre", varResultado.getString("nombre"));
                varJsonObjectP.put("apellidos", varResultado.getString("apellidos"));
                varJsonObjectP.put("dni", varResultado.getString("dni"));
                varJsonObjectP.put("estado", varResultado.getString("estado"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public JSONObject getListaCandidatos() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT * FROM CANDIDATO WHERE ESTADO=1 ORDER BY COD_CANDIDATO desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_candidato", varResultado.getInt("cod_candidato"));
                varJsonObjectP.put("nombres", varResultado.getString("nombres"));
                varJsonObjectP.put("apellidos", varResultado.getString("apellidos"));
                varJsonObjectP.put("direccion", varResultado.getString("direccion"));
                varJsonObjectP.put("dni", varResultado.getString("dni"));
                varJsonObjectP.put("telefono", varResultado.getString("telefono"));
                varJsonObjectP.put("celular", varResultado.getString("celular"));
                /*varJsonObjectP.put("estado", varResultado.getString("estado"));*/
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public JSONObject GetDatosIniciales() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "select idDepartamento,Departamento from Departamentos order by Departamento";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("idDepartamento", varResultado.getString("idDepartamento"));
                varJsonObjectP.put("Departamento", varResultado.getString("Departamento"));
                varJsonArrayP.add(varJsonObjectP);
            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("Departamentos", varJsonArrayP);
            cerrarConsulta();
            varJsonObjectResultado.put("Facultades", GetFacultades());
            varJsonObjectResultado.put("Grados", GetGrados());
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public JSONArray GetGrados() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();

        try {
            String varSql = "select distinct idPrograma,UPPER(grado) as grado from dbo.ProgramasCybertesis where EstadoGrado='A' and idPrograma!='00' and idPrograma!='xx' and grado is not null and grado!='Sin Grado'  group by idPrograma,grado order by grado;";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("idPrograma", varResultado.getString("idPrograma"));
                varJsonObjectP.put("grado", varResultado.getString("grado"));
                varJsonArrayP.add(varJsonObjectP);
            }

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.GetGrados()" + e.getMessage());
        }
        return varJsonArrayP;
    }

    public JSONObject GetDatosDocentes() throws SQLException {

        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "select distinct codigoDocente,ISNULL(ApellidoPaterno, '') +' '+ ISNULL(ApellidoMaterno, '') +' '+ ISNULL(Nombres, '') as Docente from  docentes\n"
                    + "where len(codigoDocente)=4 and codigoDocente is not null order by codigoDocente,Docente";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);

            while (varResultado.next()) {

                String docente = varResultado.getString("Docente") + "|" + varResultado.getString("codigoDocente");
                varJsonObjectResultado.put(docente, "");
            }

            cerrarConsulta();
        } catch (SQLException e) {
            System.out.println("DAO.CRUD.GetDatosDocentes()" + e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public JSONObject GetDepartamentos() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "select idDepartamento,Departamento from Departamentos order by Departamento";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("idDepartamento", varResultado.getString("idDepartamento"));
                varJsonObjectP.put("Departamento", varResultado.getString("Departamento"));
                varJsonArrayP.add(varJsonObjectP);
            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("Records", varJsonArrayP);
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        cerrarConsulta();
        return varJsonObjectResultado;
    }

    public JSONArray GetFacultades() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();

        try {
            String varSql = "select IdFacultad,Facultad from Facultades order by Facultad;";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("IdFacultad", varResultado.getString("IdFacultad"));
                varJsonObjectP.put("Facultad", varResultado.getString("Facultad"));
                varJsonArrayP.add(varJsonObjectP);
            }

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.GetFacultades()" + e.getMessage());
        }
        return varJsonArrayP;
    }

    public JSONObject GetProvincias(String idDepartamento) throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "select idProvincia,Provincia from Provincias where idDepartamento=" + idDepartamento + " order by Provincia;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("idProvincia", varResultado.getString("idProvincia"));
                varJsonObjectP.put("Provincia", varResultado.getString("Provincia"));
                varJsonArrayP.add(varJsonObjectP);
            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("Records", varJsonArrayP);
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        cerrarConsulta();
        return varJsonObjectResultado;
    }

    public JSONObject GetDistritos(String idProvincia, String idDepartamento) throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "select idDistrito,Distrito from distritos where idProvincia=" + idProvincia + " and idDepartamento=" + idDepartamento + " order by Distrito;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("idDistrito", varResultado.getString("idDistrito"));
                varJsonObjectP.put("Distrito", varResultado.getString("Distrito"));
                varJsonArrayP.add(varJsonObjectP);
            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("Records", varJsonArrayP);
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        cerrarConsulta();
        return varJsonObjectResultado;
    }

    public JSONObject GetEscuelas(String idFacultad) throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "select idPrograma,ProgProf from programas where estado='A' and idFacultad='" + idFacultad + "' order by ProgProf;";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("idPrograma", varResultado.getString("idPrograma"));
                varJsonObjectP.put("ProgProf", varResultado.getString("ProgProf"));
                varJsonArrayP.add(varJsonObjectP);
            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("Records", varJsonArrayP);
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        cerrarConsulta();
        return varJsonObjectResultado;
    }

    /*public Usuario VerificaUsuario(String CodigoUsuario) throws SQLException {
        Usuario varUsuario = new Usuario();
        try {
            // String varSql = "SELECT CodigoDocente,ApellidoPaterno,ApellidoMaterno,Nombres FROM sis_biblio_docentes ";
            String varSql = "SELECT COD_USUARIO,APELLIDO_PATERNO,APELLIDO_MATERNO,NOMBRES,CONTRASENIA,TIPO_USUARIO FROM USUARIO\n"
                    + " where COD_USUARIO='" + CodigoUsuario + "';";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            //[CodigoDocente]      ,[ApellidoPaterno]      ,[ApellidoMaterno]      ,[Nombres]
            while (varResultado.next()) {
                varUsuario.setCOD_USUARIO(varResultado.getString("COD_USUARIO").trim());
                varUsuario.setAPELLIDO_PATERNO(varResultado.getString("APELLIDO_PATERNO"));
                varUsuario.setAPELLIDO_MATERNO(varResultado.getString("APELLIDO_MATERNO"));
                varUsuario.setNOMBRES(varResultado.getString("NOMBRES"));
                varUsuario.setCONTRASENIA(varResultado.getString("CONTRASENIA"));
                varUsuario.setTIPO_USUARIO(varResultado.getInt("TIPO_USUARIO"));
            }

        } catch (SQLException e) {
        }
        cerrarConsulta();
        return varUsuario;
    }*/
    public String GetFecha() {

        String fecha = null;
        try {
            // myconexion = new Conexion();
            abrirConsulta();
            String sql = "SELECT Convert(NChar(10), GetDate(), 120) as FECHA";

            varResultado = stmt.executeQuery(sql);
            //System.out.println(sql);
            if (varResultado.next()) {
                fecha = varResultado.getString("FECHA");
            }
            cerrarConsulta();
            return fecha;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fecha;
    }

    public String[] GetFechaHora() {

        String fechaHora[] = null;
        try {
            // myconexion = new Conexion();
            abrirConsulta();
            // String sql = "select CONVERT(VARCHAR,GETDATE(),120) as FECHAHORA";
            String sql = "SELECT CONVERT(VARCHAR(30), GETDATE(), 111) +' '+ CONVERT(VARCHAR(30), GETDATE(), 108) as FECHAHORA, year(GETDATE()) as ANIO, convert(varchar(10),getdate(),111) AS FECHA";

            varResultado = stmt.executeQuery(sql);
            //System.out.println(sql);
            if (varResultado.next()) {
                fechaHora = new String[3];
                fechaHora[0] = varResultado.getString("FECHAHORA");
                fechaHora[1] = varResultado.getString("ANIO");
                fechaHora[2] = varResultado.getString("FECHA");
            }
            cerrarConsulta();
            return fechaHora;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return fechaHora;
    }

    public String pObtenerTipoSemestre() {
        try {
            abrirConsulta();
            CallableStatement cmst;
            cmst = varClsConexion.con.prepareCall("{ call SPObtenerTipoSemestre(?) }");

            // parametros de salida
            cmst.registerOutParameter(1, java.sql.Types.NVARCHAR);

            cmst.execute();
            String semestreTipo = cmst.getString(1);
            cerrarConsulta();
            return semestreTipo;

        } catch (SQLException e) {;
            return null;
        }
    }

    public JSONObject GetLista(String CodDocente) throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "select distinct sbca.CodigoPlan,sbca.CodigoAsignatura,sba.Nombre,p.ProgProf,sbca.NombreGrupo,sbca.FechaInicio,\n"
                    + "sbca.FechaFin,sba.Semestre,sba.CodigoDeparamento,sbca.semestre as TipoSemestre \n"
                    + "from SisBiblio_CargaAcademica sbca inner join SisBiblio_Asignaturas sba \n"
                    + "on sbca.codigoAsignatura=sba.codigo \n"
                    + "inner join Programas p\n"
                    + "on substring(sbca.CodigoPlan,0,3)=p.idPrograma\n"
                    + "where sbca.CodigoDocente='" + CodDocente + "' order by TipoSemestre;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("CodigoPlan", varResultado.getString("CodigoPlan"));
                varJsonObjectP.put("CodigoAsignatura", varResultado.getString("CodigoAsignatura"));
                varJsonObjectP.put("Nombre", varResultado.getString("Nombre"));
                varJsonObjectP.put("ProgProf", varResultado.getString("ProgProf"));
                varJsonObjectP.put("NombreGrupo", varResultado.getString("NombreGrupo"));
                varJsonObjectP.put("FechaInicio", varResultado.getString("FechaInicio"));
                varJsonObjectP.put("FechaFin", varResultado.getString("FechaFin"));
                varJsonObjectP.put("Semestre", varResultado.getString("Semestre"));
                varJsonObjectP.put("CodigoDeparamento", varResultado.getString("CodigoDeparamento"));
                varJsonObjectP.put("TipoSemestre", varResultado.getString("TipoSemestre"));

                varJsonArrayP.add(varJsonObjectP);
            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("Records", varJsonArrayP);
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        cerrarConsulta();
        return varJsonObjectResultado;
    }

    public JSONObject GetListaUsuarios() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "select * from usuarios";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                varJsonObjectP.put("idusuario", varResultado.getInt("idusuario"));
                varJsonObjectP.put("nombre", varResultado.getString("nombre"));
                varJsonObjectP.put("apellidos", varResultado.getString("apellidos"));
                varJsonObjectP.put("dni", varResultado.getString("dni"));
                varJsonObjectP.put("estado", varResultado.getString("estado"));

                varJsonArrayP.add(varJsonObjectP);
            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        cerrarConsulta();
        return varJsonObjectResultado;
    }

    public String ObtenerId() {
        try {
            abrirConsulta();
            CallableStatement cmst;
            cmst = varClsConexion.con.prepareCall("{ call SPObtenerIdAutCyber(?) }");

            // parametros de salida
            cmst.registerOutParameter(1, java.sql.Types.NVARCHAR);

            cmst.execute();
            String IdAutorizacion = cmst.getString(1);
            cerrarConsulta();
            return IdAutorizacion;

        } catch (SQLException e) {;
            return null;
        }
    }

    public JSONObject GetDatosAlumno(String CodigoAlumno) throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        //JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            //String varSql = "select codigo,dni,datos,cod_prog,programa,direccion,tel_fij,celular,email from maestroBiblio where codigo='" + CodigoAlumno + "';";
            String varSql = "select codigo,dni,datos,cod_prog,programa,direccion,tel_fij,celular,email,p.idFacultad from maestroBiblio mb\n"
                    + "inner join programas p\n"
                    + "on mb.cod_prog=p.idPrograma\n"
                    + "where mb.codigo='" + CodigoAlumno + "';";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            int count = 0;
            while (varResultado.next()) {
                count++;
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                String[] datosCompletos = varResultado.getString("datos").split("/");
                String ApellidoPaterno, ApellidoMaterno, nombres, Completos;
                if (datosCompletos.length > 0) {
                    if (datosCompletos.length == 1) {
                        Completos = datosCompletos[0];
                        varJsonObjectP.put("apellidos", Completos);
                        varJsonObjectP.put("nombres", "");
                    }
                    if (datosCompletos.length == 2) {
                        ApellidoPaterno = datosCompletos[0];
                        nombres = datosCompletos[1];
                        varJsonObjectP.put("apellidos", ApellidoPaterno);
                        varJsonObjectP.put("nombres", nombres);
                    }
                    if (datosCompletos.length == 3) {
                        ApellidoPaterno = datosCompletos[0];
                        ApellidoMaterno = datosCompletos[1];
                        nombres = datosCompletos[2];
                        varJsonObjectP.put("apellidos", ApellidoPaterno + " " + ApellidoMaterno);
                        varJsonObjectP.put("nombres", nombres);
                    }

                }
                varJsonObjectP.put("codigo", varResultado.getString("codigo"));
                varJsonObjectP.put("dni", varResultado.getString("dni"));
                varJsonObjectP.put("idEscuela", varResultado.getString("cod_prog"));
                varJsonObjectP.put("escuela", varResultado.getString("programa"));
                varJsonObjectP.put("direccion", varResultado.getString("direccion"));
                varJsonObjectP.put("tel_fij", varResultado.getString("tel_fij"));
                varJsonObjectP.put("celular", varResultado.getString("celular"));
                varJsonObjectP.put("email", varResultado.getString("email"));
                varJsonObjectP.put("idFacultad", varResultado.getString("idFacultad"));

            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("Contador", count);
            varJsonObjectResultado.put("Records", varJsonObjectP);

        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        cerrarConsulta();
        return varJsonObjectResultado;

    }

    public int existe_usuario(String dni) throws SQLException {
        int total = 0;
        try {

            String varSql = "SELECT count(*) as total FROM usuario WHERE dni='" + dni + "';";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                //varJsonObjectP.put("Id", varResultado.getInt("Id"));
                total = varResultado.getInt("total");

            }

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.existe_usuario()" + e.getMessage());
        }
        cerrarConsulta();
        return total;

    }

    public int registrarCandidato(Candidato miCandidato) throws SQLException {

        //stmt.executeUpdate(sql);
        try {
            String varSql = "INSERT into CANDIDATO(APELLIDOS,NOMBRES,DIRECCION,DNI,TELEFONO,CELULAR,ESTADO,COD_ASESOR) values('" + miCandidato.getApellidos() + "','" + miCandidato.getNombres()
                    + "','" + miCandidato.getDireccion() + "','" + miCandidato.getDni() + "','" + miCandidato.getTelefono()
                    + "','" + miCandidato.getCelular() + "','1','" + 1 + "');";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarCandidato()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;

    }

    public int modificarCandidato(Candidato miCandidato, String cod_candidato) throws SQLException {
        try {
            String varSql = "UPDATE CANDIDATO SET APELLIDOS='" + miCandidato.getApellidos() + "',NOMBRES='" + miCandidato.getNombres() + "',"
                    + "DIRECCION='" + miCandidato.getDireccion() + "',DNI='" + miCandidato.getDni() + "',TELEFONO='" + miCandidato.getTelefono()
                    + "',CELULAR='" + miCandidato.getCelular() + "' WHERE COD_CANDIDATO=" + cod_candidato + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrar()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarCandidato(String cod_candidato) throws SQLException {
        try {
            //String varSql = "UPDATE CANDIDATO SET estado='false' WHERE COD_CANDIDATO=" + cod_candidato + ";";
            String varSql = "DELETE FROM CANDIDATO WHERE COD_CANDIDATO=" + cod_candidato + ";";
            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarCandidato()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getListaAsesor() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT * FROM ASESOR WHERE ESTADO=1 ORDER BY COD_ASESOR desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_asesor", varResultado.getInt("cod_asesor"));
                varJsonObjectP.put("nombres", varResultado.getString("nombres"));
                varJsonObjectP.put("apellidos", varResultado.getString("apellidos"));
                varJsonObjectP.put("direccion", varResultado.getString("direccion"));
                varJsonObjectP.put("dni", varResultado.getString("dni"));
                varJsonObjectP.put("telefono", varResultado.getString("telefono"));
                varJsonObjectP.put("celular", varResultado.getString("celular"));
                /*varJsonObjectP.put("estado", varResultado.getString("estado"));*/
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public int registrarAsesor(Asesor miAsesor) throws SQLException {

        //stmt.executeUpdate(sql);
        try {
            String varSql = "INSERT into ASESOR(APELLIDOS,NOMBRES,DIRECCION,DNI,TELEFONO,CELULAR,ESTADO) values('" + miAsesor.getApellidos() + "','" + miAsesor.getNombres()
                    + "','" + miAsesor.getDireccion() + "','" + miAsesor.getDni() + "','" + miAsesor.getTelefono()
                    + "','" + miAsesor.getCelular() + "','1');";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarAsesor()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;

    }

    public int modificarAsesor(Asesor miAsesor, String cod_asesor) throws SQLException {
        try {
            String varSql = "UPDATE ASESOR SET APELLIDOS='" + miAsesor.getApellidos() + "',NOMBRES='" + miAsesor.getNombres() + "',"
                    + "DIRECCION='" + miAsesor.getDireccion() + "',DNI='" + miAsesor.getDni() + "',TELEFONO='" + miAsesor.getTelefono()
                    + "',CELULAR='" + miAsesor.getCelular() + "' WHERE COD_ASESOR=" + cod_asesor + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarAsesor()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarAsesor(String cod_asesor) throws SQLException {
        try {
            // String varSql = "UPDATE ASESOR SET estado='false' WHERE COD_ASESOR=" + cod_asesor + ";";
            String varSql = "DELETE FROM ASESOR WHERE COD_ASESOR=" + cod_asesor + ";";
            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarAsesor()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getListaVisitas() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT V.COD_VISITA,L.LOCALIDAD,E.ETAPA,C.COD_CANDIDATO,C.APELLIDOS AS C_APELLIDOS,C.NOMBRES AS C_NOMBRES,"
                    + "A.COD_ASESOR,A.APELLIDOS AS A_APELLIDOS,A.NOMBRES AS A_NOMBRES,V.FECHA_TENTATIVA,V.NOTA,V.ESTADO FROM VISITA V INNER JOIN LOCALIDAD L \n"
                    + "ON V.LOCALIDAD=L.LOCALIDAD\n"
                    + "INNER JOIN ETAPA E\n"
                    + "ON V.ETAPA=E.ETAPA\n"
                    + "INNER JOIN CANDIDATO C\n"
                    + "ON V.COD_CANDIDATO=C.COD_CANDIDATO\n"
                    + "INNER JOIN ASESOR A\n"
                    + "ON V.COD_ASESOR=A.COD_ASESOR WHERE V.ESTADO_VISITA='1'"
                    + "ORDER BY V.COD_ASESOR desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_visita", varResultado.getInt("cod_visita"));
                // varJsonObjectP.put("cod_localidad", varResultado.getString("cod_localidad"));
                varJsonObjectP.put("localidad", varResultado.getString("localidad"));
                //varJsonObjectP.put("cod_etapa", varResultado.getString("cod_etapa"));
                varJsonObjectP.put("etapa", varResultado.getString("etapa"));
                varJsonObjectP.put("cod_candidato", varResultado.getString("cod_candidato"));
                varJsonObjectP.put("c_apellidos", varResultado.getString("c_apellidos"));
                varJsonObjectP.put("c_nombres", varResultado.getString("c_nombres"));
                varJsonObjectP.put("candidato", varResultado.getString("c_apellidos") + " " + varResultado.getString("c_nombres"));
                varJsonObjectP.put("a_apellidos", varResultado.getString("a_apellidos"));
                varJsonObjectP.put("a_nombres", varResultado.getString("a_nombres"));
                varJsonObjectP.put("asesor", varResultado.getString("a_apellidos") + " " + varResultado.getString("a_nombres"));
                varJsonObjectP.put("fecha_tentativa", varResultado.getString("fecha_tentativa"));
                varJsonObjectP.put("nota", varResultado.getString("nota"));
                varJsonObjectP.put("estado", varResultado.getString("estado"));
                /*varJsonObjectP.put("estado", varResultado.getString("estado"));*/
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public JSONObject getLocalidades() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT DISTINCT LOCALIDAD FROM TERRENO ORDER BY LOCALIDAD";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_localidad", varResultado.getString("localidad"));
                varJsonObjectP.put("localidad", varResultado.getString("localidad"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("localidades", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public JSONObject getEtapas(String idLocalidad) throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT DISTINCT ETAPA FROM TERRENO WHERE LOCALIDAD='" + idLocalidad + "' ORDER BY ETAPA";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("etapa", varResultado.getString("etapa"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("etapas", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public JSONObject getManzanas(String Localidad, String Etapa) throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT DISTINCT MANZANA FROM TERRENO WHERE LOCALIDAD='" + Localidad + "' AND ETAPA='" + Etapa + "' ORDER BY MANZANA";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("manzana", varResultado.getString("MANZANA"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("manzanas", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public JSONObject getLotes(String localidad, String etapa, String manzana) throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            // String varSql = "SELECT DISTINCT LOTE FROM TERRENO WHERE LOCALIDAD='" + localidad + "' AND ETAPA='" + etapa + "' AND MANZANA='" + manzana + "' ORDER BY LOTE  ";
            String varSql = "SELECT DISTINCT LOTE FROM TERRENO WHERE LOCALIDAD='" + localidad + "' AND ETAPA='" + etapa + "' AND MANZANA='" + manzana + "' AND "
                    + "LOTE NOT IN (SELECT DISTINCT T.LOTE FROM VENTA V INNER JOIN TERRENO T\n"
                    + "ON V.COD_TERRENO=T.COD_TERRENO WHERE T.LOCALIDAD='" + localidad + "' AND T.ETAPA='" + etapa + "' AND T.MANZANA='" + manzana + "') ORDER BY LOTE";
            System.out.println(varSql);

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("lote", varResultado.getString("lote"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("lotes", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public JSONObject getLocalidadesCandidatos() throws SQLException {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            varJsonObjectResultado.put("localidades", getLocalidades().get("localidades"));
            // varJsonObjectResultado.put("etapas", getEtapas().get("etapas"));
            varJsonObjectResultado.put("candidatos", getCandidatos().get("candidatos"));
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public JSONObject getCandidatos() throws SQLException {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_CANDIDATO,APELLIDOS,NOMBRES FROM CANDIDATO WHERE ESTADO='1' ORDER BY APELLIDOS,NOMBRES";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_candidato", varResultado.getInt("cod_candidato"));
                varJsonObjectP.put("apellidos", varResultado.getString("apellidos"));
                varJsonObjectP.put("nombres", varResultado.getString("nombres"));
                varJsonObjectP.put("candidato", varResultado.getString("apellidos") + " " + varResultado.getString("nombres"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("candidatos", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public int registrarVisita(Visita miVisita) throws SQLException {

        //stmt.executeUpdate(sql);
        try {
            String varSql = "INSERT INTO VISITA(LOCALIDAD,ETAPA,COD_CANDIDATO,COD_ASESOR,FECHA_TENTATIVA,NOTA,ESTADO,ESTADO_VISITA)\n"
                    + "VALUES('" + miVisita.getCod_localidad() + "','" + miVisita.getCod_etapa()
                    + "'," + miVisita.getCod_candidato() + "," + miVisita.getCod_asesor() + ",'" + miVisita.getFecha_tentativa()
                    + "','" + miVisita.getNota() + "','" + miVisita.getEstado() + "','1');";

            abrirConsulta();
            return stmt.executeUpdate(varSql);
        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarVisita()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;

    }

    public int modificarVisita(Visita miVisita, String cod_visita) throws SQLException {
        try {
            String varSql = "UPDATE VISITA SET LOCALIDAD='" + miVisita.getCod_localidad() + "',ETAPA='" + miVisita.getCod_etapa() + "',"
                    + "COD_CANDIDATO=" + miVisita.getCod_candidato() + ",COD_ASESOR=" + miVisita.getCod_asesor() + ",FECHA_TENTATIVA='" + miVisita.getFecha_tentativa()
                    + "',NOTA='" + miVisita.getNota() + "',ESTADO='" + miVisita.getEstado() + "' WHERE COD_VISITA=" + cod_visita + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarVisita()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarVisita(String cod_visita) throws SQLException {
        try {
            //String varSql = "UPDATE VISITA SET ESTADO_VISITA='FALSE' WHERE COD_VISITA=" + cod_visita + ";";
            String varSql = "DELETE FROM VISITA WHERE COD_VISITA=" + cod_visita + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarVisita()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getListaCliente() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT * FROM CLIENTE WHERE ESTADO=1 ORDER BY COD_CLIENTE desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_cliente", varResultado.getInt("cod_cliente"));
                varJsonObjectP.put("dni", varResultado.getString("dni"));
                varJsonObjectP.put("apellidos", varResultado.getString("apellidos"));
                varJsonObjectP.put("nombres", varResultado.getString("nombres"));
                varJsonObjectP.put("direccion", varResultado.getString("direccion"));
                varJsonObjectP.put("telefono", varResultado.getString("telefono"));
                varJsonObjectP.put("celular", varResultado.getString("celular"));
                varJsonObjectP.put("email", varResultado.getString("email"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public int registrarCliente(Cliente miCliente) throws SQLException {
        try {
            String varSql = "INSERT into CLIENTE(DNI,APELLIDOS,NOMBRES,DIRECCION,TELEFONO,CELULAR,EMAIL,ESTADO) values('" + miCliente.getDni() + "','" + miCliente.getApellidos()
                    + "','" + miCliente.getNombres() + "','" + miCliente.getDireccion() + "','" + miCliente.getTelefono()
                    + "','" + miCliente.getCelular() + "','" + miCliente.getEmail() + "','1');";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarCliente()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarCliente(Cliente miCliente, String cod_cliente) throws SQLException {

        try {
            String varSql = "UPDATE CLIENTE SET APELLIDOS='" + miCliente.getApellidos() + "',NOMBRES='" + miCliente.getNombres() + "',"
                    + "DIRECCION='" + miCliente.getDireccion() + "',DNI='" + miCliente.getDni() + "',TELEFONO='" + miCliente.getTelefono()
                    + "',CELULAR='" + miCliente.getCelular() + "',EMAIL='" + miCliente.getEmail() + "' WHERE COD_CLIENTE=" + cod_cliente + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarCliente()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarCliente(String cod_cliente) throws SQLException {
        try {
            //String varSql = "UPDATE CLIENTE SET estado='false' WHERE COD_CLIENTE=" + cod_cliente + ";";
            String varSql = "DELETE FROM CLIENTE WHERE COD_CLIENTE=" + cod_cliente + ";";
            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarCliente()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;

    }

    public JSONObject getListaLocalidad() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT * FROM LOCALIDAD ORDER BY COD_LOCALIDAD desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_localidad", varResultado.getInt("cod_localidad"));
                varJsonObjectP.put("localidad", varResultado.getString("localidad"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public int registrarLocalidad(Localidad miLocalidad) throws SQLException {
        try {
            String varSql = "INSERT into LOCALIDAD(LOCALIDAD) values('" + miLocalidad.getLocalidad() + "');";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarLocalidad()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarLocalidad(Localidad miLocalidad, String cod_localidad) throws SQLException {

        try {
            String varSql = "UPDATE LOCALIDAD SET LOCALIDAD='" + miLocalidad.getLocalidad()
                    + "' WHERE COD_LOCALIDAD=" + cod_localidad + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarLocalidad()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarLocalidad(String cod_localidad) throws SQLException {
        try {
            String varSql = "DELETE FROM LOCALIDAD WHERE COD_LOCALIDAD=" + cod_localidad + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarLocalidad()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;

    }

    public JSONObject getListaEtapa() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_ETAPA,ETAPA FROM ETAPA ORDER BY COD_ETAPA desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_etapa", varResultado.getInt("COD_ETAPA"));
                varJsonObjectP.put("etapa", varResultado.getString("ETAPA"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public int registrarEtapa(Etapa miEtapa) throws SQLException {
        try {
            String varSql = "INSERT into ETAPA(ETAPA) values('" + miEtapa.getEtapa() + "');";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarEtapa()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarEtapa(Etapa miEtapa, String cod_etapa) throws SQLException {
        try {
            String varSql = "UPDATE ETAPA SET ETAPA='" + miEtapa.getEtapa()
                    + "' WHERE COD_ETAPA=" + cod_etapa + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarEtapa()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarEtapa(String cod_etapa) throws SQLException {
        try {
            String varSql = "DELETE FROM ETAPA WHERE COD_ETAPA=" + cod_etapa + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarEtapa()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getListaManzana() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_MANZANA,MANZANA FROM MANZANA ORDER BY COD_MANZANA desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_manzana", varResultado.getInt("COD_MANZANA"));
                varJsonObjectP.put("manzana", varResultado.getString("MANZANA"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public int registrarManzana(Manzana miManzana) throws SQLException {
        try {
            String varSql = "INSERT into MANZANA(MANZANA) values('" + miManzana.getManzana() + "');";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarManzana()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarManzana(Manzana miManzana, String cod_manzana) throws SQLException {
        try {
            String varSql = "UPDATE MANZANA SET MANZANA='" + miManzana.getManzana()
                    + "' WHERE COD_MANZANA=" + cod_manzana + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarManzana()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarManzana(String cod_manzana) throws SQLException {
        try {
            String varSql = "DELETE FROM MANZANA WHERE COD_MANZANA=" + cod_manzana + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarManzana()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getListaTerreno() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_TERRENO,LOCALIDAD,ETAPA,MANZANA,LOTE FROM TERRENO ORDER BY COD_TERRENO desc;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_terreno", varResultado.getInt("COD_TERRENO"));
                varJsonObjectP.put("localidad", varResultado.getString("LOCALIDAD"));
                varJsonObjectP.put("etapa", varResultado.getString("ETAPA"));
                varJsonObjectP.put("manzana", varResultado.getString("MANZANA"));
                varJsonObjectP.put("lote", varResultado.getString("LOTE"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public int registrarTerreno(Terreno miTerreno) throws SQLException {
        try {
            String varSql = "INSERT into TERRENO(LOCALIDAD,ETAPA,MANZANA,LOTE) values('" + miTerreno.getLocalidad() + "','" + miTerreno.getEtapa() + "','"
                    + miTerreno.getManzana() + "','" + miTerreno.getLote() + "');";
            System.out.println(varSql);
            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarTerreno()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarTerreno(Terreno miTerreno, String cod_terreno) throws SQLException {
        try {
            String varSql = "UPDATE TERRENO SET LOCALIDAD='" + miTerreno.getLocalidad()
                    + "',ETAPA='" + miTerreno.getEtapa() + "',MANZANA='" + miTerreno.getManzana() + "',LOTE='" + miTerreno.getLote() + "' WHERE COD_TERRENO=" + cod_terreno + ";";
            System.out.println("SQL: " + varSql);
            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {

            System.out.println("DAO.CRUD.modificarTerreno()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarTerreno(String cod_terreno) throws SQLException {
        try {
            String varSql = "DELETE FROM TERRENO WHERE COD_TERRENO=" + cod_terreno + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarTerreno()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getCliente(String dni) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT * FROM CLIENTE WHERE ESTADO=1 and dni='" + dni + "'";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectResultado.put("Result", "OK");
                varJsonObjectResultado.put("cod_cliente", varResultado.getInt("cod_cliente"));
                varJsonObjectResultado.put("dni", varResultado.getString("dni"));
                varJsonObjectResultado.put("apellidos", varResultado.getString("apellidos"));
                varJsonObjectResultado.put("nombres", varResultado.getString("nombres"));
                varJsonObjectResultado.put("direccion", varResultado.getString("direccion"));
                varJsonObjectResultado.put("telefono", varResultado.getString("telefono"));
                varJsonObjectResultado.put("celular", varResultado.getString("celular"));
                varJsonObjectResultado.put("email", varResultado.getString("email"));

                return varJsonObjectResultado;
                //varJsonArrayP.add(varJsonObjectP);
            }

            varJsonObjectResultado.put("Result", "VACIO");
            cerrarConsulta();
            return varJsonObjectResultado;

        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
            return varJsonObjectResultado;
        }

    }

    public JSONObject verificaTerreno(String idLocalidad, String idEtapa, String idManzana, String lote) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT * FROM VENTA V INNER JOIN VENTA_TERRENO VT \n"
                    + "ON V.COD_VENTA=VT.COD_VENTA\n"
                    + "INNER JOIN TERRENO T\n"
                    + "ON VT.COD_TERRENO=T.COD_TERRENO WHERE T.LOCALIDAD='" + idLocalidad + "'and T.ETAPA='" + idEtapa + "'"
                    + "and T.MANZANA='" + idManzana + "' and T.LOTE='" + lote + "'";
            System.out.println(varSql);
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectResultado.put("Result", "VENDIDO");
                return varJsonObjectResultado;
                //varJsonArrayP.add(varJsonObjectP);
            }
            varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("idTerreno", getIDTerreno(idLocalidad, idEtapa, idManzana, lote));
            cerrarConsulta();
            return varJsonObjectResultado;

        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
            return varJsonObjectResultado;
        }
    }

    public int getIDTerreno(String idLocalidad, String idEtapa, String idManzana, String lote) {

        try {
            String varSql = "SELECT * FROM TERRENO T WHERE T.LOCALIDAD='" + idLocalidad + "'and T.ETAPA='" + idEtapa + "'"
                    + "and T.MANZANA='" + idManzana + "' and T.LOTE='" + lote + "'";
            System.out.println(varSql);
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                return varResultado.getInt("COD_TERRENO");
                //varJsonArrayP.add(varJsonObjectP);
            }
            cerrarConsulta();
            return 0;
        } catch (SQLException e) {
            System.out.println("DAO.CRUD.getIDTerreno()" + e.getMessage());
            return 0;
        }

    }

    public int registrarVenta(Venta miVenta) throws SQLException {

        try {

            abrirConsulta();
            CallableStatement cmst;
            cmst = varClsConexion.con.prepareCall("{ call SPREGISTRARVENTA(?,?,?,?,?,?,?,?,?,?) }");

            cmst.setString(1, miVenta.getCod_cliente());
            cmst.setInt(2, miVenta.getCod_terreno());
            cmst.setInt(3, miVenta.getP_inscripcion());
            cmst.setInt(4, miVenta.getP_inicial());
            cmst.setInt(5, miVenta.getNro_cuotas());
            cmst.setInt(6, miVenta.getMonto_mensual());
            cmst.setInt(7, miVenta.getCod_asesor());
            cmst.setInt(8, miVenta.getMonto_total());
            cmst.setString(9, miVenta.getNota());
            // parametros de salida
            cmst.registerOutParameter(10, java.sql.Types.INTEGER);

            //cmst.execute();
            cmst.execute();
            int cod_venta = cmst.getInt(10);
            return cod_venta;

        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        } finally {
            cerrarConsulta();
        }

    }

    public JSONObject getTerreno(String dniVendedor) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String varSql = "SELECT DISTINCT T.COD_TERRENO,T.LOCALIDAD,T.ETAPA,T.MANZANA,T.LOTE FROM VENTA V INNER JOIN TERRENO T\n"
                    + "ON V.COD_TERRENO=T.COD_TERRENO\n"
                    + "WHERE V.COD_CLIENTE='" + dniVendedor + "' ORDER BY COD_TERRENO";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_terreno", varResultado.getInt("COD_TERRENO"));
                varJsonObjectP.put("localidad", varResultado.getString("LOCALIDAD"));
                varJsonObjectP.put("etapa", varResultado.getString("ETAPA"));
                varJsonObjectP.put("manzana", varResultado.getString("MANZANA"));
                varJsonObjectP.put("lote", varResultado.getString("LOTE"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("terrenos", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public int getVenta(String dni, String cod_terreno) throws SQLException {

        try {
            String varSql = "SELECT COD_VENTA FROM VENTA WHERE COD_CLIENTE='" + dni + "' AND COD_TERRENO='" + cod_terreno + "';";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                // varJsonObjectResultado.put("cod_venta", varResultado.getInt("COD_VENTA"));
                return varResultado.getInt("COD_VENTA");
            }

        } catch (SQLException e) {
            return 0;
        } finally {
            cerrarConsulta();
        }
        return 0;
    }

    //cod_venta, dniVendedor, dniComprador, comision
    public int registrarTransferencia(int cod_venta, String dniVendedor, String dniComprador, int comision) throws SQLException {
        try {
            abrirConsulta();
            CallableStatement cmst;
            cmst = varClsConexion.con.prepareCall("{ call SPREGISTRARTRANSFERENCIA(?,?,?,?,?) }");

            cmst.setInt(1, cod_venta);
            cmst.setString(2, dniVendedor);
            cmst.setString(3, dniComprador);
            cmst.setInt(4, comision);
            // parametros de salida
            cmst.registerOutParameter(5, java.sql.Types.INTEGER);

            //cmst.execute();
            cmst.execute();
            int cod_trans = cmst.getInt(5);
            return cod_trans;

        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        } finally {
            cerrarConsulta();
        }

    }

    public JSONObject getEstadoCuenta(String dniCliente, String dniTerreno) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String varSql = "SELECT V.COD_VENTA,V.COD_CLIENTE,V.COD_TERRENO,V.P_INSCRIPCION,V.P_INICIAL,V.NRO_CUOTAS,V.FECHA_VENTA,V.HORA_VENTA,V.MONTO_MENSUAL,V.MONTO_TOTAL,V.MONTO_DEUDA,\n"
                    + "V.MONTO_PAGADO,V.ESTADO,V.NOTA  FROM VENTA V INNER JOIN TERRENO T\n"
                    + "ON V.COD_TERRENO=T.COD_TERRENO\n"
                    + "WHERE V.COD_CLIENTE='" + dniCliente + "' AND V.COD_TERRENO=" + dniTerreno + "";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectResultado.put("Result", "OK");
                varJsonObjectResultado.put("cod_venta", varResultado.getInt("COD_VENTA"));
                varJsonObjectResultado.put("p_inscripcion", varResultado.getInt("P_INSCRIPCION"));
                varJsonObjectResultado.put("p_inicial", varResultado.getString("P_INICIAL"));
                varJsonObjectResultado.put("nro_cuotas", varResultado.getString("NRO_CUOTAS"));
                //varJsonObjectResultado.put("nro_cuota_actual", varResultado.getString("NRO_CUOTA_ACTUAL"));
                varJsonObjectResultado.put("fecha_venta", varResultado.getString("FECHA_VENTA"));
                varJsonObjectResultado.put("hora_venta", varResultado.getString("HORA_VENTA"));
                varJsonObjectResultado.put("monto_mensual", varResultado.getString("MONTO_MENSUAL"));//V.MONTO_TOTAL
                varJsonObjectResultado.put("monto_total", varResultado.getString("MONTO_TOTAL"));
                varJsonObjectResultado.put("monto_deuda", varResultado.getString("MONTO_DEUDA"));
                varJsonObjectResultado.put("monto_pagado", varResultado.getString("MONTO_PAGADO"));
                varJsonObjectResultado.put("estado", varResultado.getString("ESTADO"));
                varJsonObjectResultado.put("nota", varResultado.getString("NOTA"));
                String cod_venta = varResultado.getString("COD_VENTA");
                varJsonObjectResultado.put("pagoLuz", getPagoUnicoLuz(cod_venta));
                varJsonObjectResultado.put("pagoAgua", getPagoUnicoAgua(cod_venta));
                String PagoOtro[] = getPagoUnicoOtro(cod_venta);
                varJsonObjectResultado.put("pagoOtro", PagoOtro[0]);
                varJsonObjectResultado.put("pagoOtroDes", PagoOtro[1]);
                return varJsonObjectResultado;

            }
            // varJsonObjectResultado.put("Result", "OK");
            // varJsonObjectResultado.put("EstadoCuenta", varJsonArrayP);
            varJsonObjectResultado.put("Result", "VACIO");
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public String getPagoUnicoLuz(String cod_venta) throws SQLException {

        try {
            String varSql = "SELECT COD_PAGO_UNICO,COD_VENTA,COD_TIPO_SERVICIO,FECHA_PAGO_UNICO,HORA_PAGO_UNICO,MONTO_PAGO,NOTA FROM PAGOS_UNICOS\n"
                    + "WHERE COD_TIPO_SERVICIO=1 AND COD_VENTA=" + cod_venta + ";";
            abrirConsulta();
            System.out.println(varSql);
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                return varResultado.getString("MONTO_PAGO");
            }
            return "0";
        } catch (SQLException e) {
            return null;
        } finally {
            cerrarConsulta();
        }
    }

    public String getPagoUnicoAgua(String cod_venta) throws SQLException {

        try {
            String varSql = "SELECT COD_PAGO_UNICO,COD_VENTA,COD_TIPO_SERVICIO,FECHA_PAGO_UNICO,HORA_PAGO_UNICO,MONTO_PAGO,NOTA FROM PAGOS_UNICOS\n"
                    + "WHERE COD_TIPO_SERVICIO=2 AND COD_VENTA=" + cod_venta + ";";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                return varResultado.getString("MONTO_PAGO");
            }
            return "0";
        } catch (SQLException e) {
            return null;
        } finally {
            cerrarConsulta();
        }
    }

    public String[] getPagoUnicoOtro(String cod_venta) throws SQLException {
        String PagoOtro[] = new String[2];
        PagoOtro[0] = "0";
        PagoOtro[1] = "";

        try {
            String varSql = "SELECT COD_PAGO_UNICO,COD_VENTA,COD_TIPO_SERVICIO,FECHA_PAGO_UNICO,HORA_PAGO_UNICO,MONTO_PAGO,NOTA FROM PAGOS_UNICOS\n"
                    + "WHERE COD_TIPO_SERVICIO=3 AND COD_VENTA=" + cod_venta + ";";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                PagoOtro = new String[2];
                PagoOtro[0] = varResultado.getString("MONTO_PAGO");
                PagoOtro[1] = varResultado.getString("NOTA");
                return PagoOtro;
            }
            return PagoOtro;
        } catch (SQLException e) {
            return null;
        } finally {
            cerrarConsulta();
        }
    }

    public JSONObject getListaCuotas(String cod_venta) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT NRO_CUOTA,FECHA_PAGO,CUOTA_MENSUAL FROM CALENDARIO_PAGO WHERE COD_VENTA=" + cod_venta + " AND ESTADO='A' ORDER BY NRO_CUOTA ";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("nro_cuota", varResultado.getInt("NRO_CUOTA"));
                varJsonObjectP.put("fecha_pago", varResultado.getString("FECHA_PAGO"));
                varJsonObjectP.put("cuota_mensual", varResultado.getString("CUOTA_MENSUAL"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public JSONObject getDeudaTotal(String cod_venta) {
        JSONObject varJsonObjectResultado = new JSONObject();
        try {
            String varSql = "SELECT SUM(CUOTA_MENSUAL) as TOTAL FROM CALENDARIO_PAGO WHERE COD_VENTA=" + cod_venta + " AND ESTADO='A'";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectResultado.put("Result", "OK");
                varJsonObjectResultado.put("total", varResultado.getInt("TOTAL"));
                return varJsonObjectResultado;

            }
            // varJsonObjectResultado.put("Result", "OK");
            // varJsonObjectResultado.put("EstadoCuenta", varJsonArrayP);
            varJsonObjectResultado.put("Result", "SINDEUDA");
            varJsonObjectResultado.put("total", "0");
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;

    }

    public JSONObject getAnios(String cod_venta) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT ANIO FROM ANIO WHERE ANIO>=(SELECT YEAR(FECHA_VENTA) FROM VENTA WHERE COD_VENTA=" + cod_venta + ") AND ANIO<=YEAR(GETDATE()) ORDER BY ANIO";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("anio", varResultado.getString("ANIO"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("anios", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public JSONObject getServicioLuz(String cod_venta, String anio_Luz) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_TIPO_SERVICIO,MES,ANIO,FECHA_PAGO_MENSUAL,HORA_PAGO_MENSUAL,MONTO_PAGO FROM PAGOS_MENSUALES"
                    + " WHERE COD_VENTA=" + cod_venta + " AND ANIO=" + anio_Luz + " AND COD_TIPO_SERVICIO=1";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("mes", varResultado.getString("MES"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("meses", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public JSONObject getServicioAgua(String cod_venta, String anio_agua) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_TIPO_SERVICIO,MES,ANIO,FECHA_PAGO_MENSUAL,HORA_PAGO_MENSUAL,MONTO_PAGO FROM PAGOS_MENSUALES"
                    + " WHERE COD_VENTA=" + cod_venta + " AND ANIO=" + anio_agua + " AND COD_TIPO_SERVICIO=2";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("mes", varResultado.getString("MES"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("meses", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public JSONObject getServicioSeguridad(String cod_venta, String anio_seguridad) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_TIPO_SERVICIO,MES,ANIO,FECHA_PAGO_MENSUAL,HORA_PAGO_MENSUAL,MONTO_PAGO FROM PAGOS_MENSUALES"
                    + " WHERE COD_VENTA=" + cod_venta + " AND ANIO=" + anio_seguridad + " AND COD_TIPO_SERVICIO=3";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("mes", varResultado.getString("MES"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("meses", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public void registrarPagosUnicos(PagosUnicos misPagosUnicos, String cod_venta) throws SQLException {

        if (misPagosUnicos.getPAguaEstado().equals("on")) {
            String varSql = "INSERT into PAGOS_UNICOS(COD_VENTA,COD_TIPO_SERVICIO,FECHA_PAGO_UNICO,HORA_PAGO_UNICO,MONTO_PAGO,NOTA) "
                    + "values(" + cod_venta + ",2,Convert(NChar(10), GetDate(), 120),CONVERT(nvarchar(10), GETDATE(), 108),"
                    + misPagosUnicos.getPAgua() + ",'PAGO UNICO AGUA');";
            insertarPagosUnicos(varSql);
        }
        if (misPagosUnicos.getPLuzEstado().equals("on")) {
            String varSql = "INSERT into PAGOS_UNICOS(COD_VENTA,COD_TIPO_SERVICIO,FECHA_PAGO_UNICO,HORA_PAGO_UNICO,MONTO_PAGO,NOTA) "
                    + "values(" + cod_venta + ",1,Convert(NChar(10), GetDate(), 120),CONVERT(nvarchar(10), GETDATE(), 108),"
                    + misPagosUnicos.getPLuz() + ",'PAGO UNICO LUZ');";
            insertarPagosUnicos(varSql);
        }
        if (misPagosUnicos.getPOtroEstado().equals("on")) {
            String varSql = "INSERT into PAGOS_UNICOS(COD_VENTA,COD_TIPO_SERVICIO,FECHA_PAGO_UNICO,HORA_PAGO_UNICO,MONTO_PAGO,NOTA) "
                    + "values(" + cod_venta + ",3,Convert(NChar(10), GetDate(), 120),CONVERT(nvarchar(10), GETDATE(), 108),"
                    + misPagosUnicos.getPOtro() + ",'" + misPagosUnicos.getPOtroDes() + "');";
            insertarPagosUnicos(varSql);
        }

    }

    public int insertarPagosUnicos(String varSql) throws SQLException {
        try {

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.insertarPagosUnicos()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public void registrarPagos(Pago misPagos, String cod_venta) throws SQLException {

        int montoCuotas = 0;
        if (misPagos.getTipo().equals("1")) {
            cuota[] misCuotas = misPagos.getCuotas();
            for (int i = 0; i < misCuotas.length; i++) {
                String varSql = "INSERT INTO PAGOS(COD_VENTA,FECHA_PAGO,HORA_PAGO,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO)"
                        + " VALUES(" + cod_venta + ",Convert(NChar(10), GetDate(), 120),CONVERT(nvarchar(10), GETDATE(), 108),"
                        + misCuotas[i].getMonto() + ",0," + misCuotas[i].getNro_cuota() + ",1)";
                montoCuotas += Float.parseFloat(misCuotas[i].getMonto());
                insertarPagosUnicos(varSql);
                String uptCalendario = "UPDATE CALENDARIO_PAGO SET ESTADO='P' WHERE COD_VENTA=" + cod_venta + " AND NRO_CUOTA=" + misCuotas[i].getNro_cuota() + ";";
                insertarPagosUnicos(uptCalendario);
            }
            String upSql = "UPDATE VENTA SET MONTO_DEUDA=MONTO_DEUDA-" + montoCuotas + ", MONTO_PAGADO=MONTO_PAGADO+" + montoCuotas + " "
                    + "WHERE COD_VENTA=" + cod_venta + "";
            insertarPagosUnicos(upSql);
        }
        if (misPagos.getTipo().equals("2")) {
            String varSql = "INSERT INTO PAGOS(COD_VENTA,FECHA_PAGO,HORA_PAGO,MONTO_PAGO,INTERES,NRO_CUOTA,COD_TIPO_PAGO)"
                    + " VALUES(" + cod_venta + ",Convert(NChar(10), GetDate(), 120),CONVERT(nvarchar(10), GETDATE(), 108),"
                    + misPagos.getMonto() + ",0,0,2)";
            insertarPagosUnicos(varSql);
            String upSql = "UPDATE VENTA SET MONTO_DEUDA=0, MONTO_PAGADO=MONTO_TOTAL"
                    + " WHERE COD_VENTA=" + cod_venta + "";
            insertarPagosUnicos(upSql);
            String uptCalendario = "UPDATE CALENDARIO_PAGO SET ESTADO='P' WHERE COD_VENTA=" + cod_venta + "";
            insertarPagosUnicos(uptCalendario);
        }

    }

    public void registrarPagosServicios(PagosServicios misPagosServicios, String cod_venta) {

        String[] pagoluz = misPagosServicios.getPagoLuz();
        String[] pagoAgua = misPagosServicios.getPagoAgua();
        String[] pagoSeguridad = misPagosServicios.getPagoSeguridad();
        String PrecioMensual = misPagosServicios.getPrecioMensual();
        try {
            for (int i = 0; i < pagoluz.length; i++) {
                String varSqlLuz = "INSERT INTO PAGOS_MENSUALES(COD_VENTA,COD_TIPO_SERVICIO,MES,ANIO,FECHA_PAGO_MENSUAL,HORA_PAGO_MENSUAL,MONTO_PAGO)"
                        + " VALUES(" + cod_venta + ",1,'" + pagoluz[i] + "'," + misPagosServicios.getAnioPagoLuz() + ",Convert(NChar(10), GetDate(), 120),CONVERT(nvarchar(10), GETDATE(), 108)," + PrecioMensual + ")";
                insertarPagosUnicos(varSqlLuz);
            }
            for (int i = 0; i < pagoAgua.length; i++) {
                String varSqlAgua = "INSERT INTO PAGOS_MENSUALES(COD_VENTA,COD_TIPO_SERVICIO,MES,ANIO,FECHA_PAGO_MENSUAL,HORA_PAGO_MENSUAL,MONTO_PAGO)"
                        + " VALUES(" + cod_venta + ",2,'" + pagoAgua[i] + "'," + misPagosServicios.getAnioPagoAgua() + ",Convert(NChar(10), GetDate(), 120),CONVERT(nvarchar(10), GETDATE(), 108)," + PrecioMensual + ")";
                insertarPagosUnicos(varSqlAgua);
            }
            for (int i = 0; i < pagoSeguridad.length; i++) {
                String varSqlSeg = "INSERT INTO PAGOS_MENSUALES(COD_VENTA,COD_TIPO_SERVICIO,MES,ANIO,FECHA_PAGO_MENSUAL,HORA_PAGO_MENSUAL,MONTO_PAGO)"
                        + " VALUES(" + cod_venta + ",3,'" + pagoSeguridad[i] + "'," + misPagosServicios.getAnioPagoLuz() + ",Convert(NChar(10), GetDate(), 120),CONVERT(nvarchar(10), GETDATE(), 108)," + PrecioMensual + ")";
                insertarPagosUnicos(varSqlSeg);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CRUD.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public JSONArray GetDataOLAP() throws SQLException {

        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        //JSONObject varJsonObjectResultado = new JSONObject();
        try {

            /* String varSql = "select distinct sbb.id,sbb.codigoPlan,sbb.CodigoAsignatura,sbb.CodigoDocente,sbb.Cod1,sbb.Cod2,sbb.Cod3,sbb.Cod4,sbb.Pri_isbn,sbb.titulo,sbb.Autor,sbb.Anyo,sbb.Editorial,sbb.Tipo,sbb.Proveedor,\n"
                    + "sbb.Fecha,sbb.Estado,sbb.EstadoenBiblioteca,sba.Nombre as Asignatura,sba.Semestre,sbu.ApellidoPaterno,sbu.ApellidoMaterno,sbu.Nombres,sbu.CodigoDepartamento,sbu.Activo,sbu.Contrasenia,\n"
                    + "p.idPrograma,p.ProgProf,da.Nombre as DepartamentoAcademico from SisBiblio_Bibliografia  sbb inner join sisBiblio_Asignaturas sba\n"
                    + "on sbb.CodigoAsignatura=sba.Codigo \n"
                    + "inner join SisBiblio_Usuarios sbu \n"
                    + "on sbb.CodigoDocente=sbu.CodigoDocente\n"
                    + "inner join Programas p\n"
                    + "on substring(sbb.CodigoPlan,0,3)=p.idPrograma\n"
                    + "inner join departamentos_Academicos da\n"
                    + "on sbu.CodigoDepartamento=da.Codigo";*/
            String varSql = "select COD_VENTA,COD_CLIENTE,COD_ASESOR,COD_TERRENO,P_INSCRIPCION,P_INICIAL,NRO_CUOTAS,FECHA_VENTA,HORA_VENTA,MONTO_MENSUAL,MONTO_TOTAL,MONTO_DEUDA,MONTO_PAGADO,ESTADO,NOTA \n"
                    + "from venta";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("COD_CLIENTE", varResultado.getInt("COD_CLIENTE"));
                varJsonObjectP.put("FECHA_VENTA", varResultado.getString("FECHA_VENTA"));
                /* varJsonObjectP.put("COD_ASESOR", varResultado.getString("COD_ASESOR"));
                varJsonObjectP.put("COD_TERRENO", varResultado.getString("COD_TERRENO"));*/
 /*varJsonObjectP.put("Cod1", varResultado.getString("Cod1").trim());
                varJsonObjectP.put("Cod2", varResultado.getString("Cod2").trim());
                varJsonObjectP.put("Cod3", varResultado.getString("Cod3").trim());
                varJsonObjectP.put("Cod4", varResultado.getString("Cod4").trim());
                varJsonObjectP.put("Pri_isbn", varResultado.getString("Pri_isbn"));
                varJsonObjectP.put("titulo", varResultado.getString("titulo"));
                varJsonObjectP.put("Autor", varResultado.getString("Autor"));
                varJsonObjectP.put("Anyo", varResultado.getString("Anyo"));
                varJsonObjectP.put("Tipo", varResultado.getString("Tipo"));
                varJsonObjectP.put("Proveedor", varResultado.getString("Proveedor"));
                varJsonObjectP.put("Fecha", varResultado.getString("Fecha"));
                varJsonObjectP.put("Estado", varResultado.getString("Estado"));
                varJsonObjectP.put("EstadoenBiblioteca", varResultado.getString("EstadoenBiblioteca"));
                varJsonObjectP.put("Asignatura", varResultado.getString("Asignatura"));
                varJsonObjectP.put("Semestre", varResultado.getString("Semestre"));
                varJsonObjectP.put("ApellidoPaterno", varResultado.getString("ApellidoPaterno"));
                varJsonObjectP.put("ApellidoMaterno", varResultado.getString("ApellidoMaterno"));
                varJsonObjectP.put("Nombres", varResultado.getString("Nombres"));
                varJsonObjectP.put("CodigoDepartamento", varResultado.getString("CodigoDepartamento"));
                varJsonObjectP.put("Activo", varResultado.getString("Activo"));
                varJsonObjectP.put("Contrasenia", varResultado.getString("Contrasenia"));
                varJsonObjectP.put("idPrograma", varResultado.getString("idPrograma"));
                varJsonObjectP.put("ProgProf", varResultado.getString("ProgProf"));
                varJsonObjectP.put("DepartamentoAcademico", varResultado.getString("DepartamentoAcademico"));*/

                varJsonArrayP.add(varJsonObjectP);
            }
            //   varJsonObjectResultado.put("Result", "OK");
            //  varJsonObjectResultado.put("Records", varJsonArrayP);
        } catch (SQLException e) {
            //  varJsonObjectResultado.put("Result", "ERROR");
            //  varJsonObjectResultado.put("Message", e.getMessage());
        }
        cerrarConsulta();
        return varJsonArrayP;
    }

    public JSONObject getListaTiposEgresos() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_TIPO_EGRESO,TIPO_EGRESO FROM TIPO_EGRESO ORDER BY COD_TIPO_EGRESO";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_tipo_egreso", varResultado.getInt("COD_TIPO_EGRESO"));
                varJsonObjectP.put("tipo_egreso", varResultado.getString("TIPO_EGRESO"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public int registrarTipoEgreso(TipoEgreso miTipoEgreso) throws SQLException {
        try {
            String varSql = "INSERT into TIPO_EGRESO(TIPO_EGRESO) values('" + miTipoEgreso.getTipo_egreso() + "');";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarTipoEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarTipoEgreso(TipoEgreso miTipoEgreso, String cod_tipo_egreso) throws SQLException {

        try {
            String varSql = "UPDATE TIPO_EGRESO SET TIPO_EGRESO='" + miTipoEgreso.getTipo_egreso()
                    + "' WHERE COD_TIPO_EGRESO=" + cod_tipo_egreso + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarTipoEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarTipoEgreso(String cod_TipoEgreso) throws SQLException {
        try {
            String varSql = "DELETE FROM TIPO_EGRESO WHERE COD_TIPO_EGRESO=" + cod_TipoEgreso + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarTipoEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;

    }

    public JSONObject getListaSubTiposEgresos() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT STE.COD_SUB_TIPO_EGRESO,STE.SUB_TIPO_EGRESO,TE.COD_TIPO_EGRESO,TE.TIPO_EGRESO FROM SUB_TIPO_EGRESO STE\n"
                    + "INNER JOIN TIPO_EGRESO TE\n"
                    + "ON STE.COD_TIPO_EGRESO=TE.COD_TIPO_EGRESO\n"
                    + "ORDER BY SUB_TIPO_EGRESO";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_sub_tipo_egreso", varResultado.getInt("COD_SUB_TIPO_EGRESO"));
                varJsonObjectP.put("sub_tipo_egreso", varResultado.getString("SUB_TIPO_EGRESO"));
                varJsonObjectP.put("cod_tipo_egreso", varResultado.getInt("COD_TIPO_EGRESO"));
                varJsonObjectP.put("tipo_egreso", varResultado.getString("TIPO_EGRESO"));

                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public int registrarSubTipoEgreso(SubTipoEgreso miSubTipoEgreso) throws SQLException {
        try {
            String varSql = "INSERT into SUB_TIPO_EGRESO(SUB_TIPO_EGRESO,COD_TIPO_EGRESO) values('" + miSubTipoEgreso.getSub_tipo_egreso() + "'," + miSubTipoEgreso.getCod_tipo_egreso() + ");";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarSubTipoEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarSubTipoEgreso(SubTipoEgreso miSubTipoEgreso, String cod_sub_tipo_egreso) throws SQLException {

        try {
            String varSql = "UPDATE SUB_TIPO_EGRESO SET SUB_TIPO_EGRESO='" + miSubTipoEgreso.getSub_tipo_egreso()
                    + "', COD_TIPO_EGRESO=" + miSubTipoEgreso.getCod_tipo_egreso() + ""
                    + " WHERE COD_SUB_TIPO_EGRESO=" + cod_sub_tipo_egreso + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarSubTipoEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarSubTipoEgreso(String cod_sub_tipo_egreso) throws SQLException {
        try {
            String varSql = "DELETE FROM SUB_TIPO_EGRESO WHERE COD_SUB_TIPO_EGRESO=" + cod_sub_tipo_egreso + ";";
            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarSubTipoEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getListaEgresos() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT E.COD_EGRESO,E.COD_TIPO_EGRESO,TE.TIPO_EGRESO,E.COD_SUB_TIPO_EGRESO,STE.SUB_TIPO_EGRESO,E.LOCALIDAD,E.ETAPA,E.MONTO_EGRESO,\n"
                    + "E.TIPO_COMPROBANTE,E.NOTA_EGRESO,E.FECHA_EGRESO  FROM EGRESOS E INNER JOIN TIPO_EGRESO TE\n"
                    + "ON E.COD_TIPO_EGRESO=TE.COD_TIPO_EGRESO\n"
                    + "INNER JOIN SUB_TIPO_EGRESO STE\n"
                    + "ON E.COD_SUB_TIPO_EGRESO=STE.COD_SUB_TIPO_EGRESO\n"
                    + "INNER JOIN LOCALIDAD L \n"
                    + "ON E.LOCALIDAD=L.LOCALIDAD\n"
                    + "INNER JOIN ETAPA ET\n"
                    + "ON E.ETAPA=ET.ETAPA";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_egreso", varResultado.getInt("COD_EGRESO"));
                varJsonObjectP.put("cod_tipo_egreso", varResultado.getInt("COD_TIPO_EGRESO"));
                varJsonObjectP.put("tipo_egreso", varResultado.getString("TIPO_EGRESO"));
                varJsonObjectP.put("cod_sub_tipo_egreso", varResultado.getInt("COD_SUB_TIPO_EGRESO"));
                varJsonObjectP.put("sub_tipo_egreso", varResultado.getString("SUB_TIPO_EGRESO"));
                varJsonObjectP.put("localidad", varResultado.getString("LOCALIDAD"));
                varJsonObjectP.put("etapa", varResultado.getString("ETAPA"));
                varJsonObjectP.put("monto_egreso", varResultado.getInt("MONTO_EGRESO"));
                varJsonObjectP.put("tipo_comprobante", varResultado.getString("TIPO_COMPROBANTE"));
                varJsonObjectP.put("nota_egreso", varResultado.getString("NOTA_EGRESO"));
                varJsonObjectP.put("fecha_egreso", varResultado.getString("FECHA_EGRESO"));
                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }
        return varJsonObjectResultado;
    }

    public int registrarEgreso(Egreso miEgreso) throws SQLException {
        try {
            String varSql = "INSERT into EGRESOS(COD_TIPO_EGRESO,COD_SUB_TIPO_EGRESO,LOCALIDAD,ETAPA,"
                    + "MONTO_EGRESO,TIPO_COMPROBANTE,NOTA_EGRESO,FECHA_EGRESO) values("
                    + miEgreso.getCod_tipo_egreso() + "," + miEgreso.getCod_sub_tipo_egreso()
                    + ",'" + miEgreso.getLocalidad() + "','" + miEgreso.getEtapa() + "',"
                    + miEgreso.getMonto_egreso() + ",'" + miEgreso.getTipo_comprobante()
                    + "','" + miEgreso.getNota() + "',Convert(NChar(10), GetDate(), 120));";
            abrirConsulta();
            return stmt.executeUpdate(varSql);
        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarEgreso(Egreso miEgreso, String cod_egreso) throws SQLException {
        try {
            String varSql = "UPDATE EGRESOS SET COD_TIPO_EGRESO=" + miEgreso.getCod_tipo_egreso()
                    + ", COD_SUB_TIPO_EGRESO=" + miEgreso.getCod_sub_tipo_egreso()
                    + ", LOCALIDAD='" + miEgreso.getLocalidad()
                    + "', ETAPA='" + miEgreso.getEtapa()
                    + "', MONTO_EGRESO=" + miEgreso.getMonto_egreso()
                    + ", TIPO_COMPROBANTE='" + miEgreso.getTipo_comprobante()
                    + "', NOTA_EGRESO='" + miEgreso.getNota()
                    + "' WHERE COD_EGRESO=" + cod_egreso + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarEgreso(String cod_egreso) throws SQLException {
        try {
            String varSql = "DELETE FROM EGRESOS WHERE COD_EGRESO=" + cod_egreso + ";";
            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarEgreso()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getSubTipoEgreso(String SelecTipoEgreso) {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT COD_SUB_TIPO_EGRESO,SUB_TIPO_EGRESO FROM SUB_TIPO_EGRESO "
                    + " WHERE COD_TIPO_EGRESO=" + SelecTipoEgreso.trim() + ";";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("cod_sub_tipo_egreso", varResultado.getInt("COD_SUB_TIPO_EGRESO"));
                varJsonObjectP.put("sub_tipo_egreso", varResultado.getString("SUB_TIPO_EGRESO"));

                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("subtiposegresos", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public JSONObject getvalorDefecto() {

        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT TOP 1 MONTO_PAGO_SERVICIOS_UNICOS FROM VALORES_DEFECTO;";
            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                // varJsonObjectP.put("monto_pago_servicios", varResultado.getInt("MONTO_PAGO_SERVICIOS_UNICOS"));
                //varJsonArrayP.add(varJsonObjectP);
                varJsonObjectResultado.put("monto_pago_servicios", varResultado.getInt("MONTO_PAGO_SERVICIOS_UNICOS"));
            }
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;
    }

    public int modificarValoresDefecto(int PagoServicio) throws SQLException {
        try {
            String varSql = "UPDATE VALORES_DEFECTO SET MONTO_PAGO_SERVICIOS_UNICOS=" + PagoServicio + ";";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarValoresDefecto()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public JSONObject getListaUsuarios() {
        JSONObject varJsonObjectP = new JSONObject();
        JSONArray varJsonArrayP = new JSONArray();
        JSONObject varJsonObjectResultado = new JSONObject();
        try {

            String varSql = "SELECT DNI,NOMBRES,APELLIDOS,CONTRASENIA,TIPO_USUARIO FROM USUARIO;";

            abrirConsulta();
            varResultado = stmt.executeQuery(varSql);
            while (varResultado.next()) {
                varJsonObjectP.put("dni", varResultado.getString("DNI"));
                varJsonObjectP.put("nombres", varResultado.getString("NOMBRES"));
                varJsonObjectP.put("apellidos", varResultado.getString("APELLIDOS"));
                varJsonObjectP.put("contrasenia", varResultado.getString("CONTRASENIA"));
                varJsonObjectP.put("tipo_usuario", varResultado.getString("TIPO_USUARIO"));

                varJsonArrayP.add(varJsonObjectP);
            }
            // varJsonObjectResultado.put("Result", "OK");
            varJsonObjectResultado.put("data", varJsonArrayP);
            cerrarConsulta();
        } catch (SQLException e) {
            varJsonObjectResultado.put("Result", "ERROR");
            varJsonObjectResultado.put("Message", e.getMessage());
        }

        return varJsonObjectResultado;

    }

    public int registrarUsuario(Usuario miUsuario) throws SQLException {
        try {
            String varSql = "INSERT into USUARIO(APELLIDOS,NOMBRES,DNI,CONTRASENIA,"
                    + "TIPO_USUARIO,FECHA_USUARIO) values('"
                    + miUsuario.getApellidos() + "','" + miUsuario.getNombres()
                    + "','" + miUsuario.getDni() + "','" + miUsuario.getContrasenia() + "','"
                    + miUsuario.getTipo_usuario() + "',Convert(NChar(10), GetDate(), 120));";
            abrirConsulta();
            return stmt.executeUpdate(varSql);
        } catch (SQLException e) {
            System.out.println("DAO.CRUD.registrarUsuario()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int modificarUsuario(Usuario miUsuario, String dni) throws SQLException {
        try {
            String varSql = "UPDATE USUARIO SET APELLIDOS='" + miUsuario.getApellidos()
                    + "', NOMBRES='" + miUsuario.getNombres()
                    + "', CONTRASENIA='" + miUsuario.getContrasenia()
                    + "', TIPO_USUARIO='" + miUsuario.getTipo_usuario()
                    + "' WHERE DNI='" + dni + "';";

            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.modificarUsuario()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

    public int eliminarUsuario(String dni) throws SQLException {
        try {
            String varSql = "DELETE FROM USUARIO WHERE DNI='" + dni + "';";
            abrirConsulta();
            return stmt.executeUpdate(varSql);

        } catch (SQLException e) {
            System.out.println("DAO.CRUD.eliminarUsuario()" + e.getMessage());
        }
        cerrarConsulta();
        return 0;
    }

}
