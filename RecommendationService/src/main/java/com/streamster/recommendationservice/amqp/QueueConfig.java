package com.streamster.recommendationservice.amqp;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class QueueConfig {

    @Bean
    public Receiver receiver() {
        return new Receiver();
    }
}
