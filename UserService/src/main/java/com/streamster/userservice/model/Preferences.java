package com.streamster.userservice.model;

import lombok.Data;

import java.util.List;

@Data
public class Preferences {

    private List<String> studyPrograms;
    private List<String> tags;
    private List<String> creatorIds;
    private Long lengthOfVideo;

}
