/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import DAO.CRUD;
import VO.Asesor;
import VO.Candidato;
import VO.Cliente;
import VO.Egreso;
import VO.Etapa;
import VO.Localidad;
import VO.Manzana;
import VO.SubTipoEgreso;
import VO.Terreno;
import VO.TipoEgreso;
import VO.Visita;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONObject;

/**
 *
 * @author jbasurco
 */
public class ControlServlet extends HttpServlet {

    private HttpServletRequest varRequest = null;
    private HttpServletResponse varResponse = null;
    private PrintWriter varOut = null;
    private HttpSession varSession = null;
    private CRUD varCRUD = null;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        varCRUD = new CRUD();

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        //request.setCharacterEncoding("UTF8");
        PrintWriter out = response.getWriter();
        try {
            varRequest = request;
            varResponse = response;
            varSession = request.getSession();
            varOut = varResponse.getWriter();
            String opcion = varRequest.getParameter("parAccion");
            switch (opcion) {
                case "listaCandidatos":
                    JSONObject varJSONCandidatos = varCRUD.getListaCandidatos();
                    varOut.print(varJSONCandidatos);
                    break;
                case "guardarCandidato":
                    CRUDTableCandidato();
                    break;
                case "listaAsesor":
                    JSONObject varJSONAsesores = varCRUD.getListaAsesor();
                    varOut.print(varJSONAsesores);
                    break;
                case "guardarAsesor":
                    CRUDTableAsesor();
                    break;
                case "listaCliente":
                    JSONObject varJSONCliente = varCRUD.getListaCliente();
                    varOut.print(varJSONCliente);
                    break;
                case "guardarCliente":
                    CRUDTableCliente();
                    break;
                case "listaVisita":
                    JSONObject varJSONVisitas = varCRUD.getListaVisitas();
                    varOut.print(varJSONVisitas);
                    break;
                case "guardarVisitas":
                    CRUDTableVisita();
                    break;
                case "getLocalidades":
                    varOut.print(varCRUD.getLocalidades());
                    break;
                case "getEtapas":
                    varOut.print(varCRUD.getEtapas(varRequest.getParameter("idLocalidad")));
                    break;
                case "getManzanas":
                    varOut.print(varCRUD.getManzanas(varRequest.getParameter("idLocalidad"), varRequest.getParameter("idEtapa")));
                    break;
                case "getLotes":
                    varOut.print(varCRUD.getLotes(varRequest.getParameter("idLocalidad"), varRequest.getParameter("idEtapa"), varRequest.getParameter("idManzana")));
                    break;
                case "getLocalidadesCandidatos":
                    varOut.print(varCRUD.getLocalidadesCandidatos());
                    break;
                case "listaLocalidad":
                    JSONObject varJSONLocalidad = varCRUD.getListaLocalidad();
                    varOut.print(varJSONLocalidad);
                    break;
                case "guardarLocalidad":
                    CRUDTableLocalidad();
                    break;
                case "listaEtapa":
                    JSONObject varJSONEtapa = varCRUD.getListaEtapa();
                    varOut.print(varJSONEtapa);
                    break;
                case "guardarEtapa":
                    CRUDTableEtapa();
                    break;
                case "listaManzana":
                    JSONObject varJSONManzana = varCRUD.getListaManzana();
                    varOut.print(varJSONManzana);
                    break;
                case "guardarManzana":
                    CRUDTableManzana();
                    break;
                case "listaTerreno":
                    JSONObject varJSONTerreno = varCRUD.getListaTerreno();
                    varOut.print(varJSONTerreno);
                    break;
                case "guardarTerreno":
                    CRUDTableTerreno();
                    break;
                case "buscarTerreno":
                    varOut.print(varCRUD.getTerreno(varRequest.getParameter("dniVendedor")));
                    break;
                case "listaTiposEgresos":
                    varOut.print(varCRUD.getListaTiposEgresos());
                    break;
                case "guardarTipoEgreso":
                    CRUDTableTipoEgresado();
                    break;
                case "listaSubTiposEgresos":
                    varOut.print(varCRUD.getListaSubTiposEgresos());
                    break;
                case "guardarSubTiposEgresos":
                    CRUDTableSubTiposEgresados();
                    break;
                case "listaEgresos":
                    varOut.print(varCRUD.getListaEgresos());
                    break;
                case "guardarEgresos":
                    CRUDTableEgresados();
                    break;
                case "getSubtipoEgresos":
                    String SelecTipoEgreso = varRequest.getParameter("selectTipoEgreso");
                    varOut.print(varCRUD.getSubTipoEgreso(SelecTipoEgreso));
                    break;
                case "getLocalEtapaManzana":
                    getLocalEtapasManzanas();
                    break;
            }

        } finally {
            out.close();
        }

    }

    public void CRUDTableVisita() throws SQLException {
        String cod_visita = varRequest.getParameter("cod_visita");
        String opcion = varRequest.getParameter("opcion");

        Visita miVisita = new Visita();

        JSONObject varJsonInformacion = new JSONObject();

        switch (opcion) {
            case "registrar":
                miVisita.setCod_localidad(varRequest.getParameter("SelectLocalidad"));
                miVisita.setCod_etapa(varRequest.getParameter("SelectEtapa"));
                miVisita.setCod_candidato(varRequest.getParameter("SelectCandidato"));
                miVisita.setFecha_tentativa(varRequest.getParameter("fecha"));
                miVisita.setNota(varRequest.getParameter("nota"));
                miVisita.setEstado(varRequest.getParameter("SelectEstado"));
                miVisita.setCod_asesor("1");
                if (miVisita.getCod_localidad() != "" && miVisita.getCod_etapa() != "" && miVisita.getCod_candidato() != "" && miVisita.getFecha_tentativa() != "" && miVisita.getEstado() != "") {
                    verificarResultado(varCRUD.registrarVisita(miVisita), varJsonInformacion);
                }
                break;
            case "modificar":
                miVisita.setCod_localidad(varRequest.getParameter("SelectLocalidad"));
                miVisita.setCod_etapa(varRequest.getParameter("SelectEtapa"));
                miVisita.setCod_candidato(varRequest.getParameter("SelectCandidato"));
                miVisita.setFecha_tentativa(varRequest.getParameter("fecha"));
                miVisita.setNota(varRequest.getParameter("nota"));
                miVisita.setEstado(varRequest.getParameter("SelectEstado"));
                miVisita.setCod_asesor("1");

                verificarResultado(varCRUD.modificarVisita(miVisita, cod_visita), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarVisita(cod_visita), varJsonInformacion);
                break;

        }
    }

    public void CRUDTableAsesor() throws SQLException {
        String cod_asesor = varRequest.getParameter("cod_asesor");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";
        Asesor miAsesor = new Asesor();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));

        switch (opcion) {
            case "registrar":
                miAsesor.setNombres(varRequest.getParameter("nombre"));
                miAsesor.setApellidos(varRequest.getParameter("apellidos"));
                miAsesor.setDireccion(varRequest.getParameter("direccion"));
                miAsesor.setDni(varRequest.getParameter("dni"));
                miAsesor.setTelefono(varRequest.getParameter("telefono"));
                miAsesor.setCelular(varRequest.getParameter("celular"));

                if (miAsesor.getNombres() != "" && miAsesor.getApellidos() != "" && miAsesor.getDni() != "" && miAsesor.getDireccion() != "" && miAsesor.getCelular() != "") {
                    verificarResultado(varCRUD.registrarAsesor(miAsesor), varJsonInformacion);
                }
                break;
            case "modificar":
                miAsesor.setNombres(varRequest.getParameter("nombre"));
                miAsesor.setApellidos(varRequest.getParameter("apellidos"));
                miAsesor.setDireccion(varRequest.getParameter("direccion"));
                miAsesor.setDni(varRequest.getParameter("dni"));
                miAsesor.setTelefono(varRequest.getParameter("telefono"));
                miAsesor.setCelular(varRequest.getParameter("celular"));
                verificarResultado(varCRUD.modificarAsesor(miAsesor, cod_asesor), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarAsesor(cod_asesor), varJsonInformacion);
                break;

        }
    }

    public void CRUDTableCandidato() throws SQLException {
        String cod_candidato = varRequest.getParameter("cod_candidato");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";
        Candidato miCandidato = new Candidato();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));

        switch (opcion) {
            case "registrar":
                miCandidato.setNombres(varRequest.getParameter("nombre"));
                miCandidato.setApellidos(varRequest.getParameter("apellidos"));
                miCandidato.setDireccion(varRequest.getParameter("direccion"));
                miCandidato.setDni(varRequest.getParameter("dni"));
                miCandidato.setTelefono(varRequest.getParameter("telefono"));
                miCandidato.setCelular(varRequest.getParameter("celular"));

                if (miCandidato.getNombres() != "" && miCandidato.getApellidos() != "") {
                    verificarResultado(varCRUD.registrarCandidato(miCandidato), varJsonInformacion);
                }
                break;
            case "modificar":
                miCandidato.setNombres(varRequest.getParameter("nombre"));
                miCandidato.setApellidos(varRequest.getParameter("apellidos"));
                miCandidato.setDireccion(varRequest.getParameter("direccion"));
                miCandidato.setDni(varRequest.getParameter("dni"));
                miCandidato.setTelefono(varRequest.getParameter("telefono"));
                miCandidato.setCelular(varRequest.getParameter("celular"));
                verificarResultado(varCRUD.modificarCandidato(miCandidato, cod_candidato), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarCandidato(cod_candidato), varJsonInformacion);
                break;

        }
    }

    public void verificarResultado(int resultado, JSONObject varJsonInformacion) {

        if (resultado == 0) {
            varJsonInformacion.put("respuesta", "ERROR");
        } else {
            varJsonInformacion.put("respuesta", "BIEN");
        }
        varOut.print(varJsonInformacion);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ControlServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ControlServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void CRUDTableCliente() throws SQLException {
        String cod_cliente = varRequest.getParameter("cod_cliente");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";
        Cliente miCliente = new Cliente();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));

        switch (opcion) {
            case "registrar":
                miCliente.setNombres(varRequest.getParameter("nombre"));
                miCliente.setApellidos(varRequest.getParameter("apellidos"));
                miCliente.setDireccion(varRequest.getParameter("direccion"));
                miCliente.setDni(varRequest.getParameter("dni"));
                miCliente.setTelefono(varRequest.getParameter("telefono"));
                miCliente.setCelular(varRequest.getParameter("celular"));
                miCliente.setEmail(varRequest.getParameter("email"));

                if (miCliente.getNombres() != "" && miCliente.getApellidos() != "" && miCliente.getDni() != "" && miCliente.getDireccion() != "" && miCliente.getCelular() != "") {
                    verificarResultado(varCRUD.registrarCliente(miCliente), varJsonInformacion);
                }
                break;
            case "modificar":
                miCliente.setNombres(varRequest.getParameter("nombre"));
                miCliente.setApellidos(varRequest.getParameter("apellidos"));
                miCliente.setDireccion(varRequest.getParameter("direccion"));
                miCliente.setDni(varRequest.getParameter("dni"));
                miCliente.setTelefono(varRequest.getParameter("telefono"));
                miCliente.setCelular(varRequest.getParameter("celular"));
                miCliente.setEmail(varRequest.getParameter("email"));
                verificarResultado(varCRUD.modificarCliente(miCliente, cod_cliente), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarCliente(cod_cliente), varJsonInformacion);
                break;

        }
    }

    private void CRUDTableLocalidad() throws SQLException {
        String cod_localidad = varRequest.getParameter("cod_localidad");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";
        Localidad miLocalidad = new Localidad();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));

        switch (opcion) {
            case "registrar":
                miLocalidad.setLocalidad(varRequest.getParameter("localidad"));

                if (miLocalidad.getLocalidad() != "") {
                    verificarResultado(varCRUD.registrarLocalidad(miLocalidad), varJsonInformacion);
                }
                break;
            case "modificar":
                miLocalidad.setLocalidad(varRequest.getParameter("localidad"));
                verificarResultado(varCRUD.modificarLocalidad(miLocalidad, cod_localidad), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarLocalidad(cod_localidad), varJsonInformacion);
                break;

        }
    }

    private void CRUDTableEtapa() throws SQLException {
        String cod_etapa = varRequest.getParameter("cod_etapa");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";
        Etapa miEtapa = new Etapa();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));

        switch (opcion) {
            case "registrar":
                miEtapa.setEtapa(varRequest.getParameter("etapa"));

                if (miEtapa.getEtapa() != "") {
                    verificarResultado(varCRUD.registrarEtapa(miEtapa), varJsonInformacion);
                }
                break;
            case "modificar":
                miEtapa.setEtapa(varRequest.getParameter("etapa"));
                verificarResultado(varCRUD.modificarEtapa(miEtapa, cod_etapa), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarEtapa(cod_etapa), varJsonInformacion);
                break;

        }
    }

    private void CRUDTableManzana() throws SQLException {
        String cod_manzana = varRequest.getParameter("cod_manzana");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";
        Manzana miManzana = new Manzana();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));

        switch (opcion) {
            case "registrar":
                miManzana.setManzana(varRequest.getParameter("manzana"));

                if (miManzana.getManzana() != "") {
                    verificarResultado(varCRUD.registrarManzana(miManzana), varJsonInformacion);
                }
                break;
            case "modificar":
                miManzana.setManzana(varRequest.getParameter("manzana"));
                verificarResultado(varCRUD.modificarManzana(miManzana, cod_manzana), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarManzana(cod_manzana), varJsonInformacion);
                break;

        }
    }
    private void getLocalEtapasManzanas(){
       
        JSONObject varJSONLocalidades=varCRUD.getListaLocalidad();
        JSONObject varJSONEtapas=varCRUD.getListaEtapa();
        JSONObject varJSONManzanas=varCRUD.getListaManzana();
        JSONObject varJSON = new JSONObject();
        varJSON.put("localidades",  varJSONLocalidades.get("data"));
        varJSON.put("etapas",  varJSONEtapas.get("data"));
        varJSON.put("manzanas",  varJSONManzanas.get("data"));
        varOut.print(varJSON);
        
        
        
    }

    private void CRUDTableTerreno() throws SQLException {
        String cod_terreno = varRequest.getParameter("cod_terreno");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";
        //Manzana miManzana = new Manzana();
        Terreno miTerreno = new Terreno();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));

        switch (opcion) {
            case "registrar":
                miTerreno.setLocalidad(varRequest.getParameter("SelectLocalidad").trim());
                miTerreno.setEtapa(varRequest.getParameter("SelectEtapa"));
                miTerreno.setManzana(varRequest.getParameter("SelectManzana").trim());
                miTerreno.setLote(varRequest.getParameter("SelectLote"));

                if (miTerreno.getLote() != "" && miTerreno.getEtapa() != "" && miTerreno.getManzana() != "" && miTerreno.getLocalidad() != "") {
                    verificarResultado(varCRUD.registrarTerreno(miTerreno), varJsonInformacion);
                }
                break;
            case "modificar":
                miTerreno.setLocalidad(varRequest.getParameter("SelectLocalidad"));
                miTerreno.setEtapa(varRequest.getParameter("SelectEtapa"));
                miTerreno.setManzana(varRequest.getParameter("SelectManzana"));
                miTerreno.setLote(varRequest.getParameter("SelectLote"));
                if (miTerreno.getLote() != "" && miTerreno.getEtapa() != "" && miTerreno.getManzana() != "" && miTerreno.getLocalidad() != "") {
                    verificarResultado(varCRUD.modificarTerreno(miTerreno, cod_terreno), varJsonInformacion);
                }

                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarTerreno(cod_terreno), varJsonInformacion);
                break;

        }
    }

    private void CRUDTableTipoEgresado() throws SQLException {
        String cod_tipo_egreso = varRequest.getParameter("cod_TipoEgreso");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";

        TipoEgreso miTipoEgreso = new TipoEgreso();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));

        switch (opcion) {
            case "registrar":
                miTipoEgreso.setTipo_egreso(varRequest.getParameter("TipoEgreso"));

                if (miTipoEgreso.getTipo_egreso() != "") {
                    verificarResultado(varCRUD.registrarTipoEgreso(miTipoEgreso), varJsonInformacion);
                }
                break;
            case "modificar":
                miTipoEgreso.setTipo_egreso(varRequest.getParameter("TipoEgreso"));
                verificarResultado(varCRUD.modificarTipoEgreso(miTipoEgreso, cod_tipo_egreso), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarTipoEgreso(cod_tipo_egreso), varJsonInformacion);
                break;
        }
    }

    private void CRUDTableSubTiposEgresados() throws SQLException {
        String cod_sub_tipo_egreso = varRequest.getParameter("cod_SubTipoEgreso");

        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";

        SubTipoEgreso miSubTipoEgreso = new SubTipoEgreso();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));
        switch (opcion) {
            case "registrar":
                miSubTipoEgreso.setSub_tipo_egreso(varRequest.getParameter("SubTipoEgreso"));
                miSubTipoEgreso.setCod_tipo_egreso(Integer.parseInt(varRequest.getParameter("SelectTipoEgreso").trim()));
                if (miSubTipoEgreso.getCod_tipo_egreso() != 0 && !"".equals(miSubTipoEgreso.getSub_tipo_egreso())) {
                    verificarResultado(varCRUD.registrarSubTipoEgreso(miSubTipoEgreso), varJsonInformacion);
                }
                break;
            case "modificar":
                miSubTipoEgreso.setSub_tipo_egreso(varRequest.getParameter("SubTipoEgreso"));
                miSubTipoEgreso.setCod_tipo_egreso(Integer.parseInt(varRequest.getParameter("SelectTipoEgreso").trim()));
                verificarResultado(varCRUD.modificarSubTipoEgreso(miSubTipoEgreso, cod_sub_tipo_egreso), varJsonInformacion);
                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarSubTipoEgreso(cod_sub_tipo_egreso), varJsonInformacion);
                break;
        }
    }

    private void CRUDTableEgresados() throws SQLException {
        String cod_egreso = varRequest.getParameter("cod_egreso");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";

        //SubTipoEgreso miSubTipoEgreso =new SubTipoEgreso();
        Egreso miEgreso = new Egreso();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));
        switch (opcion) {
            case "registrar":
                miEgreso.setCod_tipo_egreso(Integer.parseInt(varRequest.getParameter("SelectTipoEgreso").trim()));
                miEgreso.setCod_sub_tipo_egreso(Integer.parseInt(varRequest.getParameter("SelectSubTipoEgreso").trim()));
                miEgreso.setLocalidad(varRequest.getParameter("SelectLocalidad"));
                miEgreso.setEtapa(varRequest.getParameter("SelectEtapa"));
                miEgreso.setMonto_egreso(Integer.parseInt(varRequest.getParameter("monto_egreso").trim()));
                miEgreso.setTipo_comprobante(varRequest.getParameter("TipoComprobante"));
                miEgreso.setNota(varRequest.getParameter("nota"));

                if (miEgreso.getCod_tipo_egreso() != 0 && !"".equals(miEgreso.getCod_tipo_egreso())) {
                    verificarResultado(varCRUD.registrarEgreso(miEgreso), varJsonInformacion);
                }
                break;
            case "modificar":
                miEgreso.setCod_tipo_egreso(Integer.parseInt(varRequest.getParameter("SelectTipoEgreso").trim()));
                miEgreso.setCod_sub_tipo_egreso(Integer.parseInt(varRequest.getParameter("SelectSubTipoEgreso").trim()));
                miEgreso.setLocalidad(varRequest.getParameter("SelectLocalidad"));
                miEgreso.setEtapa(varRequest.getParameter("SelectEtapa"));
                miEgreso.setMonto_egreso(Integer.parseInt(varRequest.getParameter("monto_egreso").trim()));
                miEgreso.setTipo_comprobante(varRequest.getParameter("TipoComprobante"));
                miEgreso.setNota(varRequest.getParameter("nota"));
                if (cod_egreso!=null) {
                    verificarResultado(varCRUD.modificarEgreso(miEgreso, cod_egreso), varJsonInformacion);
                }

                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarEgreso(cod_egreso), varJsonInformacion);
                break;
        }

    }

}
