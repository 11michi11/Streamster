package com.streamster.userservice.controller

import com.streamster.userservice.UserServiceApplication
import com.streamster.userservice.model.SystemRoleType
import com.streamster.userservice.model.User
import com.streamster.userservice.model.dto.RegistrationDTO
import com.streamster.userservice.repository.UserRepository
import com.streamster.userservice.service.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.security.test.context.support.WithAnonymousUser
import org.springframework.security.test.context.support.WithMockUser
import org.springframework.test.context.ContextConfiguration
import spock.lang.Specification

@ContextConfiguration
@SpringBootTest(classes = UserServiceApplication.class)
class UserControllerTest extends Specification {

    @Autowired(required = true)
    private UserController userController;

//    @WithMockUser(username = "user@email.com",authorities =["ADMIN"])
//    def "test updateSystemRoleAsAdmin"() {
//        given:
//            User user = new User("userId","Peter","Price", "\$2a\$10\$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S","student@email.com", null, SystemRoleType.STUDENT, Collections.emptyList());
//            UserRepository userRepository = Stub(UserRepository.class)
//            userRepository.findById("userId") >> {return user}
//            userRepository.save(user)
//        when:
//            ResponseEntity response = userController.updateSystemRole("userId",SystemRoleType.TEACHER)
//        then:
//            response.getStatusCode() == HttpStatus.OK
//    }
//
//    @WithMockUser(username = "user@email.com",authorities =["STUDENT"])
//    def "test updateSystemRoleAsNotAdmin"() {
//        given:
//            UserService userService = Stub(UserService.class)
//            userService.updateSystemRole(_ as String,_ as SystemRoleType)
//        when:
//            ResponseEntity response = userController.updateSystemRole("userId",SystemRoleType.TEACHER)
//        then:
//            response.getStatusCode() == HttpStatus.UNAUTHORIZED
//    }
//
//    @WithAnonymousUser
//    def "test registerAsAnonymousUser"() {
//        given:
//            UserService userService = Stub(UserService.class)
//            userService.register(_ as RegistrationDTO)
//        when:
//            ResponseEntity response = userController.updateSystemRole("userId",SystemRoleType.TEACHER)
//        then:
//            response.getStatusCode() == HttpStatus.UNAUTHORIZED
//    }


//    @WithMockUser(username = "user",roles=["ADMIN"])
//    def "test register"() {
//        given:
//
//        when:
//        // TODO implement stimulus
//        then:
//        // TODO implement assertions
//    }
}
