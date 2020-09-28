package com.streamster.userservice.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegistrationDTO {

    private String firstName;
    private String lastName;
    private String password;
    private String email;
    private String avatar;

    public RegistrationDTO encryptPassword() {
        String password = new BCryptPasswordEncoder().encode(this.password);
        return new RegistrationDTO(firstName, lastName, password, email, avatar);
    }

}
