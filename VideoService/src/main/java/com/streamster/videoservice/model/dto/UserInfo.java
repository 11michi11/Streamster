package com.streamster.videoservice.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

// TODO Is this class used anywhere?
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserInfo {

    String email;
    String name;
    String password;

    public UserInfo encryptPassword() {
        String password = new BCryptPasswordEncoder().encode(this.password);
        return new UserInfo(email, name, password);
    }

}
