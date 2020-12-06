package com.streamster.recommendationservice.repository;

import com.streamster.recommendationservice.model.nodes.LengthIntervalNode;
import com.streamster.recommendationservice.model.nodes.TagNode;
import org.springframework.data.neo4j.annotation.Query;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface LengthIntervalNeoRepository extends Neo4jRepository<LengthIntervalNode, Long> {
    @Query(value = "MATCH (interval:LengthInterval) WHERE interval.from = $from AND interval.to = $to RETURN interval")
    LengthIntervalNode findByInterval(int from, int to);
}
