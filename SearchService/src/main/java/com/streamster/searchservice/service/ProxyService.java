package com.streamster.searchservice.service;

import com.streamster.commons.amqp.Message;
import com.streamster.commons.amqp.payload.SearchAction;
import com.streamster.searchservice.amqp.MessageSender;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@Log4j2
public class ProxyService {

    private final MessageSender messageSender;

    public ProxyService(MessageSender messageSender) {
        this.messageSender = messageSender;
    }

    public void addSearchAction(String searchTerm, String userID) {
        var message = new Message<>(new SearchAction(searchTerm, userID));
        messageSender.sendToRecommendationService(message);
    }
}
