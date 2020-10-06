package com.streamster.userservice.model;

import com.streamster.userservice.model.dto.RegistrationDTO;
import com.streamster.userservice.model.view.UserView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.validation.annotation.Validated;

import javax.validation.Valid;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Collections;
import java.util.List;

@Document("users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Validated
public class User {

    @Id
    private String id;
    @NotNull
    private String firstName;
    @NotNull
    private String lastName;

    // (?=.*?[A-Z]) -- at least one uppercase letter
    // (?=.*?[a-z]) -- at least one lowercase letter
    // (?=.*?[0-9]) -- at least one digit
    // .{8,} -- minimum length = 8
    @Pattern(regexp = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
    @NotNull
    private String password;
    @Indexed
    @Email
    private String email;
    private String avatar;
    private SystemRoleType systemRole;
    private List<GroupRole> groupRoles;

    public User(String firstName, String lastName, String password, String email, String avatar,
                SystemRoleType systemRole, List<GroupRole> groupRoles) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.systemRole = systemRole;
        this.groupRoles = groupRoles;
    }

    public static User fromRegistrationDTO(RegistrationDTO dto) {
        return new User(dto.getFirstName(),dto.getLastName(),dto.getPassword(),dto.getEmail(),dto.getAvatar(),
                SystemRoleType.STUDENT, Collections.emptyList());
    }

    public UserView toUserView() {
        return new UserView(this.id,this.firstName,this.lastName,this.email,this.avatar,this.systemRole,
                this.groupRoles);
    }
}
