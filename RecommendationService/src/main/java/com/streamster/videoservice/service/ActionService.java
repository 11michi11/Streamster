package com.streamster.videoservice.service;

import com.streamster.videoservice.controller.WatchAction;
import com.streamster.videoservice.model.VideoNode;
import com.streamster.videoservice.model.actions.ActionType;
import com.streamster.videoservice.model.UserNode;
import com.streamster.videoservice.model.dto.ActionDTO;
import com.streamster.videoservice.repository.NeoRepository;
import com.streamster.videoservice.repository.UserNeoRepository;
import com.streamster.videoservice.repository.UserRepository;
import com.streamster.videoservice.repository.VideoNeoRepository;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.Iterator;
import java.util.NoSuchElementException;

@Service
@Log4j2
public class ActionService {

    private final NeoRepository neoRepository;
    private final UserNeoRepository userNeoRepository;
    private final VideoNeoRepository videoNeoRepository;
    private final UserRepository userRepository;

    public ActionService(NeoRepository neoRepository, UserNeoRepository userNeoRepository, VideoNeoRepository videoNeoRepository, UserRepository userRepository) {
        this.neoRepository = neoRepository;
        this.userNeoRepository = userNeoRepository;
        this.videoNeoRepository = videoNeoRepository;
        this.userRepository = userRepository;
    }

    public void addAction(ActionDTO action, String userEmail) {
        var user = this.userRepository.findByEmail(userEmail)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with email: " + userEmail));
        var neoUser = this.userNeoRepository.findByName(user.getFirstName());
        if(neoUser == null) {
            neoUser = UserNode.fromUser(user);
        }
        var neoVideo = this.videoNeoRepository.findByVideoId(action.getTarget());
        if(neoVideo == null) {
            throw new NoSuchElementException("Cannot be found video with id:" + action.getTarget());
        }
        if(action.getActionType() == ActionType.WATCH) {
            neoUser.addWatch(new WatchAction(neoUser,neoVideo));
        }
        this.neoRepository.save(neoUser);
    }
}
