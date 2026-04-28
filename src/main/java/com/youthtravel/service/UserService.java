package com.youthtravel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.youthtravel.entity.User;
import com.youthtravel.repository.UserRepository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User registerUser(User user) {
        return userRepository.save(user);
    }

    public boolean loginUser(String email, String password) {
        Optional<User> user = userRepository.findFirstByEmail(email);
        if (user.isPresent()) {
            String storedPassword = user.get().getPassword();
            return storedPassword != null && storedPassword.equals(password);
        }
        return false;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User getUserByEmail(String email) {
        return userRepository.findFirstByEmail(email).orElse(null);
    }

    public User updateUser(User user) {
        return userRepository.save(user);
    }
}