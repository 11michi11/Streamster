package com.streamster.userservice.controller;

import com.streamster.userservice.model.SystemRoleType;
import com.streamster.userservice.model.User;
import com.streamster.userservice.model.dto.RegistrationDTO;
import com.streamster.userservice.model.view.UserView;
import com.streamster.userservice.repository.UserRepository;
import com.streamster.userservice.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/users")
public class UserController {

    final UserService userService;
    final UserRepository userRepository;

    public UserController(UserService userService, UserRepository userRepository) {
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @GetMapping("/test")
    ResponseEntity<String> test() {
        return new ResponseEntity<>("SUCCESS",HttpStatus.OK);
    }

    @GetMapping("/userDetails")
    ResponseEntity<UserView> getUserDetails(Principal principal) {
        User currentUser = userService.getUserByEmail(principal.getName());
        return new ResponseEntity<>(currentUser.toUserView(), HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority(T(com.streamster.userservice.model.SystemRoleType).ADMIN)")
    @GetMapping
    ResponseEntity<List<UserView>> getAllUsers() {
        List<User> users = userRepository.findAll();
        return new ResponseEntity<>(users.stream().map(User::toUserView).collect(Collectors.toList()), HttpStatus.OK);
    }

    @PostMapping("/register")
    ResponseEntity<String> register(@RequestBody RegistrationDTO registrationDTO) {
        userService.register(User.fromRegistrationDTO(registrationDTO.encryptPassword()));
        return new ResponseEntity<>("The account was created successfully", HttpStatus.CREATED);
    }

    @PreAuthorize("hasAuthority(T(com.streamster.userservice.model.SystemRoleType).ADMIN)")
    @PutMapping("/{userId}/updateSystemRole")
    ResponseEntity<String> updateSystemRole(@PathVariable String userId, @RequestParam SystemRoleType role) {
        userService.updateSystemRole(userId,role);
        return new ResponseEntity<>("The role has been updated", HttpStatus.OK);
    }
}
