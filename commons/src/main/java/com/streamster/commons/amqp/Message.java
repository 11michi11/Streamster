package com.streamster.commons.amqp;

import lombok.Getter;

@Getter
public class Message<T> {

    private Action action;
    private T payload;

}
