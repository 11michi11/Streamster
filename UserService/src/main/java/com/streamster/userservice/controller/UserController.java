package com.streamster.userservice.controller;

import com.streamster.commons.model.Preferences;
import com.streamster.commons.model.SystemRoleType;
import com.streamster.commons.model.User;
import com.streamster.commons.model.dto.RegistrationDTO;
import com.streamster.commons.model.dto.RegistrationWithPreferencesDTO;
import com.streamster.commons.model.view.UserView;
import com.streamster.userservice.repository.UserRepository;
import com.streamster.userservice.service.UserService;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/users")
@Validated
@Log4j2
public class UserController {

    final UserService userService;
    final UserRepository userRepository;

    public UserController(UserService userService, UserRepository userRepository) {
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @GetMapping("/userDetails")
    ResponseEntity<UserView> getUserDetails(Principal principal) {
        User currentUser = userService.getUserByEmail(principal.getName());
        return new ResponseEntity<>(currentUser.toUserView(), HttpStatus.OK);
    }

    @GetMapping("/userDetails/{userId}")
    ResponseEntity<UserView> getUserDetails(@PathVariable String userId) {
        User user = userService.getUserById(userId);
        return new ResponseEntity<>(user.toUserView(), HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority(T(com.streamster.userservice.model.SystemRoleType).ADMIN)")
    @GetMapping
    ResponseEntity<List<UserView>> getAllUsers() {
        List<User> users = userRepository.findAll();
        return new ResponseEntity<>(users.stream().map(User::toUserView).collect(Collectors.toList()), HttpStatus.OK);
    }

    @PostMapping("/register")
    ResponseEntity<String> register(@Valid @RequestBody RegistrationDTO registrationDTO) {
        userService.register(User.fromRegistrationDTO(registrationDTO.encryptPassword()));
        return new ResponseEntity<>("The account was created successfully", HttpStatus.CREATED);
    }

    @PostMapping("/registerWithPreferences")
    ResponseEntity<String> register(@Valid @RequestBody RegistrationWithPreferencesDTO registrationDTO) {
        userService.register(User.fromRegistrationDTO(registrationDTO.encryptPassword()));
        return new ResponseEntity<>("The account was created successfully", HttpStatus.CREATED);
    }

    @PreAuthorize("hasAuthority(T(com.streamster.userservice.model.SystemRoleType).ADMIN)")
    @PutMapping("/{userId}/updateSystemRole")
    ResponseEntity<String> updateSystemRole(@PathVariable String userId, @RequestParam SystemRoleType role) {
        userService.updateSystemRole(userId, role);
        return new ResponseEntity<>("The role has been updated", HttpStatus.OK);
    }

    @PreAuthorize("hasAuthority(T(com.streamster.userservice.model.SystemRoleType).TEACHER)")
    @PutMapping("/{userId}/videos/{videoId}")
    ResponseEntity<String> addVideoToUser(@PathVariable String userId, @PathVariable String videoId) {
        userService.addVideoToUser(userId, videoId);
        log.info("Added video to user");
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("/{userId}/preferences")
    ResponseEntity<String> updateUserPreferences(@PathVariable String userId, @Valid @RequestBody Preferences preferences,
                                                 Principal principal) {
        userService.updateUserPreferences(preferences, principal.getName(), userId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
