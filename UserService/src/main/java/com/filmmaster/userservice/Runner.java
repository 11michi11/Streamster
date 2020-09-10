package com.filmmaster.userservice;

import com.filmmaster.userservice.model.User;
import com.filmmaster.userservice.repository.UserRepository;
import lombok.extern.log4j.Log4j2;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
@Log4j2
public class Runner implements CommandLineRunner {

    final UserRepository userRepository;

    public Runner(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        User user = userRepository.findByEmail("user@mail.com").orElseGet(() -> {
            var newUser = new User("user@mail.com", "John", "$2a$10$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S");
            userRepository.save(newUser);
            return newUser;
        });
        log.info("Test user: " + user);
    }
}
