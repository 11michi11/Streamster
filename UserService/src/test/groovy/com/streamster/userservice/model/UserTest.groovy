package com.streamster.userservice.model

import com.streamster.userservice.UserServiceApplication
import com.streamster.userservice.model.dto.RegistrationDTO
import com.streamster.userservice.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ContextConfiguration
import spock.lang.Specification

@ContextConfiguration
@SpringBootTest(classes = UserServiceApplication.class)
class UserTest extends Specification {

    @Autowired(required = true)
    private UserRepository userRepository

    def "test fromUserInfo"() {
        when:
            Optional<User> user = userRepository.findByEmail("email")
        then:
             user.isEmpty()

        print "Hello"
    }

    def "test fromRegistrationDTO"() {
        when:
            RegistrationDTO dto = new RegistrationDTO("Peter","Price","password","email",null)
            dto = dto.encryptPassword()
            User user = User.fromRegistrationDTO(dto)
        then:
            user.getFirstName() == dto.getFirstName()
            user.getLastName() == dto.getLastName()
            user.getPassword() == dto.getPassword()
            user.getEmail() == dto.getEmail()
            user.getAvatar() == dto.getAvatar()
            user.getSystemRole() == SystemRoleType.STUDENT
            user.getGroupRoles().isEmpty()
    }
}
