package com.streamster.videoservice.amqp;

import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import com.streamster.commons.amqp.Message;


public class MessageSender {

    @Autowired
    private RabbitTemplate template;

    @Autowired
    private Queue user;
    @Autowired
    private Queue recommendation;

    public void sendToUserService(Message message) {
        this.template.convertAndSend(user.getName(), message.toJson());
    }

    public void sendToRecommendationService(Message message) {
        this.template.convertAndSend(recommendation.getName(), message.toJson());
    }
}
