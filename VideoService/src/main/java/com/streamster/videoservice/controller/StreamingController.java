package com.streamster.videoservice.controller;

import com.streamster.videoservice.service.StreamingService;
import org.springframework.core.io.support.ResourceRegion;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("/streaming")
public class StreamingController {

    private final StreamingService streamingService;

    public StreamingController(StreamingService streamingService) {
        this.streamingService = streamingService;
    }


    @GetMapping("/{videoId}")
    public ResponseEntity<ResourceRegion> getVideoChunk(@PathVariable String videoId, @RequestHeader HttpHeaders headers) throws IOException {
        var range = headers.getRange().stream().findFirst();
        var region = streamingService.getVideoResourceRegion(videoId, range);
        return ResponseEntity.status(HttpStatus.PARTIAL_CONTENT)
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(region);
    }


}
