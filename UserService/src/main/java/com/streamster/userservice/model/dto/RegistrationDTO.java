package com.streamster.userservice.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegistrationDTO {

    @NotNull
    private String firstName;
    @NotNull
    private String lastName;
    @Pattern(regexp = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
    @NotNull
    private String password;
    @Email
    private String email;
    private String avatar;

    public RegistrationDTO encryptPassword() {
        String password = new BCryptPasswordEncoder().encode(this.password);
        return new RegistrationDTO(firstName, lastName, password, email, avatar);
    }

}
