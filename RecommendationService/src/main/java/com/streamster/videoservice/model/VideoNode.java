package com.streamster.videoservice.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.GeneratedValue;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
@NodeEntity(label = "Video")
public class VideoNode {
    @Id
//    @GeneratedValue
//    private Long id;
//    @Id
    private String videoId;
    private String title;
    private String description;
    private int length;
}
