package com.mkayad.busjourney.controllers;

import com.mkayad.busjourney.domain.ArrivalDetail;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import java.util.Comparator;
import java.util.List;

@Controller
public class MainController {

    @Value("${stop.g.url}")
    String stopGUrl;

    @Value("${stop.h.url}")
    String stopHUrl;


    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("stopGTimes",getArrivalTimes(stopGUrl));
        model.addAttribute("stopHTimes",getArrivalTimes(stopHUrl));
        return "index";
    }

    private List<ArrivalDetail> getArrivalTimes(String url) {
        System.out.println("getArrivalTimes for "+url+"\n");
        var response = restTemplate.getForEntity(url, ArrivalDetail[].class);
        List<ArrivalDetail> arrivalDetails = List.of(response.getBody());
        arrivalDetails.forEach(System.out::println);


        if (arrivalDetails != null) {
            return arrivalDetails.stream()
                    .sorted(Comparator.comparing(ArrivalDetail::timeToStation))
                    .toList();
        }
        return List.of();
    }
}


