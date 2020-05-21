package com.mkayad.busjourney.domain

data class ArrivalDetail(
        val lineName: String,
        val platformName: String,
        val destinationName: String,
        val timeToStation: Int)
