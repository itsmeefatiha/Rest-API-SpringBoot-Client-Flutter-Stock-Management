package com.example.demo.api.model;

import jakarta.persistence.Table;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer Id;

    @Column(name = "name")
    private String name;
    @Column(name = "email")
    private String email;
    @Column(name = "password")
    private String password;

    // public User(Long Id, String name, String email, String password){
    //     this.Id = Id;
    //     this.name = name;
    //     this.email = email;
    //     this.password = password;
    // }

    public Integer GetId(){
        return this.Id;
    }

    public void SetId(Integer Id){
        this.Id = Id;
    }
    
    public String GetName(){
        return this.name;
    }

    public void SetName(String name){
        this.name = name;
    }

    public String GetEmail(){
        return this.email;
    }

    public void SetEmail(String email){
        this.email = email;
    }

    public String GetPassword(){
        return this.password;
    }

    public void SetPassword(String password){
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        this.password = passwordEncoder.encode(password);
    }
}
