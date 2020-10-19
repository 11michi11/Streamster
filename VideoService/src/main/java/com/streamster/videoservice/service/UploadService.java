package com.streamster.videoservice.service;

import com.streamster.videoservice.repository.UserRepository;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.ClientResponse;

import java.util.NoSuchElementException;

@Service
@Log4j2
public class UploadService {

    private final FileService fileService;
    private final UserRepository userRepository;
    private final ProxyService proxyService;

    public UploadService(FileService fileService, UserRepository userRepository, ProxyService proxyService) {
        this.fileService = fileService;
        this.userRepository = userRepository;
        this.proxyService = proxyService;
    }

    public void uploadVideo(MultipartFile file, String userEmail) {
        var user = userRepository
                .findByEmail(userEmail)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with email: " + userEmail));

        // Store file to the GridFS
        String fileId = fileService.store(file, user.getId());
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


}
