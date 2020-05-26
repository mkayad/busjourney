package com.mkayad.busjourney.controllers

import com.mkayad.busjourney.domain.ArrivalDetail
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.client.HttpClientErrorException
import org.springframework.web.client.RestTemplate
import java.lang.Exception

@Controller
class MainController {

    @Value("\${stop.g.url}")
    lateinit var stopGUrl:String

    @Value("\${stop.h.url}")
    lateinit var stopHUrl:String


    val restTemplate=RestTemplate()

    @GetMapping("/")
    fun index(model:Model):String {
        model.addAttribute("stopGTimes",getArrivalTimes(stopGUrl))

        model.addAttribute("stopHTimes",getArrivalTimes(stopHUrl))

        return "index"
    }

    fun getArrivalTimes(url:String):Iterable<ArrivalDetail>?{
        val stopGResponse: ResponseEntity<Array<ArrivalDetail>>? = restTemplate.getForEntity(url, Array<ArrivalDetail>::class.java)

        val nextDueBusesForStopG: Array<ArrivalDetail>? = stopGResponse?.body

        return nextDueBusesForStopG?.asList()?.sortedBy { it.timeToStation }
    }
}


