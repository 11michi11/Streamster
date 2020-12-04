package com.streamster.commons.amqp.payload;

import com.fasterxml.jackson.annotation.JsonTypeName;
import com.streamster.commons.amqp.Action;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonTypeName("SearchAction")
public class SearchAction extends Payload {

    private String searchTerm;
    private String userId;

    public SearchAction(String searchTerm, String userId) {
        super(Action.NEW_SEARCH);
        this.searchTerm = searchTerm;
        this.userId = userId;
    }

    @Override
    public String getChildType() {
        return "SearchAction";
    }
}
