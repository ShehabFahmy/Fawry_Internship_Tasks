package com.example.demo.service;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class HelloServiceTest {

    private final HelloService helloService = new HelloService();

    @Test
    void getHelloMessage_shouldReturnCorrectMessage() {
        String result = helloService.getHelloMessage();
        assertEquals("Hello, Spring Boot!", result);
    }
}
