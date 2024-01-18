package com.example.demo.api.repository;

import com.example.demo.api.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


public interface ClientRepository extends JpaRepository<Client,Long> {
    //all crud database methods
}
