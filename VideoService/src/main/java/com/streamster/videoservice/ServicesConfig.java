package com.streamster.videoservice;


import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Configuration
@EnableConfigurationProperties
@ConfigurationProperties(prefix = "services")
@Data
public class ServicesConfig {

    private String search;
    private String recommendation;
    private String user;
    private String video;

    public List<String> getAllServices() {
        return List.of(search, recommendation, user, video);
    }

    public Map<String, String> getAllServicesAsMap() {
        return Map.of(search, "search", recommendation, "recommendation", user, "user", video, "video");
    }
}
