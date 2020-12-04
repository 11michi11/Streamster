package com.streamster.recommendationservice.amqp;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class QueueConfig {

    private final MessageDispatcher dispatcher;

    public QueueConfig(MessageDispatcher dispatcher) {
        this.dispatcher = dispatcher;
    }

    @Bean
    public Receiver receiver() {
        return new Receiver(dispatcher);
    }
}
