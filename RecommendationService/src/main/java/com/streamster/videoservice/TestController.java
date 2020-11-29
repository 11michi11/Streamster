package com.streamster.videoservice;


import com.streamster.videoservice.model.RecommendedVideo;
import com.streamster.videoservice.model.UserNeo;
import com.streamster.videoservice.repository.UserNeoRepository;
import com.streamster.videoservice.repository.VideoIdNeoRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@RestController
public class TestController {

    final UserNeoRepository userNeoRepository;
    final VideoIdNeoRepository videoIdNeoRepository;

    public TestController(UserNeoRepository userNeoRepository,VideoIdNeoRepository videoIdNeoRepository) {
        this.userNeoRepository = userNeoRepository;
        this.videoIdNeoRepository = videoIdNeoRepository;
    }

    @GetMapping
    String hello(Principal principal) {
        return "Hello " + principal.getName();
    }

    @GetMapping("/allUsers")
    public ResponseEntity<List<UserNeo>> findAll() {
        List<UserNeo> users = new ArrayList<>();
        Iterable<UserNeo> x = this.userNeoRepository.findAll();
        x.forEach(users::add);
        return new ResponseEntity<>(users, HttpStatus.OK);
    }

    @GetMapping("/users")
    public ResponseEntity<UserNeo> findByName(@RequestParam String name) {
        UserNeo user = this.userNeoRepository.findByName(name);
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    @GetMapping("/getRecommendedVideos")
    public ResponseEntity<Iterable<RecommendedVideo>> getRecommendedVideoIds() {
        Iterable<RecommendedVideo> recommendedVideos = this.videoIdNeoRepository.getRecommendedVideos("Matej");
        return new ResponseEntity<>(recommendedVideos, HttpStatus.OK);
    }
}
