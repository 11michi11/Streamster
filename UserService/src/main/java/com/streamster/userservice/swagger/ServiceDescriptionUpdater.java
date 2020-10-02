package com.streamster.userservice.swagger;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.streamster.userservice.ServicesConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Component
public class ServiceDescriptionUpdater {

    private static final Logger logger = LoggerFactory.getLogger(ServiceDescriptionUpdater.class);

    private static final String DEFAULT_SWAGGER_URL = "/v2/api-docs";
    private static final String KEY_SWAGGER_URL = "swagger_url";

    private final List<String> INSTANCES;
    private final Map<String, String> INSTANCES_NAMES;
    private final RestTemplate template;
    private final ServiceDefinitionsContext definitionContext;
    private final ServicesConfig servicesConfig;

    public ServiceDescriptionUpdater(ServiceDefinitionsContext definitionContext, ServicesConfig servicesConfig) {
        INSTANCES = servicesConfig.getAllServices();
        INSTANCES_NAMES = servicesConfig.getAllServicesAsMap();
        this.template = new RestTemplate();
        this.definitionContext = definitionContext;
        this.servicesConfig = servicesConfig;
    }

    @Scheduled(fixedDelayString = "${swagger.config.refreshrate}")
    public void refreshSwaggerConfigurations() {
        logger.debug("Starting Service Definition Context refresh");

        INSTANCES.forEach(serviceURL -> {
            logger.debug("Attempting service definition refresh for Service : {} ", serviceURL);
            String swaggerURL = getSwaggerURL(serviceURL);

            Optional<Object> jsonData = getSwaggerDefinitionForAPI(serviceURL, swaggerURL);

            if (jsonData.isPresent()) {
                String content = getJSON(jsonData.get());
                definitionContext.addServiceDefinition(INSTANCES_NAMES.get(serviceURL), content);
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