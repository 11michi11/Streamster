package com.streamster.commons.model.view;

import com.streamster.commons.model.GroupRole;
import com.streamster.commons.model.Preferences;
import com.streamster.commons.model.SystemRoleType;
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
    private Preferences preferences;
}
