package com.streamster.commons.amqp.payload;

import lombok.Data;

@Data
public class NewVideo {

    private String videoId;
    private String userId;
}
