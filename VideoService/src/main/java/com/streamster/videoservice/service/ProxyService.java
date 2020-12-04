package com.streamster.videoservice.service;

import com.streamster.commons.amqp.Message;
import com.streamster.commons.amqp.payload.WatchAction;
import com.streamster.commons.amqp.payload.NewVideo;
import com.streamster.videoservice.amqp.MessageSender;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@Log4j2
public class ProxyService {

    private final MessageSender messageSender;

    public ProxyService(MessageSender messageSender) {
        this.messageSender = messageSender;
    }

    public void addVideoToUser(String videoID, String userID) {
        var message = new Message<>(new NewVideo(videoID, userID));
        messageSender.sendToUserService(message);
    }

    public void addWatchedVideoAction(String videoID, String userID) {
        var message = new Message<>(new WatchAction(videoID, userID));
        messageSender.sendToRecommendationService(message);
    }
}
