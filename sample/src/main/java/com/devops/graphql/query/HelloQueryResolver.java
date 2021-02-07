package com.devops.graphql.query;

import com.coxautodev.graphql.tools.GraphQLQueryResolver;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class HelloQueryResolver implements GraphQLQueryResolver {
    
    Logger LOGGER = LoggerFactory.getLogger(HelloQueryResolver.class);

    public String hello() {
        LOGGER.info("Hello, I'm GraphQL!");
        return "Hello, I'm GraphQL!";
    }
}