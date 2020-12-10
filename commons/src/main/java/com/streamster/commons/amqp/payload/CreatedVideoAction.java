package com.streamster.commons.amqp.payload;

import com.fasterxml.jackson.annotation.JsonTypeName;
import com.streamster.commons.amqp.Action;
import lombok.*;

import java.util.Set;

@Getter
@Setter
@ToString
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonTypeName("CreatedVideoAction")
public class CreatedVideoAction extends Payload {

    private String videoId;
    private String title;
    private String description;
    private Set<String> tags;
    private Set<String> studyPrograms;
    private Integer length;
    private String userId;

    public CreatedVideoAction(String videoId, String title, String description, Set<String> tags,
                              Set<String> studyPrograms, Integer length, String userId) {
        super(Action.NEW_VIDEO);
        this.videoId = videoId;
        this.title = title;
        this.description = description;
        this.tags = tags;
        this.studyPrograms = studyPrograms;
        this.length = length;
        this.userId = userId;
    }

    @Override
    public String getChildType() {
        return "CreatedVideoAction";
    }
}
