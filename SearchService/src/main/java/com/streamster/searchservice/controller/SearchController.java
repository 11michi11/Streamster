package com.streamster.searchservice.controller;

import com.streamster.searchservice.model.view.VideoView;
import com.streamster.searchservice.service.GridFSSearchService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/search")
public class SearchController {

    private final GridFSSearchService searchService;

    public SearchController(GridFSSearchService searchService) {
        this.searchService = searchService;
    }

    @GetMapping
    public ResponseEntity<List<VideoView>> searchByTerm(@RequestParam("searchTerm") String searchTerm) {
        List<VideoView> videos = searchService.searchByTerm(searchTerm);
        return ResponseEntity.ok(videos);
    }
}
