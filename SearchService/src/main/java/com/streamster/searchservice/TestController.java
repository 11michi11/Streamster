package com.streamster.searchservice;


import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
public class TestController {

    @GetMapping
    String hello(Principal principal) {
        return "Hello " + principal.getName();
    }

}
