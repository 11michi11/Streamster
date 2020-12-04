package com.streamster.recommendationservice;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
public class TestController {

//    final UserNeoRepository userNeoRepository;
//    final NeoRepository neoRepository;
//
//    public TestController(UserNeoRepository userNeoRepository, NeoRepository neoRepository) {
//        this.userNeoRepository = userNeoRepository;
//        this.neoRepository = neoRepository;
//    }

    @GetMapping
    String hello(Principal principal) {
        return "Hello " + principal.getName();
    }

//    @GetMapping("/allUsers")
//    public ResponseEntity<List<UserNeo>> findAll() {
//        List<UserNeo> users = new ArrayList<>();
//        Iterable<UserNeo> x = this.userNeoRepository.findAll();
//        x.forEach(users::add);
//        return new ResponseEntity<>(users, HttpStatus.OK);
//    }
//
//    @GetMapping("/users")
//    public ResponseEntity<UserNeo> findByName(@RequestParam String name) {
//        UserNeo user = this.userNeoRepository.findByName(name);
//        return new ResponseEntity<>(user, HttpStatus.OK);
//    }

//    @GetMapping("/getRecommendedVideos")
//    public ResponseEntity<Iterable<RecommendedVideo>> getRecommendedVideoIds() {
//        Iterable<RecommendedVideo> recommendedVideos = this.neoRepository.getRecommendedVideos("Matej");
//        return new ResponseEntity<>(recommendedVideos, HttpStatus.OK);
//    }
}
