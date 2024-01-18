package com.example.demo.api.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.api.model.User;
import com.example.demo.api.repository.UserRepository;
import com.example.demo.service.UserService;

@RestController
@RequestMapping("/api/public")
public class AuthController {

    private final UserService userService;
    private final UserRepository userRepository;
    private String SecretKey = "XpoFfxlKlA8OhRclmYYVeNRjgjxhknxO";
    
    @Autowired
    public AuthController(UserService userService, UserRepository userRepository){
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @GetMapping("/admin")
    public String state(){
        // User user1 = new User();
        // user1.SetName("admin");
        // user1.SetEmail("admin@gmail.com");
        // user1.SetPassword("admin");
        // userRepository.save(user1);
        return "server work!";
    }

    @PostMapping("/login")
    public ResponseEntity<Boolean> login(@RequestBody Map<String, String> LogData){
        String email = LogData.get("email");
        String password = LogData.get("password");

        if (userService.authenticate(email, password)) {
            // Return the token as a response
            return ResponseEntity.ok(true);
        }else{
            return ResponseEntity.badRequest().body(false);
        }
    }
}
