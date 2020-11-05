package com.streamster.videoservice.service;

import com.streamster.commons.amqp.Message;
import com.streamster.commons.amqp.payload.NewVideo;
import com.streamster.videoservice.ServicesConfig;
import com.streamster.videoservice.amqp.MessageSender;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.WebClient;

@Service
@Log4j2
public class ProxyService {

    private final MessageSender messageSender;

    public ProxyService(MessageSender messageSender) {
        this.messageSender = messageSender;
    }


    public void addVideoToUser(String videoID, String userID) {
        var message = new Message<>(new NewVideo(videoID, userID));
        messageSender.sendToUserService(message);
    }
}
