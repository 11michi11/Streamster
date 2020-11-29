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
@NodeEntity(label = "User")
public class UserNeo {
    @Id
    @GeneratedValue
    private Long id;

    private String name;

    @Relationship(type = "prefersAuthor")
    public Set<UserNeo> preferredCreators;

}
