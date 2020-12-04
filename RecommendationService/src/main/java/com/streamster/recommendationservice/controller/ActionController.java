package com.streamster.recommendationservice.controller;

import com.streamster.recommendationservice.service.ActionService;
import com.streamster.recommendationservice.model.dto.ActionDTO;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;

@Log4j2
@RestController
@RequestMapping("/action")
public class ActionController {

//    private final ActionService actionService;
//
//    public ActionController(ActionService actionService) {
//        this.actionService = actionService;
//    }
//
//    @PostMapping()
//    public ResponseEntity<String> addWatchAction(Principal principal, @Valid @RequestBody ActionDTO action) {
//        this.actionService.addAction(action,principal.getName());
//        return new ResponseEntity<>(HttpStatus.CREATED);
//    }
}
