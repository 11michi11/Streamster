package com.streamster.recommendationservice.model.actions;

import com.streamster.recommendationservice.model.nodes.UserNode;
import com.streamster.recommendationservice.model.nodes.VideoNode;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.*;

import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@RelationshipEntity(type = "LikesVideo")
public class LikeAction {
    @Id
    @GeneratedValue
    private Long id;
    @StartNode
    private UserNode user;
    @EndNode
    private VideoNode video;
    @Property
    private final int priority = 6;
    @Property
    private final String time = LocalDate.now().toString();

    public LikeAction(UserNode user, VideoNode video) {
        this.user = user;
        this.video = video;
    }
}
