package com.streamster.recommendationservice.repository;

import com.streamster.recommendationservice.model.nodes.UserNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface UserNeoRepository extends Neo4jRepository<UserNode, String> {
    UserNode findByName(String name);
}
