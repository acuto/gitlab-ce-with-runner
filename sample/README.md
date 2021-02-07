# GitLab CE with Runners

## Part Two: The application sample

### A GraphQL server using Spring Boot

Full implementation of the tutorial project from [GraphQL server using Spring Boot, Part I](https://medium.com/supercharges-mobile-product-guide/graphql-server-using-spring-boot-part-i-722bdd715779).

### Setup

**Step 1.** Create a new blank project in GitLab, e.g. `devops-pipeline`.

**Step 2.** Push the `sample` folder:

```sh
$ cd sample
$ git init
$ git remote add origin http://localhost:40080/root/devops-pipeline.git
$ git add .
$ git commit -m "Initial commit"
$ git push -u origin master
```

(provide the `root` username and `DOAcademy` password as needed).

A GitLab CI/CD pipeline will immediately be launched as a result of the push. Upon its completion, the resulting artifact (docker image) will both be available in the "build" Docker environment (`graphql:0.2.0`) and stored in the "target" Docker Registry (`localhost:5000/graphql:0.2.0`).

**Step 3.** The application can be run by starting its container through command:

```sh
$ docker run -it --name graphiql -p 8080:8080 localhost:5000/graphql:0.2.0
```

The API can be interacted with using the built-in GraphiQL client (which will be available at `http://localhost:8080/graphiql`) or any other
GraphQL client.