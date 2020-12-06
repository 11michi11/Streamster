package com.streamster.videoservice.controller;


import com.mongodb.client.gridfs.model.GridFSFile;
import com.streamster.videoservice.model.dto.VideoMetadataDTO;
import com.streamster.videoservice.model.view.VideoView;
import com.streamster.videoservice.service.VideoService;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

@Log4j2
@RestController
@RequestMapping("/videos")
public class VideoController {

    private final VideoService videoService;

    public VideoController(VideoService videoService) {
        this.videoService = videoService;
    }

    @PreAuthorize("hasAuthority(T(com.streamster.videoservice.model.SystemRoleType).TEACHER)")
    @PostMapping("/upload")
    public ResponseEntity<String> upload(Principal principal,
                                         @RequestParam("video") MultipartFile file,
                                         @Valid @RequestPart VideoMetadataDTO metadata) {
        this.videoService.uploadVideo(file, principal.getName(), metadata.toDocument());
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("/testUpload/{email}")
    public ResponseEntity<String> testUpload(@PathVariable String email,
                                         @RequestParam("video") MultipartFile file,
                                         @Valid @RequestPart VideoMetadataDTO metadata) {
        this.videoService.uploadVideo(file, email, metadata.toDocument());
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("/{videoId}/watch")
    public ResponseEntity<String> addWatchAction(Principal principal,
                                         @PathVariable String videoId) {
        this.videoService.addWatchAction(principal.getName(),videoId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/currentUser")
    public ResponseEntity<List<VideoView>> getVideosOfCurrentUser(Principal principal) {
        List<GridFSFile> userVideos = this.videoService.getVideosByUser(principal.getName());
        return new ResponseEntity<>(userVideos.stream().map(VideoView::fromGridFSFile).collect(Collectors.toList()),
                HttpStatus.OK);
    }

    @DeleteMapping("/{videoId}")
//    @PreAuthorize("hasAuthority('ADMIN')")
    public ResponseEntity<String> deleteVideo(@PathVariable String videoId) {
        this.videoService.delete(videoId);
        return new ResponseEntity<>("Video has been deleted", HttpStatus.OK);
    }
}
