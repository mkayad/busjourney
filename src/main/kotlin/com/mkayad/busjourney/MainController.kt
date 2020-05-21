package com.mkayad.busjourney

import com.mkayad.busjourney.domain.ArrivalDetail
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.client.RestTemplate

@Controller
class MainController {

    val stopGUrl="https://api.tfl.gov.uk/StopPoint/490000091G/arrivals?mode=bus"
    val stopHUrl="https://api.tfl.gov.uk/StopPoint/490000091H/arrivals?mode=bus"
    val restTemplate=RestTemplate()

    @GetMapping("/")
    fun index(model:Model):String {

//        val nextDueBusesForStopG=getArrivalTimes(stopGUrl)
//        val nextDueBusesForStopH=getArrivalTimes(stopHUrl)
//        //nextDueBusesForStopG?.forEach { print(it) }
//        nextDueBusesForStopH?.forEach { print(it) }
//        //model.addAttribute("hAndGStopsCombinedTimes",nextDueBusesForStopH)
//        val allTimes=nextDueBusesForStopG?.plus(nextDueBusesForStopH!!)?.sortedBy { it.timeToStation }
//        //allTimes.sortedBy { it.timeToStation }
       // model.addAttribute("hAndGStopsCombinedTimes",allTimes)
        model.addAttribute("gStopTimes",getArrivalTimes(stopGUrl))
        model.addAttribute("hStopTimes",getArrivalTimes(stopHUrl))

        return "index"
    }

    fun getArrivalTimes(url:String):Iterable<ArrivalDetail>?{
        val stopGResponse=restTemplate.getForEntity(url,Array<ArrivalDetail>::class.java)
        val nextDueBusesForStopG=stopGResponse.body
        return  nextDueBusesForStopG?.asList()
    }
}


