const express = require("express");

const app = express();
app.use(express.json());

/**
 * AUTHENTICATION
 */
app.post("/login", (request, response) => {
  //check requested login info and send message to client
});
app.post("/register", (request, response) => {
  //register new user with provided information
});

/**
 * CARS
 */
app.get("/cars/:id", (request, response) => {
  //fetch car with specific id
});
app.get("/cars", (request, response) => {
  //fetch cars from database and send it to the client
});

app.listen(3000, () => {
  console.log(`Server is Listening on 3000`);
});
