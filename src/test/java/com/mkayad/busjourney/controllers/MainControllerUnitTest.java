package com.mkayad.busjourney.controllers;

import com.mkayad.busjourney.domain.ArrivalDetail;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.ui.ExtendedModelMap;


import java.util.List;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;


@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class MainControllerUnitTest {

    @Autowired
    private MainController  aMainController;

    @DisplayName("should return a non empty list ")
    @Test
    public void testValidUrlResult() {
        var model = new ExtendedModelMap();
        var response=aMainController.index(model);

        assert(response.equals("index"));

        List<ArrivalDetail> stopGTimes= (List<ArrivalDetail>) model.getAttribute("stopGTimes");
        List<ArrivalDetail> stopHTimes= (List<ArrivalDetail>) model.getAttribute("stopHTimes");

        assertFalse(stopGTimes.isEmpty());
        assertFalse(stopHTimes.isEmpty());
    }




}
