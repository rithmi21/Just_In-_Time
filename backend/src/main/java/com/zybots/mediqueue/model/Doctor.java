package com.zybots.mediqueue.model;

import jakarta.persistence.*;

@Entity
@Table(name = "doctors")
public class Doctor extends User {

    private String specialization;
   
    @Column(name = "base_consultation_duration")
    private Integer baseConsultationDuration = 10;

    @Enumerated(EnumType.STRING)
    @Column(name = "current_status")
    private DoctorStatus currentStatus = DoctorStatus.ACTIVE;

    public Doctor() {
        super();
        this.setRole(Role.DOCTOR);
    }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public Integer getBaseConsultationDuration() { return baseConsultationDuration; }
    public void setBaseConsultationDuration(Integer baseConsultationDuration) { this.baseConsultationDuration = baseConsultationDuration; }

    public DoctorStatus getCurrentStatus() { return currentStatus; }
    public void setCurrentStatus(DoctorStatus currentStatus) { this.currentStatus = currentStatus; }
}
