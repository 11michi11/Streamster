package com.streamster.videoservice.controller;

import com.streamster.videoservice.model.UserNode;
import com.streamster.videoservice.model.VideoNode;
import lombok.AllArgsConstructor;
import org.neo4j.ogm.annotation.*;

import java.time.LocalDate;

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
    private final int priority = 8;
    @Property
    private final String time = LocalDate.now().toString();

    public WatchAction(UserNode user, VideoNode video) {
        this.user = user;
        this.video = video;
    }
}
