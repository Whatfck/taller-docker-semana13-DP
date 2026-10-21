package com.ecoair;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class EcoAirApplication {

    public static void main(String[] args) {
        SpringApplication.run(EcoAirApplication.class, args);
    }

    @GetMapping("/")
    public String health() {
        return "eco-air-backend OK";
    }
}