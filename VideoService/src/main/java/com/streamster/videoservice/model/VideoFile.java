package com.streamster.videoservice.model;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.Map;

@Data
@Document("fs.files")
public class VideoFile {

    private String _id;
    private String filename;
    private int length;
    private int chunkSize;
    private LocalDateTime uploadDate;
    private String md5;
    private Map<String, Object> metadata;

}
