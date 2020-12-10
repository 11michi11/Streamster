package com.streamster.commons.model;

import java.util.Arrays;

public enum SystemRoleType {
    ADMIN,TEACHER,STUDENT;

    public static String[] getAllRoles() {
        return Arrays.stream(values()).map(Enum::toString).toArray(String[]::new);
    }

}
