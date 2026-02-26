package com.mkayad.busjourney.domain;

import java.util.List;

public record RouteDto(String stopName, List<ArrivalDetail> arrivalDetails) {
}
