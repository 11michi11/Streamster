package com.streamster.userservice.amqp;

import com.streamster.commons.amqp.Message;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;


public class MessageSender {

    @Autowired
    private RabbitTemplate template;

    @Autowired
    private Queue recommendation;

    public void sendToRecommendationService(Message message) {
        this.template.convertAndSend(recommendation.getName(), message.toJson());
    }

}
