package com.gestionhotel.model;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "chambre")
public class Chambre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String numero;

    private String type; // SIMPLE, DOUBLE, SUITE

    @Column(name = "prix_nuit")
    private BigDecimal prixNuit;

    private int capacite;

    @Lob
    private String description;

    private String statut; // DISPONIBLE, OCCUPEE, INDISPONIBLE

    @Column(name = "photo_path")
    private String photoPath;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getPrixNuit() {
        return prixNuit;
    }

    public void setPrixNuit(BigDecimal prixNuit) {
        this.prixNuit = prixNuit;
    }

    public int getCapacite() {
        return capacite;
    }

    public void setCapacite(int capacite) {
        this.capacite = capacite;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }
}
