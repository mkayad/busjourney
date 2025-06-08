package com.mkayad.busjourney.domain;

/**
 * A class setup for mapping the response from TFL endpoint
 */
public record ArrivalDetail(
        String lineName,
        String platformName,
        String destinationName,
        int timeToStation){}
