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
public class Visita {

    int cod_visita;
    String cod_localidad;
    String cod_etapa;
    String cod_candidato;
    String cod_asesor;
    String fecha_tentativa;
    String nota;
    String Estado;
    
    public Visita(){
        cod_visita=0;
        cod_localidad="";
        cod_etapa="";
        cod_candidato="";
        cod_asesor="";
        fecha_tentativa="";
        nota="";
        Estado="";      
        
    }

    public int getCod_visita() {
        return cod_visita;
    }

    public void setCod_visita(int cod_visita) {
        this.cod_visita = cod_visita;
    }

    public String getCod_localidad() {
        return cod_localidad;
    }

    public void setCod_localidad(String cod_localidad) {
        this.cod_localidad = cod_localidad;
    }

    public String getCod_etapa() {
        return cod_etapa;
    }

    public void setCod_etapa(String cod_etapa) {
        this.cod_etapa = cod_etapa;
    }

    public String getCod_candidato() {
        return cod_candidato;
    }

    public void setCod_candidato(String cod_candidato) {
        this.cod_candidato = cod_candidato;
    }

    public String getCod_asesor() {
        return cod_asesor;
    }

    public void setCod_asesor(String cod_asesor) {
        this.cod_asesor = cod_asesor;
    }

    public String getFecha_tentativa() {
        return fecha_tentativa;
    }

    public void setFecha_tentativa(String fecha_tentativa) {
        this.fecha_tentativa = fecha_tentativa;
    }

    public String getNota() {
        return nota;
    }

    public void setNota(String nota) {
        this.nota = nota;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

}
