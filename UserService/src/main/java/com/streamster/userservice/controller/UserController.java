package com.streamster.userservice.controller;

import com.streamster.userservice.model.SystemRoleType;
import com.streamster.userservice.model.User;
import com.streamster.userservice.model.dto.RegistrationDTO;
import com.streamster.userservice.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
public class UserController {

    final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/test")
    ResponseEntity<String> test() {
        return new ResponseEntity<>("SUCCESS",HttpStatus.OK);
    }

    @PostMapping("/register")
    ResponseEntity<String> register(@RequestBody RegistrationDTO registrationDTO) {
        userService.register(User.fromRegistrationDTO(registrationDTO.encryptPassword()));
        return new ResponseEntity<>("The account was created successfully", HttpStatus.CREATED);
    }

    @PreAuthorize("hasAuthority(T(com.streamster.userservice.model.SystemRoleType).ADMIN)")
    @PutMapping("/updateSystemRole/{userId}/{role}")
    ResponseEntity<String> updateSystemRole(@PathVariable String userId, @PathVariable SystemRoleType role) {
        userService.updateSystemRole(userId,role);
        return new ResponseEntity<>("The role has been updated", HttpStatus.OK);
    }
}
