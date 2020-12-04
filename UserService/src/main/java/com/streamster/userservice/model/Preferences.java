package com.streamster.userservice.model;

import lombok.Data;

import java.util.Set;

@Data
public class Preferences {

    private Set<String> studyPrograms;
    private Set<String> tags;
    private Long minLength;
    private Long maxLength;

}
