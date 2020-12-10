package com.streamster.recommendationservice.model.actions;

import com.streamster.recommendationservice.model.nodes.UserNode;
import com.streamster.recommendationservice.model.nodes.VideoNode;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.*;

import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@RelationshipEntity(type = "WatchesVideo")
public class WatchAction {
    @Id
    @GeneratedValue
    private Long id;
    @StartNode
    private UserNode user;
    @EndNode
    private VideoNode video;
    @Property
    private final int priority = 12;
    @Property
    private final String time = LocalDate.now().toString();

    public WatchAction(UserNode user, VideoNode video) {
        this.user = user;
        this.video = video;
    }
}
