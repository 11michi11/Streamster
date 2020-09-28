package com.streamster.userservice.model;

import com.streamster.userservice.model.dto.RegistrationDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Collections;
import java.util.List;

@Document("users")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    private String id;
    private String firstName;
    private String lastName;
    private String password;
    private String email;
    private String avatar;
    private SystemRoleType systemRole;
    private List<GroupRole> groupRoles;

    public User(String firstName, String lastName, String password, String email, String avatar, SystemRoleType systemRole, List<GroupRole> groupRoles) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.systemRole = systemRole;
        this.groupRoles = groupRoles;
    }

    public static User fromRegistrationDTO(RegistrationDTO dto) {
        return new User(dto.getFirstName(),dto.getLastName(),dto.getPassword(),dto.getEmail(),dto.getAvatar(),SystemRoleType.STUDENT, Collections.emptyList());
    }

}
