package com.streamster.videoservice.repository;


import com.streamster.videoservice.model.User;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends MongoRepository<User, UUID> {

    Optional<User> findByEmail(String email);

}