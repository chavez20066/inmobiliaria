/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import DAO.CRUD;
import VO.Asesor;
import VO.Egreso;
import VO.Pago;
import VO.PagosServicios;
import VO.PagosUnicos;
import VO.Usuario;
import VO.Venta;
import com.google.gson.Gson;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
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
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 *
 * @author jbasurco
 */
public class ControlServletV extends HttpServlet {

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
        String dniCliente = "";
        String codTerreno = "";
        String cod_venta = "";
        try {
            varRequest = request;
            varResponse = response;
            varSession = request.getSession();
            varOut = varResponse.getWriter();
            String opcion = varRequest.getParameter("parAccion");
            switch (opcion) {
                case "vConsultaCliente":
                    String dni = varRequest.getParameter("dni");
                    JSONObject varJSONDatosCliente = varCRUD.getCliente(dni);
                    varOut.print(varJSONDatosCliente);
                    break;
                case "guardarVentas":
                    CRUDTableVentas();
                    break;
                case "verficaTerreno":
                    verificaTerreno();
                    break;
                case "vGuardarTrans":
                    GuardarTransferencia();
                    break;
                case "getEstadoCuenta":
                    dniCliente = varRequest.getParameter("cod_cliente");
                    codTerreno = varRequest.getParameter("cod_terreno");

                    JSONObject varJSONEstadoCuenta = varCRUD.getEstadoCuenta(dniCliente, codTerreno);
                    varOut.print(varJSONEstadoCuenta);
                    break;
                case "listaCuotas":

                    cod_venta = varRequest.getParameter("cod_venta");
                    JSONObject varJSONCuotas = varCRUD.getListaCuotas(cod_venta);
                    varOut.print(varJSONCuotas);
                    break;
                case "vConsultaClienteTotal":
                    cod_venta = varRequest.getParameter("cod_venta");
                    JSONObject varJSONDeudaTotal = varCRUD.getDeudaTotal(cod_venta);
                    varOut.print(varJSONDeudaTotal);
                    break;
                case "getAnios":
                    cod_venta = varRequest.getParameter("cod_venta");
                    JSONObject varJSONAnios = varCRUD.getAnios(cod_venta);
                    varOut.print(varJSONAnios);
                    break;
                case "getServicioLuz":
                    cod_venta = varRequest.getParameter("cod_venta");
                    String anio_Luz = varRequest.getParameter("anio_luz");
                    JSONObject varJSONSerLuz = varCRUD.getServicioLuz(cod_venta, anio_Luz);
                    varOut.print(varJSONSerLuz);
                    break;
                case "getServicioAgua":
                    cod_venta = varRequest.getParameter("cod_venta");
                    String anio_agua = varRequest.getParameter("anio_agua");
                    JSONObject varJSONSerAgua = varCRUD.getServicioAgua(cod_venta, anio_agua);
                    varOut.print(varJSONSerAgua);
                    break;
                case "getServicioSeguridad":
                    cod_venta = varRequest.getParameter("cod_venta");
                    String anio_seguridad = varRequest.getParameter("anio_seguridad");
                    JSONObject varJSONSerSeguridad = varCRUD.getServicioSeguridad(cod_venta, anio_seguridad);
                    varOut.print(varJSONSerSeguridad);
                    break;
                case "guardarPago":
                    /*cod_venta = varRequest.getParameter("cod_venta");
                    String anio_seguridad = varRequest.getParameter("anio_seguridad");
                    JSONObject varJSONSerSeguridad = varCRUD.getServicioSeguridad(cod_venta, anio_seguridad);
                    varOut.print(varJSONSerSeguridad);*/
                    guardarPago();
                    break;
                case "setValorDefecto":
                    /*cod_venta = varRequest.getParameter("cod_venta");
                    String anio_seguridad = varRequest.getParameter("anio_seguridad");
                    JSONObject varJSONSerSeguridad = varCRUD.getServicioSeguridad(cod_venta, anio_seguridad);
                    varOut.print(varJSONSerSeguridad);*/
                    guardarValorDefecto();
                    break;
                case "getvalorDefecto":
                    /*cod_venta = varRequest.getParameter("cod_venta");
                    String anio_seguridad = varRequest.getParameter("anio_seguridad");
                    JSONObject varJSONSerSeguridad = varCRUD.getServicioSeguridad(cod_venta, anio_seguridad);*/
                    varOut.print(varCRUD.getvalorDefecto());
                    break;
                case "listaUsuarios":
                    varOut.print(varCRUD.getListaUsuarios());
                    break;
                case "guardarUsuario":
                    CRUDTableUsuario();
                    break;
                case "olap":
                    getDataOlap();
                    break;
            }

        } finally {
            out.close();
        }
    }

    private void CRUDTableUsuario() throws SQLException {
        String dni = varRequest.getParameter("cod_dni");
        String opcion = varRequest.getParameter("opcion");
        //String nombre = "", apellidos = "", dni = "";

        //SubTipoEgreso miSubTipoEgreso =new SubTipoEgreso();
        Usuario miUsuario = new Usuario();

        JSONObject varJsonInformacion = new JSONObject();
        //varJsonObjectP.put("idusuario", varResultado.getString("idusuario"));
        switch (opcion) {
            case "registrar":
                miUsuario.setNombres(varRequest.getParameter("nombres").trim());
                miUsuario.setApellidos(varRequest.getParameter("apellidos").trim());
                miUsuario.setDni(varRequest.getParameter("dni").trim());
                miUsuario.setContrasenia(varRequest.getParameter("contrasenia").trim());
                miUsuario.setTipo_usuario(varRequest.getParameter("SelectTipoUsuario").trim());

                if (miUsuario.getDni() != "" && !"".equals(miUsuario.getContrasenia())) {
                    verificarResultado(varCRUD.registrarUsuario(miUsuario), varJsonInformacion);
                }
                break;
            case "modificar":
                miUsuario.setNombres(varRequest.getParameter("nombres").trim());
                miUsuario.setApellidos(varRequest.getParameter("apellidos").trim());
                miUsuario.setContrasenia(varRequest.getParameter("contrasenia").trim());
                miUsuario.setTipo_usuario(varRequest.getParameter("SelectTipoUsuario").trim());

                if (dni != null) {
                    verificarResultado(varCRUD.modificarUsuario(miUsuario, dni), varJsonInformacion);
                }

                break;
            case "eliminar":
                verificarResultado(varCRUD.eliminarUsuario(dni), varJsonInformacion);
                break;
        }
    }

    private void guardarValorDefecto() {
        try {
            JSONObject varJsonInformacion = new JSONObject();
            int pagoServicio = Integer.parseInt(varRequest.getParameter("pagoMensual").trim());

            verificarResultado(varCRUD.modificarValoresDefecto(pagoServicio), varJsonInformacion);
        } catch (SQLException ex) {
            Logger.getLogger(ControlServletV.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void getDataOlap() throws SQLException {

        try {
            JSONArray varJsonArrayP = new JSONArray();

            varJsonArrayP = varCRUD.GetDataOLAP();

            String Directorio = getServletContext().getRealPath("administrador/data/");
            String ruta = Directorio + "\\data_json.json";
            //String ruta = Directorio + "/data_json.json";
            File archivo = new File(ruta);
            BufferedWriter bw;
            if (archivo.exists()) {
                archivo.delete();
                bw = new BufferedWriter(new FileWriter(archivo));
                bw.write(varJsonArrayP.toString());
            } else {
                bw = new BufferedWriter(new FileWriter(archivo));
                bw.write(varJsonArrayP.toString());
            }
            bw.close();

            // varResponse.sendRedirect("/bibliografia/administrador/olap");
            // varOut.print(varJSONbibliografia);
        } catch (IOException ex) {
            Logger.getLogger(ControlServletV.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void guardarPago() throws SQLException {
        final Gson gson = new Gson();

        final String JSON_PagosUnicos = varRequest.getParameter("PagosUnicos");
        final String JSON_TipoPago = varRequest.getParameter("TipoPago");
        final String JSON_pagosMServicios = varRequest.getParameter("pagosMServicios");
        String cod_venta = varRequest.getParameter("cod_venta");

        final PagosUnicos misPagosUnicos = gson.fromJson(JSON_PagosUnicos, PagosUnicos.class);
        final Pago misPagos = gson.fromJson(JSON_TipoPago, Pago.class);
        final PagosServicios misPagosServicios = gson.fromJson(JSON_pagosMServicios, PagosServicios.class);

        varCRUD.registrarPagosUnicos(misPagosUnicos, cod_venta);
        varCRUD.registrarPagos(misPagos, cod_venta);
        varCRUD.registrarPagosServicios(misPagosServicios, cod_venta);

    }

    public void GuardarTransferencia() {
        JSONObject varJsonInformacion = new JSONObject();
        try {
            String dniVendedor = varRequest.getParameter("dniVendedor");
            String dniComprador = varRequest.getParameter("dniComprador");
            int comision = Integer.parseInt(varRequest.getParameter("comision"));
            String cod_terreno = varRequest.getParameter("cod_terreno");

            int cod_venta = varCRUD.getVenta(dniVendedor, cod_terreno);

            if (dniVendedor != "" && dniComprador != "" && comision != 0) {
                int codigo_trans = varCRUD.registrarTransferencia(cod_venta, dniVendedor, dniComprador, comision);
                if (codigo_trans != 0) {
                    varJsonInformacion.put("respuesta", "BIEN");
                    varJsonInformacion.put("codigoTrans", codigo_trans);
                } else {
                    varJsonInformacion.put("respuesta", "ERROR");
                }
                varOut.print(varJsonInformacion);
            } else {
                verificarResultado(0, varJsonInformacion);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ControlServletV.class.getName()).log(Level.SEVERE, null, ex);
            varJsonInformacion.put("respuesta", "ERROR");
        }
    }

    public int verificaTerreno() {
        //{"idLocalidad": idLocalidad,"idEtapa":idEtapa,"idManzana":idManzana,"lote":lote}
        String idLocalidad = varRequest.getParameter("idLocalidad");
        String idEtapa = varRequest.getParameter("idEtapa");
        String idManzana = varRequest.getParameter("idManzana");
        String lote = varRequest.getParameter("lote");

        return varCRUD.getIDTerreno(idLocalidad, idEtapa, idManzana, lote);

    }

    public void CRUDTableVentas() throws SQLException {
        //dni=71216502&dnidb=71216502&SelectLocalidad=CHIGUATA&SelectEtapa=ETAPA+2
        //&SelectMZ=A&lote=45&pInscripcion=100&precio=1500&pInicial=100&cuota=on&NroCuota=10&
        //CuotaMensual=450&SelectAsesor=1&nota=notas

        Venta miVenta = new Venta();
        JSONObject varJsonInformacion = new JSONObject();

        String idLocalidad = varRequest.getParameter("SelectLocalidad");
        String idEtapa = varRequest.getParameter("SelectEtapa");
        String idManzana = varRequest.getParameter("SelectMZ");
        String lote = varRequest.getParameter("SelectLote");
        miVenta.setCod_cliente(varRequest.getParameter("dnidb"));
        miVenta.setP_inscripcion(Integer.parseInt(varRequest.getParameter("pInscripcion")));
        miVenta.setP_inicial(Integer.parseInt(varRequest.getParameter("pInicial")));
        //miVenta.setMonto_mensual(Integer.parseInt(varRequest.getParameter("CuotaMensual")));
        miVenta.setCod_asesor(Integer.parseInt(varRequest.getParameter("SelectAsesor")));
        miVenta.setMonto_total(Integer.parseInt(varRequest.getParameter("precio")));
        miVenta.setNota(varRequest.getParameter("nota"));
        // miVenta.setCod_terreno(varRequest.getParameter("idTerreno"));
        int cod_terreno = varCRUD.getIDTerreno(idLocalidad, idEtapa, idManzana, lote);
        if (cod_terreno != 0) {

            miVenta.setCod_terreno(cod_terreno);
            String encuotas = varRequest.getParameter("cuota");
            if (encuotas.equals("on")) {
                miVenta.setNro_cuotas(Integer.parseInt(varRequest.getParameter("NroCuota")));
            }

            if (miVenta.getCod_cliente() != "" && miVenta.getP_inscripcion() != 0 && miVenta.getP_inicial() != 0 && miVenta.getCod_asesor() != 0
                    && miVenta.getMonto_total() != 0 && miVenta.getNota() != "" && miVenta.getCod_terreno() != 0) {
                //verificarResultado(varCRUD.registrarVenta(miVenta), varJsonInformacion);
                int codigo_venta = varCRUD.registrarVenta(miVenta);
                varSession.setAttribute("cod_venta", codigo_venta);
                if (codigo_venta != 0) {
                    varJsonInformacion.put("respuesta", "BIEN");
                    varJsonInformacion.put("codigoVenta", codigo_venta);
                } else {
                    varJsonInformacion.put("respuesta", "ERROR");
                }
                varOut.print(varJsonInformacion);
            }
        } else {
            verificarResultado(0, varJsonInformacion);
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
            Logger.getLogger(ControlServletV.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ControlServletV.class.getName()).log(Level.SEVERE, null, ex);
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

}
