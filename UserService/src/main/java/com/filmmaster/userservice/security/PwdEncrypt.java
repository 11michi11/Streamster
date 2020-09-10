package com.filmmaster.userservice.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.List;

public class PwdEncrypt {

    public static void main(String[] args) {
        List<String> list = List.of("pwd", "password", "secret");

        list.forEach(pwd -> System.out.println(new BCryptPasswordEncoder().encode(pwd)));
    }
}
