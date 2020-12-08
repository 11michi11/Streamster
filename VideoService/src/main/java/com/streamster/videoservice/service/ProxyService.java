package com.streamster.videoservice.service;

import com.streamster.commons.amqp.Message;
import com.streamster.commons.amqp.payload.*;
import com.streamster.videoservice.amqp.MessageSender;
import lombok.extern.log4j.Log4j2;
import org.bson.Document;
import org.springframework.stereotype.Service;

import java.util.HashSet;

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

    public void addLikedVideoAction(String videoID, String userID) {
        var message = new Message<>(new LikeAction(videoID, userID));
        messageSender.sendToRecommendationService(message);
    }

    public void addDislikedVideoAction(String videoID, String userID) {
        var message = new Message<>(new DislikeAction(videoID, userID));
        messageSender.sendToRecommendationService(message);
    }

    public void addVideoToRecommendations(Document metadata, String userId, String fileId) {
        var message = new Message<>(new CreatedVideoAction(
                fileId,
                metadata.getString("title"),
                metadata.getString("description"),
                new HashSet<>(metadata.getList("tags", String.class)),
                new HashSet<>(metadata.getList("studyPrograms", String.class)),
                metadata.getInteger("length"),
                userId
        ));
        messageSender.sendToRecommendationService(message);
    }
}
