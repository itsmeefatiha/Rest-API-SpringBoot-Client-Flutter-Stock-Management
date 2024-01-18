package com.example.demo.api.controller;

import com.example.demo.api.exception.ResourceNotFoundException;
import com.example.demo.api.model.Client;
import com.example.demo.api.repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/client")
public class ClientController {
    @Autowired
    private ClientRepository clientRepository;

    @GetMapping
    public List <Client> geClientList() {
        return clientRepository.findAll();
    }
    // build create client Rest Api
    @PostMapping
    public Client createClient(@RequestBody Client client)  {
        return clientRepository.save(client)  ;
    }
    //build get client by id rest api
    @GetMapping("{id}")
     public ResponseEntity<Client> getClientById(@PathVariable long id){
        Client client= clientRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Client not exist with id: " + id));
        return ResponseEntity.ok(client);
 }
     //build update client rest api
    @PutMapping("{id}")
    public ResponseEntity<Client> updateClient(@PathVariable long id,@RequestBody Client clientDetails){
        Client updateClient=clientRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Client not exist with id: " + id));

        updateClient.setFirst_name(clientDetails.getFirst_name());
        updateClient.setLast_name(clientDetails.getLast_name());
        updateClient.setAdress(clientDetails.getAdress());
        updateClient.setPhone_number(clientDetails.getPhone_number());
        updateClient.setEmail(clientDetails.getEmail());

        clientRepository.save(updateClient);
        return ResponseEntity.ok(updateClient);
    }
    //build delete client rest api
    @DeleteMapping("{id}")
    public ResponseEntity<Client> deleteClient(@PathVariable long id){
        Client client=clientRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Client not exist with id: " + id));
        clientRepository.delete(client);

        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
    }

