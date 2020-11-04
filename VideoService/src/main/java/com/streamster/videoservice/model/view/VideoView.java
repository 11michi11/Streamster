package com.streamster.videoservice.model.view;

import com.mongodb.client.gridfs.model.GridFSFile;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.bson.Document;

import java.util.Collections;
import java.util.List;
import java.util.MissingFormatArgumentException;

@Data
@AllArgsConstructor
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

    public static VideoView fromGridFSFile(GridFSFile file) {
        Document metaData = file.getMetadata();
        if (metaData == null)
            throw new MissingFormatArgumentException("Metadata cannot be found for fileId: " + file.getId());
        return new VideoView(file.getId().asObjectId().getValue().toString(),
                metaData.getString("title"),
                metaData.getString("description"),
                metaData.getList("tags", String.class, Collections.EMPTY_LIST),
                metaData.getList("studyPrograms", String.class, Collections.EMPTY_LIST),
                metaData.getString("thumbnail"),
                metaData.getString("language"),
                metaData.getString("authorId"),
                metaData.getString("authorName"));
    }
}