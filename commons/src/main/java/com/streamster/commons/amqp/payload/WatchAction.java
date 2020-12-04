package com.streamster.commons.amqp.payload;

import com.fasterxml.jackson.annotation.JsonTypeName;
import com.streamster.commons.amqp.Action;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonTypeName("WatchAction")
public class WatchAction extends Payload {

    private String videoId;
    private String userId;

    public WatchAction(String videoId, String userId) {
        super(Action.NEW_ACTION);
        this.videoId = videoId;
        this.userId = userId;
    }

    @Override
    public String getChildType() {
        return "WatchAction";
    }
}
