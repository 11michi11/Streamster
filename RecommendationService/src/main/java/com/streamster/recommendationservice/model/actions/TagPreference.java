package com.streamster.recommendationservice.model.actions;

import com.streamster.recommendationservice.model.nodes.TagNode;
import com.streamster.recommendationservice.model.nodes.UserNode;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.*;

@NoArgsConstructor
@AllArgsConstructor
@RelationshipEntity(type = "PrefersTag")
public class TagPreference {
    @Id
    @GeneratedValue
    private Long id;
    @StartNode
    private UserNode user;
    @EndNode
    private TagNode tag;
    @Property
    private final int priority = 15;

    public TagPreference(UserNode user, TagNode tag) {
        this.user = user;
        this.tag = tag;
    }
}
