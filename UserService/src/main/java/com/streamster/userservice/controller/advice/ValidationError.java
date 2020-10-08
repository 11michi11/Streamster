package com.streamster.userservice.controller.advice;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ValidationError {
    private final String fieldName;
    private final String message;
}
