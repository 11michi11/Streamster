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

    @PreAuthorize("hasAuthority(T(com.streamster.commons.model.SystemRoleType).TEACHER)")
    @PostMapping("/upload")
    public ResponseEntity<String> upload(Principal principal,
                                         @RequestParam("video") MultipartFile file,
                                         @Valid @RequestPart VideoMetadataDTO metadata) {
        this.videoService.uploadVideo(file, principal.getName(), metadata.toDocument());
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("/testUpload/{email}")
    public ResponseEntity<String> upload(Principal principal,
                                         @RequestParam("video") MultipartFile file,
                                         @Valid @RequestPart VideoMetadataDTO metadata, @PathVariable String email) {
        this.videoService.uploadVideo(file, email, metadata.toDocument());
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/currentUser")
    public ResponseEntity<List<VideoView>> getVideosOfCurrentUser(Principal principal) {
        List<GridFSFile> userVideos = this.videoService.getVideosByUser(principal.getName());
        return new ResponseEntity<>(userVideos.stream().map(VideoView::fromGridFSFile).collect(Collectors.toList()),
                HttpStatus.OK);
    }

    @DeleteMapping("/{videoId}")
    public ResponseEntity<String> deleteVideo(@PathVariable String videoId) {
        this.videoService.delete(videoId);
        return new ResponseEntity<>("Video has been deleted", HttpStatus.OK);
    }

    @PostMapping("/{videoId}/like")
    public ResponseEntity<String> likeVideo(@PathVariable String videoId, Principal principal) {
        videoService.likeVideo(videoId, principal.getName());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{videoId}/dislike")
    public ResponseEntity<String> dislikeVideo(@PathVariable String videoId, Principal principal) {
        videoService.dislikeVideo(videoId, principal.getName());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{videoId}/like/{email}")
    public ResponseEntity<String> likeVideo(@PathVariable String videoId, Principal principal, @PathVariable String email) {
        videoService.likeVideo(videoId, email);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{videoId}/dislike/{email}")
    public ResponseEntity<String> dislikeVideo(@PathVariable String videoId, Principal principal, @PathVariable String email) {
        videoService.dislikeVideo(videoId, email);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/{videoId}/watch")
    public ResponseEntity<String> addWatchAction(Principal principal,
                                                 @PathVariable String videoId) {
        this.videoService.addWatchAction(principal.getName(), videoId);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/{videoId}/testWatch/{email}")
    public ResponseEntity<String> addWatchAction(Principal principal,
                                                 @PathVariable String videoId, @PathVariable String email) {
        this.videoService.addWatchAction(email, videoId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
