package com.streamster.recommendationservice.model.nodes;

import com.streamster.recommendationservice.model.actions.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.neo4j.ogm.annotation.Id;
import org.neo4j.ogm.annotation.NodeEntity;
import org.neo4j.ogm.annotation.Relationship;

import java.util.HashSet;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
@NodeEntity(label = "User")
public class UserNode {
    @Id
    private String userId;

    private String name;

    @Relationship(type = "CreatesVideo")
    public Set<VideoNode> videos;

    @Relationship(type = "PrefersTag")
    public Set<TagPreference> preferredTags;

    @Relationship(type = "PrefersStudyProgram")
    public Set<StudyProgramPreference> preferredStudyPrograms;

    @Relationship(type = "PrefersLength")
    public LengthIntervalPreference preferredLengthInterval;

    @Relationship(type = "WatchesVideo")
    public Set<WatchAction> watchActions;

    @Relationship(type = "LikesVideo")
    public Set<LikeAction> likeActions;

    @Relationship(type = "DislikesVideo")
    public Set<DislikeAction> dislikeActions;

    @Relationship(type = "SearchesVideo")
    public Set<SearchAction> searchActions;

    public UserNode(String userId, String name) {
        this.userId = userId;
        this.name = name;
        this.videos = new HashSet<>();
        this.watchActions = new HashSet<>();
        this.likeActions = new HashSet<>();
        this.dislikeActions = new HashSet<>();
        this.searchActions = new HashSet<>();
    }

    public void addWatchAction(WatchAction watchAction) {
        this.watchActions.add(watchAction);
    }

    public void addLikeAction(LikeAction likeAction) {
        this.likeActions.add(likeAction);
    }

    public void addDislikeAction(DislikeAction dislikeAction) {
        this.dislikeActions.add(dislikeAction);
    }

    public void addSearchAction(SearchAction searchAction) {
        // TODO: to remove when dummy data is ready
        if(this.searchActions == null) this.searchActions = new HashSet<>();
        this.searchActions.add(searchAction);
    }

    public void addCreatedVideo(VideoNode videoNode) {
        // TODO: to remove when dummy data is ready
        if(this.videos == null) this.videos = new HashSet<>();
        this.videos.add(videoNode);
    }
}
