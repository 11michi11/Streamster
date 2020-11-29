package com.streamster.videoservice.repository;

import com.streamster.videoservice.model.UserNeo;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface UserNeoRepository extends Neo4jRepository<UserNeo, Long> {
    UserNeo findByName(String name);
}
