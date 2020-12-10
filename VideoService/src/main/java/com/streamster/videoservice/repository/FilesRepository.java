package com.streamster.videoservice.repository;

import com.streamster.videoservice.model.VideoFile;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FilesRepository extends MongoRepository<VideoFile, String> {
}
