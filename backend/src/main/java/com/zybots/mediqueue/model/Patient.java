package com.zybots.mediqueue.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.Column;

@Entity
@Table(name = "patients")
public class Patient extends User {

    @Column(columnDefinition = "TEXT")
    private String medicalHistory;

    public Patient() {
        super();
        this.setRole(Role.PATIENT);
    }

    public String getMedicalHistory() { return medicalHistory; }
    public void setMedicalHistory(String medicalHistory) { this.medicalHistory = medicalHistory; }
}