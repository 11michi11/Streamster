package com.streamster.videoservice.service;

import org.springframework.core.io.support.ResourceRegion;
import org.springframework.data.mongodb.gridfs.GridFsResource;
import org.springframework.http.HttpRange;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Optional;


@Service
public class StreamingService {

    private final FileService fileService;
    private final long CHUNK_SIZE = 261120L; // 255kB

    public StreamingService(FileService fileService) {
        this.fileService = fileService;
    }

    public ResourceRegion getVideoResourceRegion(String videoId, Optional<HttpRange> range) throws IOException {
        GridFsResource gridFsResource = fileService.findAsResource(videoId);
        long contentLength = gridFsResource.contentLength();

        long start, end;
        if (range.isPresent()) {
            var httpRange = range.get();
            start = httpRange.getRangeStart(contentLength);
            end = httpRange.getRangeEnd(contentLength);
        } else {
            start = 0;
            end = Long.min(CHUNK_SIZE, contentLength);
        }
        return new ResourceRegion(gridFsResource, start, end);
    }
}
