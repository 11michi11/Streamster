package com.streamster.searchservice.service;

import com.mongodb.client.gridfs.GridFSFindIterable;
import com.streamster.searchservice.model.view.VideoView;
import org.springframework.data.mongodb.core.query.TextCriteria;
import org.springframework.data.mongodb.core.query.TextQuery;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class GridFSSearchService {
    private final GridFsTemplate gridFsTemplate;


    public GridFSSearchService(GridFsTemplate gridFsTemplate) {
        this.gridFsTemplate = gridFsTemplate;
    }

    public List<VideoView> searchByTerm(String searchTerm) {
        var query = TextQuery.queryText(TextCriteria.forDefaultLanguage().matchingAny(searchTerm));
        GridFSFindIterable files = gridFsTemplate.find(query);

        return StreamSupport.stream(files.spliterator(), false)
                .map(VideoView::new)
                .collect(Collectors.toList());
    }
}
