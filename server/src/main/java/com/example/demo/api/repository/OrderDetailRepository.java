package com.example.demo.api.repository;
import com.example.demo.api.model.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderDetailRepository extends JpaRepository<OrderDetail,Long> {
    //all crud database methods
}

