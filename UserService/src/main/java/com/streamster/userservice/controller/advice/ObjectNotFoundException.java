package com.streamster.userservice.controller.advice;

import java.util.NoSuchElementException;

public class ObjectNotFoundException extends NoSuchElementException {

    public ObjectNotFoundException(String message) {
        super(message);
    }
}
