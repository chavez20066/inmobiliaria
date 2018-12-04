/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package VO;

/**
 *
 * @author ecalderon
 */
public class Venta {
    
    int cod_venta;
    String cod_cliente;
    int p_inscripcion;
    int p_inicial;
    int nro_cuotas;
    int monto_mensual;
    int cod_asesor;
    int monto_total;
    String nota;
    int cod_terreno;
    
    public Venta(){
        cod_venta=0;
        cod_cliente="";
        p_inscripcion=0;
        p_inicial=0;
        nro_cuotas=0;
        monto_mensual=0;
        cod_asesor=0;
        monto_total=0;
        nota="";     
        cod_terreno=0;
    }

    public int getCod_terreno() {
        return cod_terreno;
    }

    public void setCod_terreno(int idTerreno) {
        this.cod_terreno = idTerreno;
    }   

    public int getCod_asesor() {
        return cod_asesor;
    }

    public void setCod_asesor(int cod_asesor) {
        this.cod_asesor = cod_asesor;
    } 
    public int getCod_venta() {
        return cod_venta;
    }

    public void setCod_venta(int cod_venta) {
        this.cod_venta = cod_venta;
    }

    public String getCod_cliente() {
        return cod_cliente;
    }

    public void setCod_cliente(String cod_cliente) {
        this.cod_cliente = cod_cliente;
    }

    public int getP_inscripcion() {
        return p_inscripcion;
    }

    public void setP_inscripcion(int p_inscripcion) {
        this.p_inscripcion = p_inscripcion;
    }

    public int getP_inicial() {
        return p_inicial;
    }

    public void setP_inicial(int p_inicial) {
        this.p_inicial = p_inicial;
    }

    public int getNro_cuotas() {
        return nro_cuotas;
    }

    public void setNro_cuotas(int nro_cuotas) {
        this.nro_cuotas = nro_cuotas;
    }

    public int getMonto_mensual() {
        return monto_mensual;
    }

    public void setMonto_mensual(int monto_mensual) {
        this.monto_mensual = monto_mensual;
    }

   

    public int getMonto_total() {
        return monto_total;
    }

    public void setMonto_total(int monto_total) {
        this.monto_total = monto_total;
    }

    public String getNota() {
        return nota;
    }

    public void setNota(String nota) {
        this.nota = nota;
    }
    
    
    
}
