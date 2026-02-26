package com.mkayad.busjourney.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "bus_routes")
public class BusRoute {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String stopName;


    public BusRoute() {}

    public BusRoute(String stopName) {
        this.stopName = stopName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStopName() {
        return stopName;
    }
}
