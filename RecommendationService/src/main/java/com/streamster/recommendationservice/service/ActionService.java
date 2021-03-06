package com.streamster.recommendationservice.service;

import com.streamster.commons.amqp.payload.CreatedVideoAction;
import com.streamster.commons.amqp.payload.PreferencesForRecommendations;
import com.streamster.recommendationservice.model.actions.*;
import com.streamster.recommendationservice.model.nodes.*;
import com.streamster.recommendationservice.repository.*;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Log4j2
public class ActionService {

    private final UserNeoRepository userNeoRepository;
    private final VideoNeoRepository videoNeoRepository;
    private final SearchTermNeoRepository searchTermNeoRepository;
    private final TagNeoRepository tagNeoRepository;
    private final StudyProgramNeoRepository studyProgramNeoRepository;
    private final LengthIntervalNeoRepository lengthIntervalNeoRepository;

    public ActionService(UserNeoRepository userNeoRepository, VideoNeoRepository videoNeoRepository,
                         SearchTermNeoRepository searchTermNeoRepository, TagNeoRepository tagNeoRepository,
                         StudyProgramNeoRepository studyProgramNeoRepository, LengthIntervalNeoRepository lengthIntervalNeoRepository) {
        this.userNeoRepository = userNeoRepository;
        this.videoNeoRepository = videoNeoRepository;
        this.searchTermNeoRepository = searchTermNeoRepository;
        this.tagNeoRepository = tagNeoRepository;
        this.studyProgramNeoRepository = studyProgramNeoRepository;
        this.lengthIntervalNeoRepository = lengthIntervalNeoRepository;
    }

    @Transactional
    public void addWatchAction(com.streamster.commons.amqp.payload.WatchAction watchAction) {
        var neoUser = getOrCreateUserNode(watchAction.getUserId(), watchAction.getUserId());
        var neoVideo = getVideoNode(watchAction.getVideoId());
        neoUser.addWatchAction(new WatchAction(neoUser, neoVideo));
        this.userNeoRepository.save(neoUser);
    }

    @Transactional
    public void addLikeAction(com.streamster.commons.amqp.payload.LikeAction likeAction) {
        var neoUser = getOrCreateUserNode(likeAction.getUserId(), likeAction.getUserId());
        var neoVideo = getVideoNode(likeAction.getVideoId());
        neoUser.addLikeAction(new LikeAction(neoUser, neoVideo));
        this.userNeoRepository.save(neoUser);
    }

    @Transactional
    public void addSearchAction(com.streamster.commons.amqp.payload.SearchAction searchAction) {
        var neoUser = getOrCreateUserNode(searchAction.getUserId(), searchAction.getUserId());
        var neoSearchTerm = getOrCreateSearchTermNode(searchAction.getSearchTerm());
        neoUser.addSearchAction(new SearchAction(neoUser, neoSearchTerm));
        this.userNeoRepository.save(neoUser);
    }

    @Transactional
    public void addCreatedVideoAction(CreatedVideoAction createdVideoAction) {
        var neoUser =
                getOrCreateUserNode(createdVideoAction.getUserId(), createdVideoAction.getUserId());
        var neoVideo = new VideoNode(createdVideoAction.getVideoId(), createdVideoAction.getTitle(),
                createdVideoAction.getDescription(), Math.toIntExact(createdVideoAction.getLength()));

        var neoTags = getOrCreateTagNodes(createdVideoAction.getTags());
        neoVideo.setTags(neoTags);

        var neoStudyPrograms = getOrCreateStudyProgramNodes(createdVideoAction.getStudyPrograms());
        neoVideo.setStudyPrograms(neoStudyPrograms);

        neoUser.addCreatedVideo(neoVideo);
        this.userNeoRepository.save(neoUser);
    }

    @Transactional
    public void addDislikeAction(com.streamster.commons.amqp.payload.DislikeAction dislikeAction) {
        var neoUser = getOrCreateUserNode(dislikeAction.getUserId(), dislikeAction.getUserId());
        var neoVideo = getVideoNode(dislikeAction.getVideoId());
        neoUser.addDislikeAction(new DislikeAction(neoUser, neoVideo));
        this.userNeoRepository.save(neoUser);
    }

    @Transactional
    public void updatePreferences(PreferencesForRecommendations preferences) {
        var neoUser = getOrCreateUserNode(preferences.getUserId(),preferences.getName());
        if(!preferences.getTags().isEmpty()){
            var neoTags = getOrCreateTagNodes(preferences.getTags());
            Set<TagPreference> neoTagPreferences = neoTags.stream()
                    .map(tag -> new TagPreference(neoUser,tag))
                    .collect(Collectors.toSet());
            neoUser.setPreferredTags(neoTagPreferences);
        } else {
            neoUser.setPreferredTags(new HashSet<>());
        }

        if(!preferences.getStudyPrograms().isEmpty()){
            var neoStudyPrograms = getOrCreateStudyProgramNodes(preferences.getStudyPrograms());
            Set<StudyProgramPreference> neoStudyProgramPreferences =
                    neoStudyPrograms.stream()
                            .map(studyProgram -> new StudyProgramPreference(neoUser,studyProgram))
                            .collect(Collectors.toSet());
            neoUser.setPreferredStudyPrograms(neoStudyProgramPreferences);
        } else {
            neoUser.setPreferredStudyPrograms(new HashSet<>());
        }

        var neoInterval = getOrCreateLengthIntervalNode(preferences.getLengthFrom(),
                preferences.getLengthTo());
        neoUser.setPreferredLengthInterval(new LengthIntervalPreference(neoUser,neoInterval));

        this.userNeoRepository.save(neoUser);
    }

    private UserNode getOrCreateUserNode(String userId, String name) {
        return this.userNeoRepository.findById(userId).orElse(new UserNode(userId, name));
    }

    private VideoNode getVideoNode(String videoId) {
        var neoVideo = this.videoNeoRepository.findByVideoId(videoId);
        if (neoVideo == null) {
            throw new NoSuchElementException("Cannot be found video with id:" + videoId);
        }
        return neoVideo;
    }

    private SearchTermNode getOrCreateSearchTermNode(String name) {
        var searchTerm = this.searchTermNeoRepository.findByName(name);
        if (searchTerm == null) {
            searchTerm = new SearchTermNode(name);
        }
        return searchTerm;
    }

    private Set<TagNode> getOrCreateTagNodes(Set<String> tags) {
        return tags.stream().map(tag -> {
            var tagNode = this.tagNeoRepository.findByName(tag);
            if (tagNode == null) {
                tagNode = new TagNode(tag);
            }
            return tagNode;
        }).collect(Collectors.toSet());
    }

    private Set<StudyProgramNode> getOrCreateStudyProgramNodes(Set<String> studyPrograms) {
        return studyPrograms.stream().map(studyProgram -> {
            var studyProgramNode = this.studyProgramNeoRepository.findByName(studyProgram);
            if (studyProgramNode == null) {
                studyProgramNode = new StudyProgramNode(studyProgram);
            }
            return studyProgramNode;
        }).collect(Collectors.toSet());
    }

    private LengthIntervalNode getOrCreateLengthIntervalNode(int from, int to) {
        var neoInterval = this.lengthIntervalNeoRepository.findByInterval(from,to);
        if (neoInterval == null) {
            neoInterval = new LengthIntervalNode(from,to);
        }
        return neoInterval;
    }
}
