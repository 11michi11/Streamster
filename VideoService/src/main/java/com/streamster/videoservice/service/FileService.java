package com.streamster.videoservice.service;

import com.mongodb.client.gridfs.model.GridFSFile;
import lombok.SneakyThrows;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsResource;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.NoSuchElementException;

@Service
public class FileService {
    private final GridFsTemplate gridFsTemplate;

    @Autowired
    public FileService(GridFsTemplate gridFsTemplate) {
        this.gridFsTemplate = gridFsTemplate;
    }

    public GridFSFile find(String fileId) {
        GridFSFile file = gridFsTemplate.findOne(new Query(Criteria.where("_id").is(fileId)));
        if (file == null) throw new NoSuchElementException("Cannot be found video with id: " + fileId);
        return file;
    }

    public GridFsResource findAsResource(final String fileId) {
        try {
            return gridFsTemplate.getResource(find(fileId));
        } catch (IllegalArgumentException ex) {
            throw new NoSuchElementException("Cannot be found video content for video with id: " + fileId);
        }
    }


    @SneakyThrows
    public String store(final MultipartFile file, String userId) {
        try {
            String gridFSFileId = gridFsTemplate.store(file.getInputStream(), file.getOriginalFilename(), file.getContentType()).toString();
            if (gridFSFileId != null && !gridFSFileId.isEmpty()) {
                return gridFSFileId;
            }
            throw new FileUploadException("Failed to save file");
        } catch (IOException e) {
            throw new FileUploadException(e);
        }
    }

    public void delete(String fileId) {
        gridFsTemplate.delete(new Query(Criteria.where("_id").is(fileId)));
    }
}
