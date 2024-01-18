package com.example.demo.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.api.repository.OrderDetailRepository;
import com.example.demo.api.repository.OrderRepository;
import com.example.demo.api.repository.ProductRepository;
import com.example.demo.api.exception.ResourceNotFoundException;
import com.example.demo.api.model.Order;
import com.example.demo.api.model.OrderDetail;
import com.example.demo.api.model.Product;

@RestController
@RequestMapping("/api/orders")
public class OrderController {
    
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private ProductRepository productRepository;

    @GetMapping
    public Iterable<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @PostMapping
    public Order createOrder(@RequestBody Order order)  {
        return orderRepository.save(order);
    }

    @PostMapping("/order-items/{orderId}")
    public OrderDetail storeOrderItems(@PathVariable long orderId, @RequestBody OrderDetail orderItem){
        orderItem.setOrder(orderId);

        long productId = (long) orderItem.getProduct();

        Product updateProduct = productRepository.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not exist with id: " + productId));

        updateProduct.setStock_qte(updateProduct.getStock_qte() - orderItem.getQuantity());
        productRepository.save(updateProduct);

        return orderDetailRepository.save(orderItem);
    }
}
