package com.streamster.searchservice.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import spock.lang.Specification

@SpringBootTest
class GridFSSearchServiceTest extends Specification {

    @Autowired
    private GridFSSearchService searchService;

    def "test search by searchTerm should return some videos"() {
        given:
        def searchTerm = "english"
        when:
        def result = searchService.searchByTerm(searchTerm)
        then:
        !result.isEmpty()
    }


}
