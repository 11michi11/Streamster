package com.streamster.recommendationservice.repository;

import com.streamster.recommendationservice.model.nodes.SearchTermNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface SearchTermNeoRepository extends Neo4jRepository<SearchTermNode, String> {
    SearchTermNode findByName(String name);
}
