package com.streamster.videoservice.amqp;

import com.streamster.commons.amqp.Message;
import com.streamster.commons.amqp.payload.NewVideo;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;


public class Sender {

    @Autowired
    private RabbitTemplate template;

    @Autowired
    private Queue queue;

    //    @Scheduled(fixedDelay = 1000, initialDelay = 500)
    public void send() {
        String message = "hello";
        this.template.convertAndSend(queue.getName(), message);
        System.out.println(" [x] Sent '" + message + "'");
    }

}
