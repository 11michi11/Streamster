package com.streamster.userservice.controller.advice;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.NoSuchElementException;

@ControllerAdvice
public class RestResponseEntityExceptionHandler extends ResponseEntityExceptionHandler {

    @ResponseBody
    @ExceptionHandler(value = {NoSuchElementException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    String noSuchElementExceptionHandler(NoSuchElementException ex) {
        return ex.getMessage();
    }
}
