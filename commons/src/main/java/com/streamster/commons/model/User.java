package com.streamster.commons.model;

import com.streamster.commons.model.dto.RegistrationWithPreferencesDTO;
import com.streamster.commons.model.dto.RegistrationDTO;
import com.streamster.commons.model.view.UserView;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.validation.annotation.Validated;

import java.util.ArrayList;
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
    private String firstName;
    private String lastName;
    private String password;
    @Indexed(unique = true)
    private String email;
    private String avatar;
    private List<String> videoIds = new ArrayList<>();
    private Preferences preferences;
    private SystemRoleType systemRole;
    private List<GroupRole> groupRoles;

    public User(String firstName,
                String lastName,
                String password,
                String email,
                String avatar,
                SystemRoleType systemRole,
                List<GroupRole> groupRoles) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.systemRole = systemRole;
        this.groupRoles = groupRoles;
    }

    public User(String firstName,
                String lastName,
                String password,
                String email,
                String avatar,
                SystemRoleType systemRole,
                List<GroupRole> groupRoles,
                Preferences preferences,
                SystemRoleType systemRoleType) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.systemRole = systemRole;
        this.groupRoles = groupRoles;
        this.preferences = preferences;
        this.systemRole = systemRoleType;
    }

    public void addVideo(String videoID) {
        videoIds.add(videoID);
    }

    public static User fromRegistrationDTO(RegistrationDTO dto) {
        return new User(dto.getFirstName(), dto.getLastName(), dto.getPassword(), dto.getEmail(), dto.getAvatar(),
                SystemRoleType.STUDENT, Collections.emptyList());
    }

    public static User fromRegistrationDTO(RegistrationWithPreferencesDTO dto) {
        return new User(dto.getFirstName(), dto.getLastName(), dto.getPassword(), dto.getEmail(), dto.getAvatar(),
                SystemRoleType.STUDENT, Collections.emptyList(), dto.getPreferences(), dto.getSystemRole());
    }

    public UserView toUserView() {
        return new UserView(this.id, this.firstName, this.lastName, this.email, this.avatar, this.systemRole,
                this.groupRoles, this.preferences);
    }
}
