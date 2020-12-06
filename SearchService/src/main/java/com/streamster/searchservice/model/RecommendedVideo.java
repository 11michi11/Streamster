package com.streamster.searchservice.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.neo4j.annotation.QueryResult;

@Data
@AllArgsConstructor
@NoArgsConstructor
@QueryResult
public class RecommendedVideo {
    private String videoId;
    private int priority;
}
