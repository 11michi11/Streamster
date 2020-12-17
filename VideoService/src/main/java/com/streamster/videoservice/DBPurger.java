package com.streamster.videoservice;

import com.streamster.videoservice.repository.ChunksRepository;
import com.streamster.videoservice.repository.FilesRepository;
import com.streamster.videoservice.repository.UserRepository;
import lombok.extern.log4j.Log4j2;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Log4j2
@Component
public class DBPurger implements CommandLineRunner {

    final UserRepository userRepository;
    final FilesRepository filesRepository;
    final ChunksRepository chunksRepository;

    public DBPurger(UserRepository userRepository, FilesRepository filesRepository, ChunksRepository chunksRepository) {
        this.userRepository = userRepository;
        this.filesRepository = filesRepository;
        this.chunksRepository = chunksRepository;
    }

    @Override
    public void run(String... args) throws Exception {
//        userRepository.deleteAll();
//        log.info("Purged users collection, collection size: " + userRepository.count());
//        filesRepository.deleteAll();
//        log.info("Purged files collection, collection size: " + filesRepository.count());
//        chunksRepository.deleteAll();
//        log.info("Purged chunks collection, collection size: " + chunksRepository.count());
    }
}
