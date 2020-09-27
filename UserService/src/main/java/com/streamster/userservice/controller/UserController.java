package com.streamster.userservice.controller;

import com.streamster.userservice.model.User;
import com.streamster.userservice.model.dto.UserInfo;
import com.streamster.userservice.repository.UserRepository;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {

    final UserRepository repository;

    public UserController(UserRepository repository) {
        this.repository = repository;
    }

    @PostMapping("/register")
    void register(@RequestBody UserInfo userInfo) {
        userInfo = userInfo.encryptPassword();
        repository.save(User.fromUserInfo(userInfo));
    }


}
