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
public class Egreso {
    int cod_egreso;
    int cod_tipo_egreso;
    int cod_sub_tipo_egreso;
    String localidad;
    String Etapa;
    int monto_egreso;
    String tipo_comprobante;
    String nota;

    public int getCod_egreso() {
        return cod_egreso;
    }

    public void setCod_egreso(int cod_egreso) {
        this.cod_egreso = cod_egreso;
    }

    public int getCod_tipo_egreso() {
        return cod_tipo_egreso;
    }

    public void setCod_tipo_egreso(int cod_tipo_egreso) {
        this.cod_tipo_egreso = cod_tipo_egreso;
    }

    public int getCod_sub_tipo_egreso() {
        return cod_sub_tipo_egreso;
    }

    public void setCod_sub_tipo_egreso(int cod_sub_tipo_egreso) {
        this.cod_sub_tipo_egreso = cod_sub_tipo_egreso;
    }

    public String getLocalidad() {
        return localidad;
    }

    public void setLocalidad(String localidad) {
        this.localidad = localidad;
    }

    public String getEtapa() {
        return Etapa;
    }

    public void setEtapa(String Etapa) {
        this.Etapa = Etapa;
    }

    public int getMonto_egreso() {
        return monto_egreso;
    }

    public void setMonto_egreso(int monto_egreso) {
        this.monto_egreso = monto_egreso;
    }

    public String getTipo_comprobante() {
        return tipo_comprobante;
    }

    public void setTipo_comprobante(String tipo_comprobante) {
        this.tipo_comprobante = tipo_comprobante;
    }

    public String getNota() {
        return nota;
    }

    public void setNota(String nota) {
        this.nota = nota;
    }
    
    
    
    
}
