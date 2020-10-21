package com.streamster.videoservice.service;

import com.mongodb.client.gridfs.model.GridFSFile;
import com.streamster.videoservice.repository.UserRepository;
import lombok.extern.log4j.Log4j2;
import org.bson.Document;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@Log4j2
public class VideoService {

    private final FileService fileService;
    private final UserRepository userRepository;
    private final ProxyService proxyService;

    public VideoService(FileService fileService, UserRepository userRepository, ProxyService proxyService) {
        this.fileService = fileService;
        this.userRepository = userRepository;
        this.proxyService = proxyService;
    }

    public void uploadVideo(MultipartFile file, String userEmail, Document metadata) {
        var user = userRepository
                .findByEmail(userEmail)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with email: " + userEmail));

        metadata.put("authorId", user.getId());
        metadata.put("authorName", user.getFirstName()+ " " + user.getLastName());
        // Store file to the GridFS
        String fileId = fileService.store(file, user.getId(), metadata);
        // Update user
        ClientResponse clientResponse = proxyService.addVideoToUser(fileId, user.getId());
        log.info("Response from user service");
        log.info(clientResponse.rawStatusCode());
        log.info(clientResponse.bodyToMono(String.class).block());
        if (!clientResponse.statusCode().is2xxSuccessful()) {
            // Call to UserService failed, delete file
            fileService.delete(fileId);
        }
    }

    public void delete(String videoId) {
        this.fileService.delete(videoId);
    }

    public List<GridFSFile> getVideosByUser(String email) {
        var currentUser = userRepository
                .findByEmail(email)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with email: " + email));
        return this.fileService.getByAuthor(currentUser.getId());
    }
}
