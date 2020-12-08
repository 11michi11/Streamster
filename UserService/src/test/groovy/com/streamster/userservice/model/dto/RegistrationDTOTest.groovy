package com.streamster.userservice.model.dto

import com.streamster.commons.model.dto.RegistrationDTO
import spock.lang.Specification

import javax.validation.ConstraintViolation
import javax.validation.Validation
import javax.validation.Validator

class RegistrationDTOTest extends Specification {

    Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

    def "test valid password"(String password) {
        when:
        RegistrationDTO dto = new RegistrationDTO("Peter", "Price", password,
                "correct@email.com", "correctAvatar123")
        Set<ConstraintViolation<RegistrationDTO>> validationErrors = validator.validate(dto)

        then:
        validationErrors.isEmpty()

        where:
        password   | _
        "pwd123XX" | _
        "Aa123456" | _
    }

    def "test invalid password"(String password) {
        when:
        RegistrationDTO dto = new RegistrationDTO("Peter", "Price", password,
                "correct@email.com", "correctAvatar123")
        Set<ConstraintViolation<RegistrationDTO>> validationErrors = validator.validate(dto)

        then:
        !validationErrors.isEmpty()
        validationErrors[0].getPropertyPath().toString() == "password"

        where:
        password   | _
        "password" | _
        "pwd123X"  | _
        " "        | _
        null       | _
    }

    def "test valid email"(String email) {
        when:
        RegistrationDTO dto = new RegistrationDTO("Peter", "Price", "password123X",
                email, "correctAvatar123")
        Set<ConstraintViolation<RegistrationDTO>> validationErrors = validator.validate(dto)

        then:
        validationErrors.isEmpty()

        where:
        email                     | _
        "test@email.com"          | _
        "123456@via.com"          | _
        "correct.email@gmail.com" | _
    }

    def "test invalid email"(String email) {
        when:
        RegistrationDTO dto = new RegistrationDTO("Peter", "Price", "password123X",
                email, "correctAvatar123")
        Set<ConstraintViolation<RegistrationDTO>> validationErrors = validator.validate(dto)

        then:
        !validationErrors.isEmpty()
        validationErrors[0].getPropertyPath().toString() == "email"

        where:
        email                   | _
        "email"                 | _
        "email@"                | _
        "email@email@gmail.com" | _
        " "                     | _
        null                    | _
    }

    def "test valid avatar"(String avatar) {
        when:
        RegistrationDTO dto = new RegistrationDTO("Peter", "Price", "password123X",
                "correct@email.com", avatar)
        Set<ConstraintViolation<RegistrationDTO>> validationErrors = validator.validate(dto)

        then:
        validationErrors.isEmpty()

        where:
        avatar             | _
        "correctAvatar123" | _
        "1234"             | _
        ""                 | _
        null               | _
    }

    def "test invalid avatar"(String avatar) {
        when:
        RegistrationDTO dto = new RegistrationDTO("Peter", "Price", "password123X",
                "correct@email.com", avatar)
        Set<ConstraintViolation<RegistrationDTO>> validationErrors = validator.validate(dto)

        then:
        !validationErrors.isEmpty()
        validationErrors[0].getPropertyPath().toString() == "avatar"

        where:
        avatar          | _
        "avatar"        | _
        "invalidAvatar" | _
        "1"             | _
        "123456"        | _
        " "             | _
    }
}
