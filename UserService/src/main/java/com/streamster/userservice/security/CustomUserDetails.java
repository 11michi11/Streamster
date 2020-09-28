package com.streamster.userservice.security;

import com.streamster.userservice.model.User;
import com.streamster.userservice.repository.UserRepository;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetails implements UserDetailsService {

    private final UserRepository repo;

    public CustomUserDetails(UserRepository repo) {
        this.repo = repo;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User byEmail = repo.findByEmail(email).orElseThrow(() -> new UsernameNotFoundException("No user"));

        return new org.springframework.security.core.userdetails.User(
                byEmail.getEmail(), byEmail.getPassword(), true, true, true, true,
                AuthorityUtils.createAuthorityList(byEmail.getSystemRole().toString())
        );

    }

}
