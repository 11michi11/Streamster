package com.streamster.videoservice.service;

import com.streamster.videoservice.ServicesConfig;
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

    private ServicesConfig servicesConfig;

    public ProxyService(ServicesConfig servicesConfig) {
        this.servicesConfig = servicesConfig;
    }


    public ClientResponse addVideoToUser(String videoID, String userID) {
        var client = createAuthenticatedWebClient(servicesConfig.getUser());
        return client
                .put()
                .uri("/users/" + userID + "/videos/" + videoID)
                .exchange()
                .block();
    }


    private WebClient createAuthenticatedWebClient(String baseURL) {
        OAuth2AuthenticationDetails auth = (OAuth2AuthenticationDetails) SecurityContextHolder.getContext().getAuthentication().getDetails();
        var accessToken = auth.getTokenValue();

        log.info(accessToken);
        return WebClient
                .builder()
                .baseUrl(baseURL)
                .defaultHeader(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
                .build();
    }


}
