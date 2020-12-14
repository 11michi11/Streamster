package com.streamster.videoservice.repository;

import com.streamster.videoservice.model.VideoFile;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ChunksRepository extends MongoRepository<Chunk, String> {
}
