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

app.get("/rental/:id", async (request, response) => {
  const rental_id = request.params.id;
  const sql = /*sql*/ `
    SELECT customer.full_name, customer.address, customer.email, car.id, reservation.rent_from, reservation.rent_to
    FROM customer , rental, reservation, car
    WHERE rental.id = ?
      AND rental.reservation_id = reservation.id
      AND rental.car_id = car.id
      AND customer.id = reservation.customer_id
   `;
  const [rows, fields] = await con.query(sql, [rental_id]);
  return response.json(rows);
});

app.get("/reservation/:id", async (request, response) => {
  const reservation_id = request.params.id;
  console.log(reservation_id);
  const sql = /*sql*/ `
    SELECT cus.full_name,cus.address,reservation.*,rental_station.location as location
    FROM reservation,rental_station,customer as cus
    WHERE reservation.id = ? 
      AND reservation.customer_id = cus.id 
      AND reservation.rental_station_id = rental_station.id
   `;
  const [rows, fields] = await con.query(sql, [reservation_id]);
  return response.json(rows);
});
app.post("/reservation", async (request, response) => {
  const { car_type_id, date_from, date_to, customer_id, rental_station_id } =
    request.body;
  //check availability where given daterange not intersecting any current reservation range
  const sql_check = /*sql */ `
    SELECT * FROM reservation where car_type_id = ? AND 
    -- fully intersect 
    (("${date_from}" > rent_from AND "${date_to}" < rent_to) OR
    -- from in range
    ("${date_from}" > rent_from AND "${date_from}" < rent_to) OR
    -- to in range
    ("${date_to}" > rent_from AND "${date_to}" < rent_to))
  `;
  const sql_insert =
    "INSERT INTO reservation (car_type_id,customer_id,reserved_at,rent_from,rent_to,rental_station_id)VALUES(?,?,?,?,?,?)";
  try {
    const numberAvilable = await numberOfCarsAvailableForType(car_type_id);
    const [rows, fields] = await con.query(sql_check, [car_type_id]);
    //check if all cars for that car_type are already reserved
    if (rows.length > numberAvilable) {
      //there are already reservations in this time range
      //check for different car_class
      const current_class = await getClassFromType(car_type_id);
      let counter = 0;
      let available_types = [];
      let new_class_id = current_class.id + 1;
      while (counter < 6) {
        const typesForClass = await getTypesForClass(new_class_id);
        for (const typeShit of typesForClass) {
          const numberAvilable = await numberOfCarsAvailableForType(
            typeShit.id
          );
          const [rows, fields] = await con.query(sql_check, [typeShit.id]);

          if (rows.length < numberAvilable) available_types.push(typeShit);
        }
        new_class_id++;
        if (new_class_id > 6) new_class_id = 1;
        counter++;
      }
      if (available_types.length > 0) {
        return response.json({
          status: "warning",
          message:
            "Zu diesem Zeitraum gibt es diesen Auto-Typen nicht mehr.\nAllerdings können wir Ihnen eine anderen Typen anbieten",
          data: available_types,
        });
      }
      return response.json({
        status: "error",
        message: "keine autos mehr verfügbar",
      });
    }
    //write reservation to db
    await con.query(sql_insert, [
      car_type_id,
      customer_id,
      new Date(Date.now()).toISOString().slice(0, 19).replace("T", " "),
      date_from,
      date_to,
      rental_station_id,
    ]);
    return response.json({
      status: "success",
      message: "erfolgreich reserviert",
    });
  } catch (error) {
    console.log(error);
    return response.json({
      status: "error",
      message: "Fehler bei der reservierung " + error,
    });
  }
});

app.post("/rent_car", async (request, response) => {
  const { car_id, reservation_id } = request.body;
  const sql = "INSERT INTO rental (car_id,reservation_id) VALUES(?,?)";
  try {
    await con.query(sql, [car_id, reservation_id]);
    return response.json({
      status: "success",
      message: "Mietvertrag erfolgreich abgeschlossen",
    });
  } catch (err) {
    console.log(error);
    return response.json({
      status: "error",
      message: "Fehler bei der abschließen des Mietvertrags" + error,
    });
  }
});

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
    rental_station.location, car_type_price,car_class.id as car_class_id,car_class.name as car_class_name,car_class.description AS car_class_description
  FROM car,car_type,manufacturer,rental_station,car_class
  where car.car_type_id = car_type.id AND car.manufacturer_id = manufacturer.id AND car.rental_station_id = rental_station.id AND car_class.id = car_type.car_class_id`;
  if (carid) {
    sql += ` AND car.id = "${carid}"`;
  }
  if (filters && filters.car_type_id) {
    sql += ` AND car_type.id = "${filters.car_type_id}"`;
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
          clsFilt = filters.classes.includes(car.car_class_id + "");
        if (filters.features && filters.features.length > 0) {
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

const getClassFromType = async (typeId) => {
  const [rows, fields] = await con.query(
    /*sql */ `SELECT car_class.* from car_type,car_class where car_class.id = car_type.car_class_id AND car_type.id = ?`,
    [typeId]
  );
  return rows[0];
};
const getTypesForClass = async (classId) => {
  const [rows, fields] = await con.query(
    /*sql */ `SELECT car_type.*,car_class.id as car_class_id,car_class.name as car_class_name 
              from car_type,car_class
              where car_class.id = car_type.car_class_id AND car_class_id = ?`,
    [classId]
  );
  const newTypes = await Promise.all(
    rows.map(async (cartype) => {
      const [feat, feat_fields] = await getFeatures(cartype.id);
      const [extr, extr_fields] = await getExtras(cartype.id);
      const newT = { ...cartype, features: feat, extras: extr };
      return newT;
    })
  );
  return newTypes;
};
const numberOfCarsAvailableForType = async (typeId) => {
  const [rows, fields] = await con.query(
    /*sql */ `SELECT count(*) as cars_count FROM car where car_type_id = ?`,
    [typeId]
  );
  return rows[0].cars_count;
};

app.listen(5431, async () => {
  console.log(`Server is Listening on 5431`);
  con = await mysql.createConnection({
    host: "217.160.71.120",
    user: "adRental",
    password: "uX_S8fyRjv4qcJWV",
    database: "rental_portal",
  });
  const msg = await con.connect();
  console.log("Connected to DB1");
});
