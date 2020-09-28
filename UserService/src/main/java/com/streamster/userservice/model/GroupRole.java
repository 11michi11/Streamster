package com.streamster.userservice.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GroupRole {
    private String groupId;
    private GroupRoleType role;
}
