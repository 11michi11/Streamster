package com.streamster.videoservice.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.validation.annotation.Validated;

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
    private SystemRoleType systemRole;
    private List<GroupRole> groupRoles;

}
