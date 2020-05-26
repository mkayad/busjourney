package com.mkayad.busjourney.controllers

import com.mkayad.busjourney.domain.ArrivalDetail
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.junit.jupiter.SpringExtension
import org.springframework.ui.ExtendedModelMap
import org.springframework.ui.Model


@ExtendWith(SpringExtension::class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class MainControllerUnitTest {

    @Autowired
    lateinit var mainController: MainController

    @DisplayName("should return a non empty list ")
    @Test
    fun testValidUrlResult() {
        val model: Model = ExtendedModelMap()
        val response=mainController.index(model)

        assert(response=="index")

        val stopGTimes:List<ArrivalDetail>?=model.getAttribute("stopGTimes") as? List<ArrivalDetail>
        val stopHTimes:List<ArrivalDetail>?=model.getAttribute("stopHTimes") as? List<ArrivalDetail>

        assertTrue(stopGTimes?.isNotEmpty()!!)
        assertTrue(stopHTimes?.isNotEmpty()!!)
    }




}
