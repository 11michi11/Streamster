package com.streamster.recommendationservice.model.nodes;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Generated;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;

@Data
@AllArgsConstructor
@NoArgsConstructor
@NodeEntity(label = "LengthInterval")
public class LengthIntervalNode {
    @Id
    @GeneratedValue
    private Long id;
    private int from;
    private int to;

    public LengthIntervalNode(int from, int to) {
        this.from = from;
        this.to = to;
    }
}
