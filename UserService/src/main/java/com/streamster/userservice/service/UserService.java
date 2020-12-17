package com.streamster.userservice.service;

import com.streamster.commons.model.Preferences;
import com.streamster.commons.model.SystemRoleType;
import com.streamster.commons.model.User;
import com.streamster.userservice.repository.UserRepository;
import lombok.SneakyThrows;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Component;

import java.util.NoSuchElementException;

@Component
public class UserService {

    final UserRepository userRepository;
    final ProxyService proxyService;

    public UserService(UserRepository userRepository, ProxyService proxyService) {
        this.userRepository = userRepository;
        this.proxyService = proxyService;
    }

    public User register(User user) {
        try {
            return this.userRepository.save(user);
        } catch (DuplicateKeyException ex) {
            throw new DuplicateKeyException("Given email is already used in the system");
        }
    }

    public void updateSystemRole(String userId, SystemRoleType role) throws NullPointerException {
        User user = this.userRepository.findById(userId)
                .orElseThrow(() -> new NoSuchElementException("User with id: " + userId + " cannot be found"));
        user.setSystemRole(role);
        this.userRepository.save(user);
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with email: " + email));
    }

    public User getUserById(String userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with id: " + userId));
    }

    public void addVideoToUser(String userId, String videoId) {
        var user = userRepository.findById(userId)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with id: " + userId));
        user.addVideo(videoId);
        userRepository.save(user);
    }

    @SneakyThrows
    public void updateUserPreferences(Preferences preferences, String email, String userId) {
        var user = userRepository.findByEmail(email)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with email: " + email));

        if (!user.getId().equals(userId)) {
            throw new IllegalAccessException("You do not have access to this operation");
        }

        user.setPreferences(preferences);
        userRepository.save(user);
        proxyService.updatePreferencesForRecommendations(preferences.getTags(), preferences.getStudyPrograms(),
                preferences.getMinLength(), preferences.getMaxLength(), user.getId(), user.getFirstName() + " " + user.getLastName());
    }
}
