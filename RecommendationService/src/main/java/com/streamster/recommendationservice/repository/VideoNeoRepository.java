package com.streamster.recommendationservice.repository;

import com.streamster.recommendationservice.model.nodes.VideoNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface VideoNeoRepository extends Neo4jRepository<VideoNode, String> {
    VideoNode findByVideoId(String videoId);
}
