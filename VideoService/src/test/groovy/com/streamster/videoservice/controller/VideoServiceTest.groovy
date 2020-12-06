package com.streamster.videoservice.controller

import com.streamster.videoservice.model.SystemRoleType
import com.streamster.videoservice.model.User
import com.streamster.videoservice.repository.FilesRepository
import com.streamster.videoservice.repository.UserRepository
import com.streamster.videoservice.service.VideoService
import org.bson.Document
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.mock.web.MockMultipartFile
import spock.lang.Specification

@SpringBootTest
class VideoServiceTest extends Specification {

    @Autowired
    private VideoService videoService
    @Autowired
    private FilesRepository filesRepository
    @Autowired
    private UserRepository userRepository

    final static Map testMetadata = [
            title        : "My video",
            description  : "This is my new video",
            tags         : ["Java", "OOP"],
            studyPrograms: ["ICT", "GBE"],
            thumbnail    : "correctThumbnail",
            language     : "English",
            length       : 45960
    ]
    final static MockMultipartFile video = new MockMultipartFile("video", "filename.txt",
            MediaType.TEXT_PLAIN_VALUE, "some xml".getBytes())

    def "test that video is liked"() {
        setup:
        def testUser = createTestUser()
        def videoId = createTestVideo(testUser.getEmail())

        when:
        videoService.likeVideo(videoId, testUser.getEmail())
        def metadataFromDB = filesRepository.findById(videoId).get().getMetadata()

        then:
        ((List<String>) metadataFromDB.get("likedBy")).contains(testUser.getId())

        cleanup:
        userRepository.delete(testUser)
        filesRepository.deleteById(videoId)
    }

    def "test that video is disliked and no longer liked"() {
        setup:
        def testUser = createTestUser()
        def videoId = createTestVideo(testUser.getEmail())
        videoService.likeVideo(videoId, testUser.getEmail())


        when:
        videoService.dislikeVideo(videoId, testUser.getEmail())
        def metadataFromDB = filesRepository.findById(videoId).get().getMetadata()

        then:
        !((List<String>) metadataFromDB.get("likedBy")).contains(testUser.getId())
        ((List<String>) metadataFromDB.get("dislikedBy")).contains(testUser.getId())

        cleanup:
        userRepository.delete(testUser)
        filesRepository.deleteById(videoId)
    }

    private User createTestUser() {
        def userOptional = userRepository.findByEmail("john.test@email.com")
        if (userOptional.isEmpty()) {
            def user = new User(null, "John", "Test", "password",
                    "john.test@email.com", "avatar", SystemRoleType.TEACHER, Collections.emptyList())
            return userRepository.save(user)
        }
        return userOptional.get();
    }

    private String createTestVideo(String userEmail) {
        def metadata = new Document(testMetadata)
        return videoService.uploadVideo(video, userEmail, metadata)
    }


}
