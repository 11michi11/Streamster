package com.streamster.videoservice.controller.advice;

import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@ControllerAdvice
public class RestResponseEntityExceptionHandler {

    @ResponseBody
    @ExceptionHandler(value = {NoSuchElementException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    String noSuchElementExceptionHandler(NoSuchElementException ex) {
        return ex.getMessage();
    }

    @ResponseBody
    @ExceptionHandler(value = {FileUploadException.class})
    @ResponseStatus(HttpStatus.CONFLICT)
    String duplicateKeyExceptionHandler(FileUploadException ex) {
        return ex.getMessage();
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ResponseBody
    List<ValidationError> methodArgumentNotValidExceptionHandler(
            MethodArgumentNotValidException e) {
        return e.getBindingResult().getFieldErrors().stream()
                .map(x -> new ValidationError(x.getField(), x.getDefaultMessage()))
                .collect(Collectors.toList());
    }
}
