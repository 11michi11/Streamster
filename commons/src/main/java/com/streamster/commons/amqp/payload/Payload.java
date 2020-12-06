package com.streamster.commons.amqp.payload;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.streamster.commons.amqp.Action;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@JsonTypeInfo(
        use = JsonTypeInfo.Id.NAME,
        property = "type")
@JsonSubTypes({
        @JsonSubTypes.Type(value = NewVideo.class, name = "NewVideo"),
        @JsonSubTypes.Type(value = WatchAction.class, name = "WatchAction"),
        @JsonSubTypes.Type(value = LikeAction.class, name = "LikeAction"),
        @JsonSubTypes.Type(value = LikeAction.class, name = "DislikeAction"),
        @JsonSubTypes.Type(value = SearchAction.class, name = "SearchAction"),
        @JsonSubTypes.Type(value = CreatedVideoAction.class, name = "CreatedVideoAction"),
        @JsonSubTypes.Type(value = PreferencesForRecommendations.class, name = "PreferencesForRecommendations"),
})
@JsonIgnoreProperties(ignoreUnknown = true)
@Data
@NoArgsConstructor
public abstract class Payload {

    @Getter
    private Action action;

    protected Payload(Action action) {
        this.action = action;
    }

    @JsonProperty("type")
    public abstract String getChildType();

}
