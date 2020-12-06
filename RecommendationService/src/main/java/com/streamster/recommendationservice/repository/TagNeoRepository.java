package com.streamster.recommendationservice.repository;

import com.streamster.recommendationservice.model.nodes.TagNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface TagNeoRepository extends Neo4jRepository<TagNode, String> {
    TagNode findByName(String name);
}
