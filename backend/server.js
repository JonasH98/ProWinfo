const express = require("express");
const mysql = require("mysql2");
const bcrypt = require("bcrypt");

const con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "autovermietung",
});
con.connect(function (err) {
  if (err) throw err;
  console.log("Connected to DB");
});

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
  const data = request.body;
  //check, that needed parameters are provided
  const needed = [
    data.lastname,
    data.firstname,
    data.address,
    data.password,
    data.email,
  ];
  for (let i = 0; i < needed.length; i++) {
    const e = needed[i];
    if (!e || e.length === 0)
      return response.json({
        status: "error",
        message: "Bitte fülle alle felder aus",
      });
  }
  con.query(
    "SELECT * FROM kunde WHERE Email = ?",
    [data.email],
    async (err, result) => {
      if (err)
        return response.status(500).send("Fehler beim erstellen des Accounts");

      if (result.length > 0)
        return response.json({
          status: "error",
          message: "Die Email ist bereits vorhanden",
        });
      const pw = await bcrypt.hash(data.password, 10);
      con.query(
        "INSERT INTO kunde (Nachname,Vorname,Adresse,Passwort,Email) VALUES(?,?,?,?,?)",
        [data.lastname, data.firstname, data.address, pw, data.email],
        (err, result) => {
          if (err)
            return response
              .status(500)
              .send("Fehler beim erstellen des Accounts");
          return response.json({
            status: "success",
            message: "Der Account wurde erfolgreich erstellt",
          });
        }
      );
    }
  );
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
