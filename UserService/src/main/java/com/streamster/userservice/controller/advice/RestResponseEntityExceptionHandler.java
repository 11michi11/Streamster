package com.streamster.userservice.controller.advice;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
public class RestResponseEntityExceptionHandler extends ResponseEntityExceptionHandler {

    @ResponseBody
    @ExceptionHandler(value = {ObjectNotFoundException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    String objectNotFoundExceptionHandler(ObjectNotFoundException ex){
        return ex.getMessage();
    }
}
