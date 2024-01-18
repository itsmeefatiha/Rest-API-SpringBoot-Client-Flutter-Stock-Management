package com.example.demo.service;

import com.example.demo.api.controller.ProductController;
import com.example.demo.api.model.Product;
import com.example.demo.api.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;
    private ProductController productController;

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }


    public void checkStockLevelsAndNotify() {
        List<Product> products = getAllProducts();

        for (Product product : products) {
            if (product.getStock_qte() <= 5) {
                sendNotification(product);
            }
        }
    }

    private void sendNotification(Product product) {
        System.out.println("Notification: Le produit " + product.getName() + " est presque épuisé. Quantité actuelle : " + product.getStock_qte());
    }
    }

