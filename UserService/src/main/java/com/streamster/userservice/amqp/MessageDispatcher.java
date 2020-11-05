package com.streamster.userservice.amqp;

import com.streamster.commons.amqp.Message;
import com.streamster.commons.amqp.payload.NewVideo;
import com.streamster.userservice.service.UserService;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Log4j2
@Service
public class MessageDispatcher {

    private final UserService userService;

    public MessageDispatcher(UserService userService) {
        this.userService = userService;
    }

    public void dispatch(Message message) {
        switch (message.getAction()) {
            case NEW_VIDEO -> {
                if (message.getPayload() instanceof NewVideo newVideo) {
                    userService.addVideoToUser(newVideo.getUserId(), newVideo.getUserId());
                }
            }
            default -> log.error("Unhandled message type: " + message.getAction() + ", with payload: " + message.getPayload());
        }
    }


}
