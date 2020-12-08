package com.streamster.searchservice.repository;

import com.streamster.searchservice.model.RecommendedVideo;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface NeoRepository extends Neo4jRepository {
    @Query(value=RecommendationQuery.value)
    Iterable<RecommendedVideo> getRecommendedVideos(@Param("username") String username);
}
