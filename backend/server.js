const express = require("express");
const mysql = require("mysql2/promise");
const bcrypt = require("bcrypt");
const cors = require("cors");
const moment = require("moment");
const app = express();
app.use(express.json());
app.use(
  cors({
    origin: "*",
  })
);
let con;

const fieldsAreEmpty = (array) => {
  for (let i = 0; i < array.length; i++) {
    const e = array[i];
    if (!e || e.length === 0) return true;
  }
  return false;
};

/**
 * AUTHENTICATION
 */
app.post("/login", async (request, response) => {
  const data = request.body;
  console.log(data);
  const needed = [data.email, data.password];
  if (fieldsAreEmpty(needed))
    return response.json({
      status: "error",
      message: "Bitte fülle alle felder aus",
    });
  try {
    const [rows, fields] = await con.query(
      "SELECT * FROM customer where email = ?",
      [data.email]
    );

    if (rows.length !== 1)
      return response.json({
        status: "error",
        message: "Kein Account mit der Mail vorhanden",
      });
    const pw_correct = await bcrypt.compare(data.password, rows[0].password);
    if (pw_correct)
      return response.json({
        status: "success",
        message: "Login erfolgreich",
      });
    return response.json({
      status: "error",
      message: "Kombination aus Email und Passwort fehlerhaft",
    });
  } catch (error) {
    return response.json({
      status: "error",
      message: "Fehler beim einloggen" + error,
    });
  }
});
app.post("/register", async (request, response) => {
  const data = request.body;
  const needed = [
    data.lastname,
    data.firstname,
    data.address,
    data.password,
    data.email,
  ];
  if (fieldsAreEmpty(needed)) {
    return response.json({
      status: "error",
      message: "Bitte fülle alle felder aus",
    });
  }
  try {
    const [rows, fields] = await con.query(
      "SELECT * FROM customer WHERE email = ?",
      [data.email]
    );
    if (rows.length > 0) {
      return response.json({
        status: "error",
        message: "Die Email ist bereits vorhanden",
      });
    }
    const pw = await bcrypt.hash(data.password, 10);
    await con.query(
      "INSERT INTO customer (full_name,address,password,email,created_at) VALUES(?,?,?,?,?)",
      [
        data.lastname + " " + data.firstname,
        data.address,
        pw,
        data.email,
        new Date(Date.now()).toISOString().slice(0, 19).replace("T", " "),
      ]
    );
    return response.json({
      status: "success",
      message: "Der Account wurde erfolgreich erstellt",
    });
  } catch (error) {
    return response.json({
      status: "error",
      message: "Fehler beim erstellen des Accounts1" + err,
    });
  }
});

app.get("/reservation", async (request, response) => {});

/**
 * CARS
 */
app.get("/cars/:id", async (request, response) => {
  try {
    const cars = await getCars(request.params.id);
    return response.json(cars);
  } catch (error) {
    return response.json({
      status: "error",
      message: "Fehler beim lesen der Autos" + error,
    });
  }
});
app.post("/cars", async (request, response) => {
  try {
    const cars = await getCars(null, request.body);
    return response.json(cars);
  } catch (error) {
    return response.json({
      status: "error",
      message: "Fehler beim lesen der Autos" + error,
    });
  }
});

const getCars = async (carid, filters) => {
  let sql =
    /*sql */
    `SELECT car.id,
    car_type.seats,car_type.doors,car_type.id AS cartypeid,
    manufacturer.name,
    rental_station.location, car_price,car_class.id as car_class_id,car_class.name as car_class_name
  FROM car,car_type,manufacturer,rental_station,car_class
  where car.car_type_id = car_type.id AND car.manufacturer_id = manufacturer.id AND car.rental_station_id = rental_station.id AND car_class.id = car_type.car_class_id`;
  if (carid) {
    sql += ` AND car.id = "${carid}"`;
  }
  sql += " ORDER BY rental_station.id";

  console.log(filters);
  const [rows, fields] = await con.query(sql);
  const newCars = await Promise.all(
    rows.map(async (car) => {
      const [feat, feat_fields] = await getFeatures(car.cartypeid);
      const [extr, extr_fields] = await getExtras(car.cartypeid);

      const newC = { ...car, features: feat, extras: extr };

      let clsFilt = true;
      let doorsFilt = true;
      let featureFilt = true;
      let extrasFilt = true;
      if (filters) {
        if (filters.doors && filters.doors.length > 0)
          doorsFilt = filters.doors.includes(newC.doors);
        if (filters.classes && filters.classes.length > 0)
          clsFilt = filters.classes.includes(car.car_class_id);
        if (filters.classes && filters.features.length > 0) {
          for (const ft of feat) {
            clsFilt = filters.features.includes(ft.id + "");
            if (clsFilt) break;
          }
        }
        if (filters.extras && filters.extras.length > 0) {
          for (const ex of extr) {
            extrasFilt = filters.extras.includes(ex.id + "");
            if (extrasFilt) break;
          }
        }
      }
      if (!doorsFilt || !clsFilt || !featureFilt || !extrasFilt) return null;
      return newC;
    })
  );
  return newCars.filter((e) => e !== null);
};

const getFeatures = async (typeId) => {
  return await con.query(
    /*sql */ `
    SELECT feature.* 
    FROM car_type_feature,feature 
    WHERE feature.id = car_type_feature.feature_id AND car_type_feature.car_type_id = ?
  `,
    [typeId]
  );
};
const getExtras = async (typeId) => {
  return await con.query(
    /*sql */ `
    SELECT extra.* 
    FROM car_type_extra,extra 
    WHERE extra.id = car_type_extra.extra_id AND car_type_extra.car_type_id = ?
  `,
    [typeId]
  );
};

app.listen(3000, async () => {
  console.log(`Server is Listening on 3000`);
  con = await mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root",
    database: "rental_portal",
  });
  const msg = await con.connect();
  console.log("Connected to DB1");
});
