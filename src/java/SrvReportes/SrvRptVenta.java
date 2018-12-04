/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SrvReportes;

import DAO.CRUD;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.util.JRLoader;

/**
 *
 * @author Diego
 */
public class SrvRptVenta extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CRUD varCRUD=new CRUD();
        response.setContentType("application/pdf");

        ServletOutputStream out = response.getOutputStream();
       
         try{
             
                String cod_venta=request.getSession().getAttribute("cod_venta").toString();
               JasperReport reporte = (JasperReport) JRLoader.loadObject(getServletContext().getRealPath("Reportes/rptVenta.jasper"));

                Map<String, Object> parametros = new HashMap();
                parametros.clear();
               // parametros.put("CodigoDocente", request.getParameter("CodDocente"));
                parametros.put("COD_VENTA", cod_venta);

              /* Map<String, Object> parametros = new HashMap();
               parametros.put("autor", "Juan");
               parametros.put("titulo", "Reporte");*/
                varCRUD.abrirConsulta();
               JasperPrint jasperPrint = JasperFillManager.fillReport(reporte, parametros, varCRUD.getConexion());
               JRExporter exporter = new JRPdfExporter();
               exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
               exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, out);
               exporter.exportReport();

               varCRUD.cerrarConsulta();
            }                
            catch (Exception e)
            {
                 request.getSession(false);               
                request.getSession().getMaxInactiveInterval();

                 response.sendRedirect("/inmobiliaria/");
                e.printStackTrace();
            }
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
        processRequest(request, response);
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
        processRequest(request, response);
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
