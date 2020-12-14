package com.streamster.videoservice.repository;

import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document("fs.chunks")
public class Chunk {

    String _id;
    String files_id;
    int n;
    String data;

}
