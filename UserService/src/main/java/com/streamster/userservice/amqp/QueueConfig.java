package com.streamster.userservice.amqp;

import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class QueueConfig {

    @Bean
    public Queue user() {
        return new Queue("user");
    }

    @Bean
    public Queue video() {
        return new Queue("video");
    }

    @Bean
    public Queue recommendation() {
        return new Queue("recommendation");
    }

    @Bean
    public Receiver receiver() {
        return new Receiver();
    }

    @Bean
    public MessageSender sender() {
        return new MessageSender();
    }

}
