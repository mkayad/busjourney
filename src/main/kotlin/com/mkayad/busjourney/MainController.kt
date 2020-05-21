package com.mkayad.busjourney

import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpMethod
import org.springframework.http.MediaType
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.client.RestTemplate

@Controller
class MainController {
    //settup the call

    val stopGUrl="https://api.tfl.gov.uk/StopPoint/490000091G/arrivals?mode=bus"
    val stopHUrl="https://api.tfl.gov.uk/StopPoint/490000091H/arrivals?mode=bus"
    val restTemplate=RestTemplate()
    val headers = HttpHeaders()

    @GetMapping("/")
    fun index(model:Model):String {
        //improve the layout

        val nextDueBusesForStopG=getArrivalTimes(stopGUrl)
        val nextDueBusesForStopH=getArrivalTimes(stopHUrl)
        //nextDueBusesForStopG?.forEach { print(it) }
        nextDueBusesForStopH?.forEach { print(it) }
        //model.addAttribute("times",nextDueBusesForStopH)
        val allTimes=nextDueBusesForStopG?.plus(nextDueBusesForStopH!!)?.sortedBy { it.timeToStation }
        //allTimes.sortedBy { it.timeToStation }
        model.addAttribute("times",allTimes)

        return "index"
    }

    fun getArrivalTimes(url:String):Iterable<Result>?{
        val stopGResponse=restTemplate.getForEntity(url,Array<Result>::class.java)
        val nextDueBusesForStopG=stopGResponse.body
        return  nextDueBusesForStopG?.asList()
    }
}
 data class Result(
    val lineName: String,
    val platformName: String,
    val destinationName: String,
    val timeToStation: Int)

