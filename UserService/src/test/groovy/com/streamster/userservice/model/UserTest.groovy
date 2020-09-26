package com.streamster.userservice.model

import com.streamster.userservice.UserServiceApplication
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

    def "FromUserInfo"() {
        when:
            Optional<User> user = userRepository.findByEmail("email")
        then:
             user.isEmpty()

        print "Hello"
    }
}
