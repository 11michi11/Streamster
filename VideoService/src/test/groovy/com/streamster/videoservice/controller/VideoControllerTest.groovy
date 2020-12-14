package com.streamster.videoservice.controller

import com.streamster.videoservice.ServicesConfig
import com.streamster.videoservice.repository.FilesRepository
import com.streamster.videoservice.repository.UserRepository
import com.streamster.videoservice.service.FileService
import com.streamster.videoservice.service.ProxyService
import com.streamster.videoservice.service.VideoService
import org.spockframework.spring.SpringBean
import org.spockframework.spring.StubBeans
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.boot.test.context.TestConfiguration
import org.springframework.context.annotation.Bean
import org.springframework.http.MediaType
import org.springframework.mock.web.MockMultipartFile
import org.springframework.security.test.context.support.WithAnonymousUser
import org.springframework.security.test.context.support.WithMockUser
import org.springframework.test.context.web.WebAppConfiguration
import org.springframework.test.web.servlet.MockMvc
import org.springframework.web.context.WebApplicationContext
import spock.lang.Specification
import spock.mock.DetachedMockFactory

import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.multipart
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup

@StubBeans(ProxyService)
@WebMvcTest(controllers = [VideoController])
@WebAppConfiguration
class VideoControllerTest extends Specification {
    MockMvc mvc
    final static String validMetadata = "{\n" +
            "    \"title\": \"My video\",\n" +
            "    \"description\": \"This is my new video\",\n" +
            "    \"tags\": [\"Java\",\"OOP\"],\n" +
            "    \"studyPrograms\": [\"ICT\",\"GBE\"],\n" +
            "    \"thumbnail\": \"correctThumbnail\",\n" +
            "    \"language\": \"English\",\n" +
            "    \"length\": 45960\n" +
            "}"
    final static MockMultipartFile video = new MockMultipartFile("video", "filename.txt",
            MediaType.TEXT_PLAIN_VALUE, "some xml".getBytes());

    @Autowired
    WebApplicationContext context

    @SpringBean
    ServicesConfig servicesConfig = Mock()

    void setup() {
        mvc = webAppContextSetup(context).apply(springSecurity()).build()
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload as teacher"() {
        when:
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                validMetadata.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isCreated())
    }

    @WithMockUser(authorities = ['ADMIN'])
    def "test upload as admin"() {
        when:
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                validMetadata.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isForbidden())
    }

    @WithMockUser(authorities = ['STUDENT'])
    def "test upload as student"() {
        when:
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                validMetadata.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isForbidden())
    }

    @WithAnonymousUser
    def "test upload as anonymous"() {
        when:
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                validMetadata.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isUnauthorized())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation missing video"() {
        when:
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                validMetadata.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation missing metadata"() {
        when:
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation invalid metadata missing title"() {
        when:
        def json = "{\n" +
                "    \"description\": \"This is my new video\",\n" +
                "    \"tags\": [\"Java\",\"OOP\"],\n" +
                "    \"studyPrograms\": [\"ICT\",\"GBE\"],\n" +
                "    \"thumbnail\": \"correctThumbnail\",\n" +
                "    \"language\": \"English\",\n" +
                "    \"length\": 45960\n" +
                "}"
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                json.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation invalid metadata missing tag"() {
        when:
        def json = "{\n" +
                "    \"title\": \"My video\",\n" +
                "    \"description\": \"This is my new video\",\n" +
                "    \"studyPrograms\": [\"ICT\",\"GBE\"],\n" +
                "    \"thumbnail\": \"correctThumbnail\",\n" +
                "    \"language\": \"English\",\n" +
                "    \"length\": 45960\n" +
                "}"
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                json.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation invalid metadata zero tags"() {
        when:
        def json = "{\n" +
                "    \"title\": \"My video\",\n" +
                "    \"description\": \"This is my new video\",\n" +
                "    \"tags\": [],\n" +
                "    \"studyPrograms\": [\"ICT\",\"GBE\"],\n" +
                "    \"thumbnail\": \"correctThumbnail\",\n" +
                "    \"language\": \"English\",\n" +
                "    \"length\": 45960\n" +
                "}"
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                json.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation invalid metadata missing studyProgram"() {
        when:
        def json = "{\n" +
                "    \"title\": \"My video\",\n" +
                "    \"description\": \"This is my new video\",\n" +
                "    \"tags\": [\"Java\",\"OOP\"],\n" +
                "    \"thumbnail\": \"correctThumbnail\",\n" +
                "    \"language\": \"English\",\n" +
                "    \"length\": 45960\n" +
                "}"
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                json.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation invalid metadata zero studyPrograms"() {
        when:
        def json = "{\n" +
                "    \"title\": \"My video\",\n" +
                "    \"description\": \"This is my new video\",\n" +
                "    \"tags\": [\"Java\",\"OOP\"],\n" +
                "    \"studyPrograms\": [],\n" +
                "    \"thumbnail\": \"correctThumbnail\",\n" +
                "    \"language\": \"English\",\n" +
                "    \"length\": 45960\n" +
                "}"
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                json.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation invalid metadata missing length"() {
        when:
        def json = "{\n" +
                "    \"title\": \"My video\",\n" +
                "    \"description\": \"This is my new video\",\n" +
                "    \"tags\": [\"Java\",\"OOP\"],\n" +
                "    \"studyPrograms\": [\"ICT\",\"GBE\"],\n" +
                "    \"thumbnail\": \"correctThumbnail\",\n" +
                "    \"language\": \"English\",\n" +
                "}"
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                json.getBytes());
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test upload validation invalid metadata invalid thumbnail"() {
        given:
        def json = "{\n" +
                "    \"title\": \"My video\",\n" +
                "    \"description\": \"This is my new video\",\n" +
                "    \"tags\": [\"Java\",\"OOP\"],\n" +
                "    \"studyPrograms\": [\"ICT\",\"GBE\"],\n" +
                "    \"thumbnail\": \"invalidThumbnail1\",\n" +
                "    \"language\": \"English\",\n" +
                "    \"length\": 45960\n" +
                "}"
        def metadata = new MockMultipartFile("metadata", "", MediaType.APPLICATION_JSON_VALUE,
                json.getBytes());
        when:
        def results = mvc.perform(multipart("/videos/upload")
                .file(video)
                .file(metadata)
                .contentType(MediaType.MULTIPART_FORM_DATA))
        then:
        results.andExpect(status().isBadRequest())
    }

    @TestConfiguration
    static class StubConfig {
        DetachedMockFactory detachedMockFactory = new DetachedMockFactory()

        @Bean
        VideoService videoService() {
            return detachedMockFactory.Stub(VideoService)
        }

        @Bean
        FileService fileService() {
            return detachedMockFactory.Stub(FileService)
        }

        @Bean
        ProxyService proxyService() {
            return detachedMockFactory.Stub(ProxyService)
        }

        @Bean
        UserRepository userRepository() {
            return detachedMockFactory.Stub(UserRepository)
        }

        @Bean
        FilesRepository filesRepository() {
            return detachedMockFactory.Stub(FilesRepository)
        }
    }
}
