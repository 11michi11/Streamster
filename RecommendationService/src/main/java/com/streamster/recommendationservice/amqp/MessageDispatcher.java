package com.streamster.recommendationservice.amqp;

import com.streamster.commons.amqp.Message;
import com.streamster.commons.amqp.payload.*;
import com.streamster.recommendationservice.service.ActionService;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import static com.streamster.commons.amqp.Action.NEW_SEARCH;

@Log4j2
@Service
public class MessageDispatcher {

    private final ActionService actionService;

    public MessageDispatcher(ActionService actionService) {
        this.actionService = actionService;
    }

    public void dispatch(Message message) {
        switch (message.getAction()) {
            case NEW_VIDEO -> {
                if (message.getPayload() instanceof CreatedVideoAction createdVideoAction) {
                    actionService.addCreatedVideoAction(createdVideoAction);
                }
            }
            case NEW_ACTION -> {
                if (message.getPayload() instanceof WatchAction watchAction) {
                    actionService.addWatchAction(watchAction);
                } else if (message.getPayload() instanceof LikeAction likeAction) {
                    actionService.addLikeAction(likeAction);
                } else if (message.getPayload() instanceof DislikeAction dislikeAction) {
                    actionService.addDislikeAction(dislikeAction);
                }
            }
            case NEW_SEARCH -> {
                if (message.getPayload() instanceof SearchAction searchAction) {
                    actionService.addSearchAction(searchAction);
                }
            }
            case UPDATE_PREFERENCES -> {
                if (message.getPayload() instanceof PreferencesForRecommendations preferences) {
                    actionService.updatePreferences(preferences);
                }
            }
            default -> log.error("Unhandled message type: " + message.getAction() + ", with payload: " + message.getPayload());
        }
    }


}
