package com.streamster.userservice.controller

import com.streamster.userservice.UserServiceApplication
import com.streamster.userservice.model.SystemRoleType
import com.streamster.userservice.model.User
import com.streamster.userservice.repository.UserRepository
import com.streamster.userservice.service.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.security.test.context.support.WithMockUser
import org.springframework.test.context.ContextConfiguration
import spock.lang.Specification

@ContextConfiguration
@SpringBootTest(classes = UserServiceApplication.class)
class UserControllerTest extends Specification {

    @Autowired(required = true)
    private UserController userController;

    @WithMockUser(username = "user@email.com", authorities = ["ADMIN"])
    def "test updateSystemRoleAsAdmin"() {
        given:
            User user = new User("userId", "Peter", "Price",
                    "\$2a\$10\$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S", "student@email.com",
                    null, SystemRoleType.STUDENT, Collections.emptyList());
            UserRepository userRepository = Stub(UserRepository.class)
            userRepository.findById("userId") >> Optional.of(user)
            UserService userService = new UserService(userRepository)
            userController = new UserController(userService, userRepository)
        when:
            ResponseEntity response = userController.updateSystemRole("userId", SystemRoleType.TEACHER)
        then:
            response.getStatusCode() == HttpStatus.OK
    }

//    @WithMockUser(username = "user@email.com",authorities =["STUDENT"])
//    def "test updateSystemRoleAsNotAdmin"() {
//        given:
//            User user = new User("userId", "Peter", "Price",
//                    "\$2a\$10\$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S", "student@email.com",
//                    null, SystemRoleType.STUDENT, Collections.emptyList());
//            UserRepository userRepository = Stub(UserRepository.class)
//            userRepository.findById("userId") >> Optional.of(user)
//            UserService userService = new UserService(userRepository)
//            userController = new UserController(userService)
//        when:
//            ResponseEntity response = userController.updateSystemRole("userId",SystemRoleType.TEACHER)
//        then:
//            response.getStatusCode() == HttpStatus.UNAUTHORIZED
//    }
//    @WithAnonymousUser
//    def "test updateSystemRoleAsAnonymousUser"() {
//        given:
//            User user = new User("userId", "Peter", "Price",
//                    "\$2a\$10\$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S", "student@email.com",
//                    null, SystemRoleType.STUDENT, Collections.emptyList());
//            UserRepository userRepository = Stub(UserRepository.class)
//            userRepository.findById("userId") >> Optional.of(user)
//            UserService userService = new UserService(userRepository)
//            userController = new UserController(userService)
//        when:
//            ResponseEntity response = userController.updateSystemRole("userId",SystemRoleType.TEACHER)
//        then:
//            response.getStatusCode() == HttpStatus.UNAUTHORIZED
//    }
//
//    @WithAnonymousUser .. maybe not needed, just without annotation
//    def "test registerAsAnonymousUser"() {
//        given:
//        User user = new User("userId", "Peter", "Price",
//                "\$2a\$10\$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S", "student@email.com",
//                null, SystemRoleType.STUDENT, Collections.emptyList());
//        UserRepository userRepository = Stub(UserRepository.class)
//        userRepository.findById("userId") >> Optional.of(user)
//        UserService userService = new UserService(userRepository)
//        userController = new UserController(userService)
//        when:
//        ResponseEntity response = userController.updateSystemRole("userId",SystemRoleType.TEACHER)
//        then:
//        response.getStatusCode() == HttpStatus.UNAUTHORIZED
//    }
//
//    @WithMockUser(username = "user@email.com",authorities =["STUDENT"])
//    def "test getCurrentUser"() {
//        given:
//            User user = new User("userId", "Peter", "Price",
//                    "\$2a\$10\$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S", "student@email.com",
//                    null, SystemRoleType.STUDENT, Collections.emptyList());
//            UserRepository userRepository = Stub(UserRepository.class)
//            userRepository.findByEmail("student@email.com") >> Optional.of(user)
//            UserService userService = new UserService(userRepository)
//            userController = new UserController(userService)
//            Principal principal = new Principal; ??
//        when:
//            ResponseEntity response = userController.getUserDetails()
//        then:
//            response.getStatusCode() == HttpStatus.OK
//            response.getBody().getFirstName() == user.getFirstName();
//            response.getBody().getLastName() == user.getLastName();
//            response.getBody().getEmail() == user.getEmail();
//            response.getBody().getSystemRole() == user.getSystemRole();
//            response.getBody().getGroupRoles() == user.getGroupRoles();
//              or having equals with Lombok and just say response.getBody.equals(User.toUserView(user))
//    }

//    @WithAnonymousUser .. maybe not needed, just without annotation
//    def "test getCurrentUserAsAnnonymousUser"() {
//        given:
//            User user = new User("userId", "Peter", "Price",
//                    "\$2a\$10\$jISxsn9IeIhHvRlIb9LP7OQqV5Q0YCgB6Z34aesXjb.AAm.B89n7S", "student@email.com",
//                    null, SystemRoleType.STUDENT, Collections.emptyList());
//            UserRepository userRepository = Stub(UserRepository.class)
//            userRepository.findByEmail("student@email.com") >> Optional.of(user)
//            UserService userService = new UserService(userRepository)
//            userController = new UserController(userService)
//            Principal principal = new Principal; ??
//        when:
//            ResponseEntity response = userController.getUserDetails()
//        then:
//            response.getStatusCode() == HttpStatus.UNAUTHORIZED
//    }

}
