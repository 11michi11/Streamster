package com.streamster.videoservice;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class TestService {
    private final TestFileService fileService;

    public TestService(TestFileService fileService) {
        this.fileService = fileService;
    }

    public String store(MultipartFile file) {
        return this.fileService.store(file);
    }
}
