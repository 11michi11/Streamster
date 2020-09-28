package com.streamster.userservice.service;

import com.streamster.userservice.model.SystemRoleType;
import com.streamster.userservice.model.User;
import com.streamster.userservice.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

@Component
public class UserService {

    final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void register(User user) {
        this.userRepository.save(user);
    }

    public void updateSystemRole(String userId, SystemRoleType role) throws NullPointerException {
        User user = this.userRepository.findById(userId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,"The user cannot be found"));
        user.setSystemRole(role);
        this.userRepository.save(user);
    }
}
