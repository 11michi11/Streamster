package com.streamster.recommendationservice.model.actions;

import com.streamster.recommendationservice.model.nodes.SearchTermNode;
import com.streamster.recommendationservice.model.nodes.UserNode;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.*;

import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@RelationshipEntity(type = "SearchesVideo")
public class SearchAction {
    @Id
    @GeneratedValue
    private Long id;
    @StartNode
    private UserNode user;
    @EndNode
    private SearchTermNode searchTerm;
    @Property
    private final int priority = 10;
    @Property
    private final String time = LocalDate.now().toString();

    public SearchAction(UserNode user, SearchTermNode searchTerm) {
        this.user = user;
        this.searchTerm = searchTerm;
    }
}
