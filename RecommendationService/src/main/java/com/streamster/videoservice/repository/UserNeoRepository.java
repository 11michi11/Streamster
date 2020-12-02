package com.streamster.videoservice.repository;

import com.streamster.videoservice.model.UserNeo;
import com.streamster.videoservice.model.UserNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface UserNeoRepository extends Neo4jRepository<UserNode, String> {
    UserNode findByName(String name);
}
