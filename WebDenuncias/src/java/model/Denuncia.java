/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
/**
 *
 * @author raiza
 */

public class Denuncia {

    private int id;
    private String titulo;
    private String descripcion;
    private String ubicacion;
    private String estado;
    private String ciudadano;
    private String telefonoCiudadano;
    private Timestamp fechaRegistro;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getUbicacion() {
        return ubicacion;
    }
    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public String getEstado() {
        return estado;
    }
    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCiudadano() {
        return ciudadano;
    }
    public void setCiudadano(String ciudadano) {
        this.ciudadano = ciudadano;
    }

    public String getTelefonoCiudadano() {
        return telefonoCiudadano;
    }
    public void setTelefonoCiudadano(String telefonoCiudadano) {
        this.telefonoCiudadano = telefonoCiudadano;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }
    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
}

