package com.streamster.searchservice.service

import org.spockframework.spring.StubBeans
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import spock.lang.Specification
import com.streamster.searchservice.service.ProxyService

@StubBeans(ProxyService)
@SpringBootTest
class SearchServiceTest extends Specification {

    @Autowired
    private SearchService searchService;

    def "test search by searchTerm should return some videos"() {
        given:
        def searchTerm = "english"
        when:
        def result = searchService.searchByTerm(searchTerm)
        then:
        !result.isEmpty()
    }


}
