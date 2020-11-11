package com.streamster.searchservice.amqp;

import com.streamster.commons.amqp.Message;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;


public class MessageSender {

    @Autowired
    private RabbitTemplate template;

    @Autowired
    private Queue user;

    public void sendToUserService(Message message) {
        this.template.convertAndSend(user.getName(), message.toJson());
    }

}
