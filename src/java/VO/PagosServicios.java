/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package VO;

/**
 *
 * @author jbasurco
 */
public class PagosServicios {

    String[] pagoLuz;
    String[] pagoAgua;
    String[] pagoSeguridad;
    String PrecioMensual;
    String AnioPagoLuz;
    String AnioPagoAgua;
    String AnioPagoSeguridad;

    public String getAnioPagoLuz() {
        return AnioPagoLuz;
    }

    public void setAnioPagoLuz(String AnioPagoLuz) {
        this.AnioPagoLuz = AnioPagoLuz;
    }

    public String getAnioPagoAgua() {
        return AnioPagoAgua;
    }

    public void setAnioPagoAgua(String AnioPagoAgua) {
        this.AnioPagoAgua = AnioPagoAgua;
    }

    public String getAnioPagoSeguridad() {
        return AnioPagoSeguridad;
    }

    public void setAnioPagoSeguridad(String AnioPagoSeguridad) {
        this.AnioPagoSeguridad = AnioPagoSeguridad;
    }

    public PagosServicios() {
        pagoLuz = null;
        pagoAgua = null;
        pagoSeguridad = null;
        PrecioMensual = "";
    }

    public String[] getPagoLuz() {
        return pagoLuz;
    }

    public void setPagoLuz(String[] pagoLuz) {
        this.pagoLuz = pagoLuz;
    }

    public String[] getPagoAgua() {
        return pagoAgua;
    }

    public void setPagoAgua(String[] pagoAgua) {
        this.pagoAgua = pagoAgua;
    }

    public String[] getPagoSeguridad() {
        return pagoSeguridad;
    }

    public void setPagoSeguridad(String[] pagoSeguridad) {
        this.pagoSeguridad = pagoSeguridad;
    }

    public String getPrecioMensual() {
        return PrecioMensual;
    }

    public void setPrecioMensual(String PrecioMensual) {
        this.PrecioMensual = PrecioMensual;
    }

}
