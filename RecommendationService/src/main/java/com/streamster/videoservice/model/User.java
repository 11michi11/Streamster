package com.streamster.videoservice.model;


import com.streamster.videoservice.model.dto.UserInfo;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.data.mongodb.core.mapping.Document;

@Document("users")
@Data
@AllArgsConstructor
public class User {

    String email;
    String name;
    String password;

    public static User fromUserInfo(UserInfo userInfo) {
        return new User(userInfo.getEmail(), userInfo.getName(), userInfo.getPassword());
    }

}