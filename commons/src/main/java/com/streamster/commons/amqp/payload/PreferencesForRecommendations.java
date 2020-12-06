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
@JsonTypeName("PreferencesForRecommendations")
public class PreferencesForRecommendations extends Payload {

    private Set<String> tags;
    private Set<String> studyPrograms;
    private int lengthFrom;
    private int lengthTo;
    private String userId;

    public PreferencesForRecommendations(Set<String> tags, Set<String> studyPrograms, int lengthFrom, int lengthTo, String userId) {
        super(Action.UPDATE_PREFERENCES);
        this.tags = tags;
        this.studyPrograms = studyPrograms;
        this.lengthFrom = lengthFrom;
        this.lengthTo = lengthTo;
        this.userId = userId;
    }

    @Override
    public String getChildType() {
        return "PreferencesForRecommendations";
    }
}
