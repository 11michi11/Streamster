package com.streamster.recommendationservice.amqp;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.streamster.commons.amqp.Message;
import lombok.extern.log4j.Log4j2;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;

@Log4j2
@RabbitListener(queues = "recommendation")
public class Receiver {

    @Autowired
    private MessageDispatcher dispatcher;

    @RabbitHandler
    public void receive(String serializedMessage) {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.enableDefaultTyping();
        try {
            Message message = objectMapper.readValue(serializedMessage, Message.class);
            dispatcher.dispatch(message);
        } catch (JsonProcessingException e) {
            log.error("Could not parse message: " + serializedMessage);
        }
    }

}
