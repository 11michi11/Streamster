package com.streamster.userservice.controller

import com.streamster.userservice.repository.UserRepository
import com.streamster.userservice.service.UserService
import com.streamster.userservice.service.ProxyService
import org.spockframework.spring.StubBeans
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.boot.test.context.TestConfiguration
import org.springframework.context.annotation.Bean
import org.springframework.http.MediaType
import org.springframework.security.test.context.support.WithAnonymousUser
import org.springframework.security.test.context.support.WithMockUser
import org.springframework.test.context.web.WebAppConfiguration
import org.springframework.test.web.servlet.MockMvc
import org.springframework.web.context.WebApplicationContext
import spock.lang.Specification
import spock.mock.DetachedMockFactory

import static groovy.json.JsonOutput.toJson
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup

@StubBeans(ProxyService)
@WebMvcTest(controllers = [UserController])
@WebAppConfiguration
class UserControllerTest extends Specification {

    MockMvc mvc

    @Autowired
    UserService userService

    @Autowired
    WebApplicationContext context

    void setup() {
        mvc = webAppContextSetup(context).apply(springSecurity()).build()
    }

    @WithMockUser(authorities = ['ADMIN'])
    def "test updateSystemRole as admin"() {
        when:
        def results = mvc.perform(put("/users/userId/updateSystemRole?role=TEACHER"))
        then:
        results.andExpect(status().isOk())
    }

    @WithMockUser(authorities = ['STUDENT'])
    def "test updateSystemRole as student"() {
        when:
        def results = mvc.perform(put("/users/userId/updateSystemRole?role=TEACHER"))
        then:
        results.andExpect(status().isForbidden())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test updateSystemRole as teacher"() {
        when:
        def results = mvc.perform(put("/users/userId/updateSystemRole?role=TEACHER"))
        then:
        results.andExpect(status().isForbidden())
    }

    @WithAnonymousUser
    def "test updateSystemRole as anonymous"() {
        when:
        def results = mvc.perform(put("/users/userId/updateSystemRole?role=TEACHER"))
        then:
        results.andExpect(status().isUnauthorized())
    }

    @WithAnonymousUser
    def "test register"() {
        given:
        Map request = [
                firstName: "John",
                lastName : "Test",
                password : "pwd123XX",
                email    : "correct@email.com",
                avatar   : "correctAvatar123"
        ]
        when:
        def results = mvc.perform(post("/users/register").contentType(MediaType.APPLICATION_JSON)
                .content(toJson(request)))
        then:
        results.andExpect(status().isCreated())
    }

    @WithAnonymousUser
    def "test register validation invalid password"() {
        given:
        Map request = [
                firstName: "John",
                lastName : "Test",
                password : "password",
                email    : "correct@email.com",
                avatar   : "correctAvatar123"
        ]
        when:
        def results = mvc.perform(post("/users/register").contentType(MediaType.APPLICATION_JSON)
                .content(toJson(request)))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithAnonymousUser
    def "test register validation invalid email"() {
        given:
        Map request = [
                firstName: "John",
                lastName : "Test",
                password : "password123A",
                email    : "incorrectEmail",
                avatar   : "correctAvatar123"
        ]
        when:
        def results = mvc.perform(post("/users/register").contentType(MediaType.APPLICATION_JSON)
                .content(toJson(request)))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithAnonymousUser
    def "test register validation invalid avatar"() {
        given:
        Map request = [
                firstName: "John",
                lastName : "Test",
                password : "password123A",
                email    : "correct@email.com",
                avatar   : "invalidAvatar"
        ]
        when:
        def results = mvc.perform(post("/users/register").contentType(MediaType.APPLICATION_JSON)
                .content(toJson(request)))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithAnonymousUser
    def "test register validation not unique email"() {
        given:
        Map request = [
                firstName: "John",
                lastName : "Test",
                password : "password123A",
                email    : "incorrectEmail",
                avatar   : "correctAvatar123"
        ]
        when:
        def results = mvc.perform(post("/users/register").contentType(MediaType.APPLICATION_JSON)
                .content(toJson(request)))
        then:
        results.andExpect(status().isBadRequest())
    }

    @WithMockUser(authorities = ['ADMIN'])
    def "test getAllUsers as admin"() {
        when:
        def results = mvc.perform(get("/users"))
        then:
        results.andExpect(status().isOk())
    }

    @WithMockUser(authorities = ['STUDENT'])
    def "test getAllUsers as student"() {
        when:
        def results = mvc.perform(get("/users"))
        then:
        results.andExpect(status().isForbidden())
    }

    @WithMockUser(authorities = ['TEACHER'])
    def "test getAllUsers as teacher"() {
        when:
        def results = mvc.perform(get("/users"))
        then:
        results.andExpect(status().isForbidden())
    }

    @WithAnonymousUser
    def "test getAllUsers as anonymous"() {
        when:
        def results = mvc.perform(get("/users"))
        then:
        results.andExpect(status().isUnauthorized())
    }

    @TestConfiguration
    static class StubConfig {
        DetachedMockFactory detachedMockFactory = new DetachedMockFactory()

        @Bean
        UserService userService() {
            return detachedMockFactory.Stub(UserService)
        }

        @Bean
        UserRepository userRepository() {
            return detachedMockFactory.Stub(UserRepository)
        }
    }
}
