package com.streamster.userservice.service;

import com.streamster.commons.amqp.Message;
import com.streamster.commons.amqp.payload.PreferencesForRecommendations;
import com.streamster.userservice.amqp.MessageSender;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
@Log4j2
public class ProxyService {

    private final MessageSender messageSender;

    public ProxyService(MessageSender messageSender) {
        this.messageSender = messageSender;
    }

    public void updatePreferencesForRecommendations(Set<String> tags, Set<String> studyPrograms, int lengthFrom,
                                                    int lengthTo, String userId) {
        var message = new Message<>(new PreferencesForRecommendations(tags, studyPrograms, lengthFrom, lengthTo, userId));
        messageSender.sendToRecommendationService(message);
    }
}
