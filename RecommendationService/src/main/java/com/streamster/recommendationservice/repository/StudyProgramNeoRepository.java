package com.streamster.recommendationservice.repository;

import com.streamster.recommendationservice.model.nodes.StudyProgramNode;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface StudyProgramNeoRepository extends Neo4jRepository<StudyProgramNode, String> {
    StudyProgramNode findByName(String name);
}
