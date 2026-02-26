package com.mkayad.busjourney.controllers;

import com.mkayad.busjourney.domain.ArrivalDetail;
import com.mkayad.busjourney.domain.RouteDto;
import com.mkayad.busjourney.entity.BusRoute;
import com.mkayad.busjourney.repository.BusRouteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Controller
public class MainController {

//    @Value("${stop.g.url}")
//    String stopGUrl;
//
//    @Value("${stop.h.url}")
//    String stopHUrl;

    @Autowired
    private BusRouteRepository busRouteRepository;
    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/")
    public String index(Model model) {
        var routes=busRouteRepository.findAll();
        var routeDtos=new ArrayList<>();
        routes.forEach(busRoute -> {
            routeDtos.add(new RouteDto(busRoute.getStopName(),getArrivalTimes(busRoute.getStopName())));
        });
        System.out.println(routeDtos);
        model.addAttribute("routes",routeDtos);
        return "index";
    }

    private List<ArrivalDetail> getArrivalTimes(String stopName) {
        var url="https://api.tfl.gov.uk/StopPoint/"+stopName+"/arrivals?mode=bus";
        var response = restTemplate.getForEntity(url, ArrivalDetail[].class);
        List<ArrivalDetail> arrivalDetails = List.of(response.getBody());

        return arrivalDetails.stream()
                .sorted(Comparator.comparing(ArrivalDetail::timeToStation))
                .toList();
    }

    public BusRouteRepository getBusRouteRepository() {
        return busRouteRepository;
    }

    public void setBusRouteRepository(BusRouteRepository busRouteRepository) {
        this.busRouteRepository = busRouteRepository;
    }
}

