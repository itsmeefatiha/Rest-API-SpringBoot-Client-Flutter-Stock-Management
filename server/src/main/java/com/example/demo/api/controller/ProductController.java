package com.example.demo.api.controller;

import com.example.demo.api.exception.ResourceNotFoundException;
import com.example.demo.api.model.Client;
import com.example.demo.api.model.Product;
import com.example.demo.api.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/product")
public class ProductController {
    @Autowired
    private ProductRepository productRepository;

    @GetMapping
    public List<Product> getProductList() {
        return productRepository.findAll();
    }
    // build create product Rest Api
    @PostMapping
    public Product createProduct(@RequestBody Product product)  {
        return productRepository.save(product)  ;
    }
    //build get product by id rest api
    @GetMapping("{id}")
    public ResponseEntity<Product> getProductById(@PathVariable long id){
        Product product= productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not exist with id: " + id));
        return ResponseEntity.ok(product);
    }
    //build update product rest api
    @PutMapping("{id}")
    public ResponseEntity<Product> updateProduct(@PathVariable Integer id, @RequestBody Product productDetails) {
        Long productId = (long) id;
        Product updateProduct = productRepository.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not exist with id: " + productId));
        updateProduct.setName(productDetails.getName());
        updateProduct.setdescription(productDetails.getdescription());
        updateProduct.setPrice(productDetails.getPrice());
        updateProduct.setStock_qte(productDetails.getStock_qte());

        productRepository.save(updateProduct);
        return ResponseEntity.ok(updateProduct);
    }

    //build delete client rest api
    @DeleteMapping("{id}")
    public ResponseEntity<Client> deleteProduct(@PathVariable long id){
        Product product=productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not exist with id: " + id));
        productRepository.delete(product);

        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}