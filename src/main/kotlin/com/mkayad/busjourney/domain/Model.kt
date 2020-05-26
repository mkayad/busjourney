package com.mkayad.busjourney.domain

/**
 * A class setup for mapping the response from TFL endpoint
 */
data class ArrivalDetail(
        val lineName: String,
        val platformName: String,
        val destinationName: String,
        val timeToStation: Int)
