package com.streamster.videoservice.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.Document;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class VideoMetadataDTO {
    @NotNull
    private String title;
    private String description;
    @NotNull
    @NotEmpty
    private Set<String> tags;
    @NotNull
    @NotEmpty
    private Set<String> studyPrograms;
    @Pattern(regexp = "^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$",
            message = "thumbnail is not valid Base64 encoded string")
    private String thumbnail;
    private String language;
    @NotNull
    private Long length;

    public Document toDocument() {
        Document document = new Document();
        document.put("title", this.title);
        document.put("description", this.description);
        document.put("tags", this.tags);
        document.put("studyPrograms", this.studyPrograms);
        document.put("thumbnail", this.thumbnail);
        document.put("language", this.language);
        document.put("length", this.length);
        return document;
    }
}
