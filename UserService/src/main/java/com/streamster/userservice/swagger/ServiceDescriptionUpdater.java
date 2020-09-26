package com.streamster.userservice.swagger;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Component
public class ServiceDescriptionUpdater {

    private static final Logger logger = LoggerFactory.getLogger(ServiceDescriptionUpdater.class);

    private static final String DEFAULT_SWAGGER_URL = "/v2/api-docs";
    private static final String KEY_SWAGGER_URL = "swagger_url";

    private static final List<String> INSTANCES = List.of();

    private final RestTemplate template;

    public ServiceDescriptionUpdater() {
        this.template = new RestTemplate();
    }

    @Autowired
    private ServiceDefinitionsContext definitionContext;

    @Scheduled(fixedDelayString = "${swagger.config.refreshrate}")
    public void refreshSwaggerConfigurations() {
        logger.debug("Starting Service Definition Context refresh");

        INSTANCES.forEach(serviceURL -> {
            logger.debug("Attempting service definition refresh for Service : {} ", serviceURL);
            String swaggerURL = getSwaggerURL(serviceURL);

            Optional<Object> jsonData = getSwaggerDefinitionForAPI(serviceURL, swaggerURL);

            if (jsonData.isPresent()) {
                String content = getJSON(jsonData.get());
                definitionContext.addServiceDefinition(serviceURL, content);
            } else {
                logger.error("Skipping service id : {} Error : Could not get Swagger definition from API ", serviceURL);
            }

            logger.info("Service Definition Context Refreshed at :  {}", LocalDate.now());
        });
    }


    private String getSwaggerURL(String instanceUrl) {
        return instanceUrl + DEFAULT_SWAGGER_URL;
    }

    private Optional<Object> getSwaggerDefinitionForAPI(String serviceName, String url) {
        logger.debug("Accessing the SwaggerDefinition JSON for Service : {} : URL : {} ", serviceName, url);
        try {
            Object jsonData = template.getForObject(url, Object.class);
            return Optional.of(jsonData);
        } catch (RestClientException ex) {
            logger.error("Error while getting service definition for service : {} Error : {} ", serviceName, ex.getMessage());
            return Optional.empty();
        }

    }

    public String getJSON(Object jsonData) {
        try {
            return new ObjectMapper().writeValueAsString(jsonData);
        } catch (JsonProcessingException e) {
            logger.error("Error : {} ", e.getMessage());
            return "";
        }
    }
}