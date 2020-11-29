package com.streamster.videoservice.repository;

import com.streamster.videoservice.model.RecommendedVideo;
import com.streamster.videoservice.model.UserNeo;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Map;

public interface VideoIdNeoRepository extends Neo4jRepository {
    @Query(value=RecommendationQuery.value)
    Iterable<RecommendedVideo> getRecommendedVideos(@Param("username") String username);
}
