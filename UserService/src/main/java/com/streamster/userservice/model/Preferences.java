package com.streamster.userservice.model;

import lombok.Data;

import java.util.List;

@Data
public class Preferences {

    private List<String> studyPrograms;
    private List<String> tags;
    private Long minLength;
    private Long maxLength;

}
