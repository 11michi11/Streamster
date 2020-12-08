package com.streamster.commons.model;

import lombok.Data;

import java.util.Set;

@Data
public class Preferences {

    private Set<String> studyPrograms;
    private Set<String> tags;
    private Integer minLength;
    private Integer maxLength;

}
