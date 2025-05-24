package com.example.demo.controller;

import com.example.demo.service.HelloService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import org.springframework.beans.factory.annotation.Autowired;

@WebMvcTest(HelloController.class)
class HelloControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private HelloService helloService;

    @Test
    void sayHello_shouldReturnHelloMessage() throws Exception {
        when(helloService.getHelloMessage()).thenReturn("Hello, Spring Boot!");

        mockMvc.perform(get("/hello"))
               .andExpect(status().isOk())
               .andExpect(content().string("Hello, Spring Boot!"));
    }
}
