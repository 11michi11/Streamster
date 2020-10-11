package com.streamster.videoservice;

import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class RestResponseEntityExceptionHandler {

    @ResponseBody
    @ExceptionHandler(value = {FileUploadException.class})
    @ResponseStatus(HttpStatus.CONFLICT)
    String duplicateKeyExceptionHandler(FileUploadException ex) {
        return ex.getMessage();
    }

}
