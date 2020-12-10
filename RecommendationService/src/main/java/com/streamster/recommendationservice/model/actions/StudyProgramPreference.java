package com.streamster.recommendationservice.model.actions;

import com.streamster.recommendationservice.model.nodes.StudyProgramNode;
import com.streamster.recommendationservice.model.nodes.UserNode;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.*;

@NoArgsConstructor
@AllArgsConstructor
@RelationshipEntity(type = "PrefersStudyProgram")
public class StudyProgramPreference {
    @Id
    @GeneratedValue
    private Long id;
    @StartNode
    private UserNode user;
    @EndNode
    private StudyProgramNode studyProgram;
    @Property
    private final int priority = 25;

    public StudyProgramPreference(UserNode user, StudyProgramNode studyProgram) {
        this.user = user;
        this.studyProgram = studyProgram;
    }
}
