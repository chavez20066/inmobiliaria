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
public class Pago {

    String tipo;
    cuota[] cuotas;
    String Monto;

    public Pago() {
        tipo = "0";
        cuotas = null;
        Monto = "0";
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public cuota[] getCuotas() {
        return cuotas;
    }

    public void setCuotas(cuota[] cuotas) {
        this.cuotas = cuotas;
    }

    public String getMonto() {
        return Monto;
    }

    public void setMonto(String Monto) {
        this.Monto = Monto;
    }

}
