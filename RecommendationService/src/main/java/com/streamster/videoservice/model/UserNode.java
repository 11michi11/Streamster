package com.streamster.videoservice.model;

import com.streamster.videoservice.controller.WatchAction;
import com.streamster.videoservice.model.dto.ActionDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.*;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Iterator;
import java.util.ListIterator;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
@NodeEntity(label = "User")
public class UserNode {
    @Id
    private String userId;

    private String name;

    @Relationship(type = "prefersTag")
    public Set<TagNode> preferredTags;

    @Relationship(type = "prefersStudyProgram")
    public Set<StudyProgramNode> preferredStudyPrograms;

    @Relationship(type = "prefersLengthInterval")
    public LengthIntervalNode preferredLengthInterval;

    @Relationship(type = "WatchesVideo")
    public Set<WatchAction> watch;

    public UserNode(String userId, String name) {
        this.userId = userId;
        this.name = name;
        this.watch = new HashSet<>();
    }

    public void addWatch(WatchAction watchAction) {
        this.watch.add(watchAction);
    }

    public static UserNode fromUser(User user) {
        return new UserNode(user.getId(),user.getFirstName());
    }
}
