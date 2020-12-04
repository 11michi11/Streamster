package com.streamster.recommendationservice.model.nodes;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.HashSet;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
@NodeEntity(label = "Video")
public class VideoNode {
    @Id
    private String videoId;

    private String title;

    private String description;

    private int length;

    @Relationship(type = "hasTag")
    public Set<TagNode> tags;

    @Relationship(type = "hasStudyPrograms")
    public Set<StudyProgramNode> studyPrograms;

    public VideoNode(String videoId, String title, String description, int length) {
        this.videoId = videoId;
        this.title = title;
        this.description = description;
        this.length = length;
        this.tags = new HashSet<>();
        this.studyPrograms = new HashSet<>();
    }
}
