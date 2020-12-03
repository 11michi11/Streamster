package com.streamster.commons.amqp;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.streamster.commons.amqp.payload.Payload;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import lombok.ToString;


@NoArgsConstructor
@ToString
public class Message<T extends Payload> {

    private Action action;
    private T payload;

    public Message(T payload) {
        this.payload = payload;
        this.action = payload.getAction();
    }

    public T getPayload() {
        return payload;
    }

    public Action getAction() {
        return action;
    }

    @SneakyThrows
    public String toJson() {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.enableDefaultTyping();
        return objectMapper.writeValueAsString(this);
    }
}
