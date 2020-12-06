package com.streamster.searchservice.repository;

import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;
import org.springframework.data.repository.query.Param;

public interface NeoRepository extends Neo4jRepository {
    @Query(value=RecommendationQuery.value)
    Iterable<String> getRecommendedVideos(@Param("username") String username);
}
