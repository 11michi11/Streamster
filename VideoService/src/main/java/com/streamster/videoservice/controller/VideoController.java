package com.streamster.videoservice.controller;


import com.streamster.videoservice.service.UploadService;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;

@Log4j2
@RestController
public class VideoController {

    private final UploadService videoService;

    public VideoController(UploadService videoService) {
        this.videoService = videoService;
    }

    @PreAuthorize("hasAuthority(T(com.streamster.videoservice.model.SystemRoleType).TEACHER)")
    @PostMapping("/upload")
    public ResponseEntity<String> upload(Principal principal, @RequestParam("video") MultipartFile file) {
        this.videoService.uploadVideo(file, principal.getName());
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    
}
