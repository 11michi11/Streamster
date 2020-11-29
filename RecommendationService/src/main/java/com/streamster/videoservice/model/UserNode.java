package com.streamster.videoservice.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.*;

import java.time.LocalDate;
import java.util.Iterator;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
@NodeEntity(label = "User")
public class UserNode {
    @Id
    private String userId;

    @Relationship(type = "prefersTag")
    public Set<TagNode> preferredTags;

    @Relationship(type = "prefersStudyProgram")
    public Set<StudyProgramNode> preferredStudyPrograms;

    @Relationship(type = "prefersLengthInterval")
    public LengthIntervalNode preferredLengthInterval;

    @Relationship(type = "WatchesVideo")
    public Iterator<WatchAction> watch;

}

@AllArgsConstructor
@RelationshipEntity(type = "WatchesVideo")
class WatchAction {
    @StartNode
    private UserNode user;
    @EndNode
    private VideoNode video;
    private int priority;
    private LocalDate time;
}
