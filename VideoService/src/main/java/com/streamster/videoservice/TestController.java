package com.streamster.videoservice;


import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Log4j2
@RestController
public class TestController {

    final TestService videoService;

    public TestController(TestService videoService) {
        this.videoService = videoService;
    }

    @GetMapping
    String hello(Principal principal) {
        return "Hello " + principal.getName();
    }

    @PostMapping("/upload")
    public ResponseEntity<String> upload(@RequestParam("video") MultipartFile file) throws IOException {
        log.info("Uploading file: " + file.getOriginalFilename());
        var is = file.getInputStream();
        byte[] buffer = new byte[255];

        int bytesRead, chunks = 0, chunkSize = 255;
        do {
            bytesRead = is.readNBytes(buffer, 0, chunkSize);
            chunks++;
        } while (bytesRead == chunkSize);
        int numberOfBytes = chunks * chunkSize + bytesRead;
        log.info("Number of chunks: " + chunks + ", number of bytes: " + numberOfBytes);

        return new ResponseEntity<>(this.videoService.store(file), HttpStatus.CREATED);

//        byte[] bytes = file.getBytes();
//        log.info("Number of bytes: " + bytes.length);

        // Saving file to file system
//        var path = "C:\\Users\\11mic\\Desktop\\uploads";
//        File transferredFile = new File(path + "\\" + file.getOriginalFilename());
//        file.transferTo(transferredFile);
//        log.info("Finished uploading, file location: " + transferredFile.getAbsolutePath());
//        return "Success";
    }
}
