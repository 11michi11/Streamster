package com.streamster.videoservice.repository;

import com.streamster.videoservice.model.VideoNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface VideoNeoRepository extends Neo4jRepository<VideoNode, String> {
    VideoNode findByVideoId(String videoId);
}
