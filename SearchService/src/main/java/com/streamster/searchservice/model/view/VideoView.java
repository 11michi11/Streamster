package com.streamster.searchservice.model.view;

import com.mongodb.client.gridfs.model.GridFSFile;
import lombok.Data;
import org.bson.Document;

import java.util.Collections;
import java.util.List;
import java.util.MissingFormatArgumentException;

@Data
public class VideoView {

    private String id;
    private String title;
    private String description;
    private List<String> tags;
    private List<String> studyPrograms;
    private String thumbnail;
    private String language;
    private String authorId;
    private String authorName;
    private Integer length;

    public VideoView(GridFSFile file) {
        Document metaData = file.getMetadata();
        if (metaData == null) {
            throw new MissingFormatArgumentException("Metadata cannot be found for fileId: " + file.getId());
        }
        this.id = file.getId().asObjectId().getValue().toString();
        this.title = metaData.getString("title");
        this.description = metaData.getString("description");
        this.tags = metaData.getList("tags", String.class, Collections.EMPTY_LIST);
        this.studyPrograms = metaData.getList("studyPrograms", String.class, Collections.EMPTY_LIST);
        this.thumbnail = metaData.getString("thumbnail");
        this.language = metaData.getString("language");
        this.authorId = metaData.getString("authorId");
        this.authorName = metaData.getString("authorName");
        this.length = metaData.getInteger("length");
    }
}
