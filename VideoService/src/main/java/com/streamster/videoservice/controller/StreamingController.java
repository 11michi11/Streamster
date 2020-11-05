package com.streamster.videoservice.controller;

import com.streamster.videoservice.service.FileService;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.mongodb.gridfs.GridFsResource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("/streaming")
public class StreamingController {

    private final FileService fileService;

    public StreamingController(FileService fileService) {
        this.fileService = fileService;
    }

    @GetMapping("/{videoId}")
    public ResponseEntity getVideoChunk(@PathVariable String videoId) throws IOException {
        GridFsResource gridFsResource = fileService.findAsResource(videoId);
        return ResponseEntity.ok().body(new InputStreamResource(gridFsResource.getInputStream()));
    }

}
