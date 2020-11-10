package com.streamster.commons.amqp.payload;

import com.fasterxml.jackson.annotation.JsonTypeName;
import com.streamster.commons.amqp.Action;
import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonTypeName("NewVideo")
public class NewVideo extends Payload {

    private String videoId;
    private String userId;

    public NewVideo(String videoId, String userId) {
        super(Action.NEW_VIDEO);
        this.videoId = videoId;
        this.userId = userId;
    }

    @Override
    public String getChildType() {
        return "NewVideo";
    }
}
