package com.streamster.searchservice.controller;

import com.streamster.searchservice.model.view.VideoView;
import com.streamster.searchservice.service.SearchService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
public class SearchController {

    private final SearchService searchService;

    public SearchController(SearchService searchService) {
        this.searchService = searchService;
    }

    @GetMapping("/search")
    public ResponseEntity<List<VideoView>> searchByTerm(Principal principal, @RequestParam("searchTerm") String searchTerm) {
        List<VideoView> videos = searchService.searchByTerm(searchTerm);
        searchService.addSearchAction(principal.getName(), searchTerm);
        return ResponseEntity.ok(videos);
    }

    @GetMapping("/testSearch/{email}")
    public ResponseEntity<List<VideoView>> searchByTerm(Principal principal, @RequestParam("searchTerm") String searchTerm, @PathVariable String email) {
        List<VideoView> videos = searchService.searchByTerm(searchTerm);
        searchService.addSearchAction(email, searchTerm);
        return ResponseEntity.ok(videos);
    }

    @GetMapping("/recommendations")
    public ResponseEntity<List<VideoView>> getRecommendedVideoIds(Principal principal) {
        var recommendedVideos = this.searchService.getRecommendedVideos(principal.getName());
        return new ResponseEntity<>(recommendedVideos, HttpStatus.OK);
    }
}
