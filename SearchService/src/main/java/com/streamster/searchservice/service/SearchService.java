package com.streamster.searchservice.service;

import com.mongodb.client.gridfs.GridFSFindIterable;
import com.streamster.searchservice.model.User;
import com.streamster.searchservice.model.view.VideoView;
import com.streamster.searchservice.repository.NeoRepository;
import com.streamster.searchservice.repository.UserRepository;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.TextCriteria;
import org.springframework.data.mongodb.core.query.TextQuery;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class SearchService {
    private final GridFsTemplate gridFsTemplate;
    private final UserRepository userRepository;
    private final NeoRepository neoRepository;
    private final ProxyService proxyService;

    public SearchService(GridFsTemplate gridFsTemplate, UserRepository userRepository, NeoRepository neoRepository, ProxyService proxyService) {
        this.gridFsTemplate = gridFsTemplate;
        this.userRepository = userRepository;
        this.neoRepository = neoRepository;
        this.proxyService = proxyService;
    }

    public List<VideoView> searchByTerm(String searchTerm) {
        var query = TextQuery.queryText(TextCriteria.forDefaultLanguage().matchingAny(searchTerm));
        GridFSFindIterable files = gridFsTemplate.find(query);

        return StreamSupport.stream(files.spliterator(), false)
                .map(VideoView::new)
                .collect(Collectors.toList());
    }

    public List<VideoView> getRecommendedVideos(String email) {
        User currentUser = getUserByEmail(email);
        // TODO: to change to currentUser.getId() when dummy data is ready
        var videoIds = getRecommendedVideoIds(currentUser.getFirstName());
        return findAll(videoIds);
    }

    private List<String> getRecommendedVideoIds(String userId) {
        var videos = this.neoRepository.getRecommendedVideos(userId);
        return StreamSupport.stream(videos.spliterator(), false)
                .collect(Collectors.toList());
    }

    private List<VideoView> findAll(List<String> videoIds) {
        GridFSFindIterable files = gridFsTemplate.find(new Query(Criteria.where("_id").in(videoIds)));
        return StreamSupport.stream(files.spliterator(), false)
                .map(VideoView::new)
                .collect(Collectors.toList());
    }

    public void addWatchAction(String email, String searchTerm) {
        User currentUser = getUserByEmail(email);
        // TODO: to change to currentUser.getId() when dummy data is imported to Neo4j
        this.proxyService.addSearchAction(searchTerm,currentUser.getFirstName());
    }

    private User getUserByEmail(String email) {
        return userRepository
                .findByEmail(email)
                .orElseThrow(() -> new NoSuchElementException("Cannot be found user with email: " + email));
    }


}
