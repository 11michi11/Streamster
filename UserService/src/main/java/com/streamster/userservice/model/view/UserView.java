package com.streamster.userservice.model.view;

import com.streamster.userservice.model.GroupRole;
import com.streamster.userservice.model.SystemRoleType;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class UserView {
    private String id;
    private String firstName;
    private String lastName;
    private String email;
    private String avatar;
    private SystemRoleType systemRole;
    private List<GroupRole> groupRoles;
}
