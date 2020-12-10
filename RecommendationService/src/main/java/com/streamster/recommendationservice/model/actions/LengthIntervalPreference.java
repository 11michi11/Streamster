package com.streamster.recommendationservice.model.actions;

import com.streamster.recommendationservice.model.nodes.LengthIntervalNode;
import com.streamster.recommendationservice.model.nodes.UserNode;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.*;

@NoArgsConstructor
@AllArgsConstructor
@RelationshipEntity(type = "PrefersLength")
public class LengthIntervalPreference {
    @Id
    @GeneratedValue
    private Long id;
    @StartNode
    private UserNode user;
    @EndNode
    private LengthIntervalNode lengthInterval;
    @Property
    private final int priority = 20;

    public LengthIntervalPreference(UserNode user, LengthIntervalNode lengthInterval) {
        this.user = user;
        this.lengthInterval = lengthInterval;
    }
}
