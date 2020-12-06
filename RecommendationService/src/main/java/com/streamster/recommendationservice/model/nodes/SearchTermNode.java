package com.streamster.recommendationservice.model.nodes;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;

@Data
@AllArgsConstructor
@NoArgsConstructor
@NodeEntity(label = "SearchTerm")
public class SearchTermNode {
    @Id
    private String name;
}
