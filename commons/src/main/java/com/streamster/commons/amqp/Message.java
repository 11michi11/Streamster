package com.streamster.commons.amqp;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.streamster.commons.amqp.payload.NewVideo;
import com.streamster.commons.amqp.payload.Payload;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;
import lombok.ToString;

import java.io.IOException;

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

    public static void main(String[] args) throws IOException {
        Message message = new Message<>(new NewVideo("fucking_fish", "user"));
        String json = message.toJson();
        System.out.println(json);

        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.enableDefaultTyping();
        Message message1 = objectMapper.readValue(json, Message.class);
        System.out.println(message1);
    }

}
