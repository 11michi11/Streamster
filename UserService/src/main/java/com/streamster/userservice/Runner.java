package com.streamster.userservice;

import com.streamster.userservice.model.SystemRoleType;
import com.streamster.userservice.model.User;
import com.streamster.userservice.repository.UserRepository;
import lombok.extern.log4j.Log4j2;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Collections;

@Component
@Log4j2
public class Runner implements CommandLineRunner {

    final UserRepository userRepository;

    public Runner(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        User user = userRepository.findByEmail("admin@email.com").orElseGet(() -> {
            var newUser = new User("Chuck","Norris", "$2a$10$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S","admin@email.com", null, SystemRoleType.ADMIN, Collections.emptyList());
            userRepository.save(newUser);
            return newUser;
        });
        log.info("Test user: " + user);
    }
}
