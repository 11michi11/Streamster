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

//    @Scheduled(fixedDelay = 1000, initialDelay = 500)
//    public void send() {
//        Message message = new Message<>(Action.NEW_VIDEO, "Hello");
//        this.template.convertAndSend(user.getName(), message.toJson());
//        System.out.println(" [x] Sent '" + message.toJson() + "'");
//    }

//    public void sendToUserService(Message message) {
//        this.template.convertAndSend(user.getName(), message.toJson());
//    }

}
