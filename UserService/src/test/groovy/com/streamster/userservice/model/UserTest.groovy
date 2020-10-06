package com.streamster.userservice.model

import com.streamster.userservice.UserServiceApplication
import com.streamster.userservice.model.dto.RegistrationDTO
import com.streamster.userservice.repository.UserRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ContextConfiguration
import spock.lang.Specification

import javax.validation.ConstraintViolation
import javax.validation.ConstraintViolationException
import javax.validation.Validation
import javax.validation.Validator
import javax.validation.ValidatorFactory
import java.lang.annotation.Retention

import static java.lang.annotation.RetentionPolicy.RUNTIME

@ContextConfiguration
@SpringBootTest(classes = UserServiceApplication.class)
//@DataJpaTest
class UserTest extends Specification {

//    @Autowired(required = true)
//    private UserRepository userRepository
//
//    def "test fromUserInfo"() {
//        when:
//        Optional<User> user = userRepository.findByEmail("email")
//        then:
//        user.isEmpty()
//
//        print "Hello"
//    }

    def "test invalidPassword"(String password) {
        when:
//        ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
//        Validator validator = validatorFactory.getValidator();
        User user = new User("Peter","Price",password,"email@email.com",null,SystemRoleType.STUDENT,null)
//        User user = User.fromRegistrationDTO("Peter","Price","password","email",null,SystemRoleType.STUDENT,null)
//        Set<ConstraintViolation<User>> validationErrors = validator.validate(user);
        then:
//        validationErrors.isEmpty()
        thrown(ConstraintViolationException.class)

        where:
            password | _
            "test@.com" | _
            " " | _
            null | _
    }

    def "test invalidEmail"() {
        when:
        ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
        Validator validator = validatorFactory.getValidator();
        User user = new User("Peter","Price","Password123","email",null,SystemRoleType.STUDENT,null)
//        User user = User.fromRegistrationDTO("Peter","Price","password","email",null,SystemRoleType.STUDENT,null)
        Set<ConstraintViolation<User>> validationErrors = validator.validate(user);
        then:
        !validationErrors.isEmpty()
    }

//    def "test invalidFirStanem"() {
//        when:
//        Validator validator = Validation.buildDefaultValidatorFactory().getValidator()
//
//        RegistrationDTO dto = new RegistrationDTO("Peter","Price","password","email",null)
////        User user = new User("Peter","Price","password","email",null,SystemRoleType.STUDENT,null)
////        User user = User.fromRegistrationDTO("Peter","Price","password","email",null,SystemRoleType.STUDENT,null)
//        Set<ConstraintViolation<RegistrationDTO>> violations = validator.validate(dto)
//        then:
//        violations.size() == 1
//    }

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
