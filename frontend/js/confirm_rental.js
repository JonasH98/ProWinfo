let reservation_id = null;

const imagesAvailable = {
  Kleinwagen: 7,
  Kombi: 6,
  Kompaktklasse: 11,
  Mittelklasse: 6,
  Oberklasse: 10,
  SUV: 7,
};

const createCarElement = (data) => {
  const features = data.features
    .map((feature) => `<span>- ${feature.name}</span><br>`)
    .join(" ");

  const extras = data.extras
    .map((extra) => `<span>- ${extra.name}</span><br>`)
    .join(" ");

  let splide_slides = "";
  for (let index = 1; index <= imagesAvailable[data.type]; index++) {
    splide_slides += `<li class="splide__slide"><img src="../images/cars/${data.type}/${index}.png"/></li>`;
  }
  return /*html*/ `<div class="car-item">
            <div class="splide">
              <div class="splide__track">
                <ul class="splide__list">
                  ${splide_slides}
                </ul>
              </div>
            </div>
            <div class="car-info">
              <div class="car-header">
                <span class="very-small-text">ähnlich wie <b>${
                  data.type_name
                }</b> von</span>
                <h1 class="car-name">${data.name}</h1>
              </div>
              <div class="car-info-content">
                <div class="car-specification car-type">
                  <h2 class="car-specification-header">
                    <i class="fas fa-car"></i> Auto-Typ
                  </h2>
                  <span>${data.type}</span>
                </div>
                <div class="car-specification doors">
                  <h2 class="car-specification-header">
                    <i class="fas fa-door-open"></i> Türen
                  </h2>
                  <span>${data.doors}</span>
                </div>
                <div class="car-specification car-features">
                  <h2 class="car-specification-header">
                    <i class="fas fa-star"></i> Zubehör
                  </h2>
                  ${features}
                </div>
                <div class="car-specification car-extras">
                  <h2 class="car-specification-header">
                    <i class="far fa-star"></i> Extras
                  </h2>
                  ${extras}
                </div>
                <div class="car-specification car-price">
                  <h2 class="car-specification-header">
                    <i class="far fa-money-bill-alt"></i> Preis
                  </h2>
                  ${data.price + " €"}
                </div>
              </div>
            </div>
            <div class="car-actions">
              <button onclick="openApplyDialog('${data.id}')">Auswählen</button>
            </div>
          </div>`;
};
const loadData = async (car_type_id) => {
  $(".content").html("");
  $("#reserve_id").val();
  let data = await fetch("http://localhost:5431/cars", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      car_type_id: car_type_id,
    }),
  });
  data = await data.json();
  console.log(data);
  $("#loading-animation-lottie-modal").css("display", "none");
  for (const car of data) {
    $(".content").append(
      createCarElement({
        id: car.id,
        imgUrl: `../images/cars/${car.car_class_name}/1.png`,
        name: car.name,
        type_name: car.car_class_description,
        type: car.car_class_name,
        doors: car.doors,
        seats: car.seats,
        features: car.features,
        extras: car.extras,
        location: car.location,
        price: car.car_type_price,
      })
    );
  }
  var elms = document.getElementsByClassName("splide");
  for (var i = 0, len = elms.length; i < len; i++) {
    new Splide(elms[i], {
      width: "300px",
    }).mount();
  }
};

const rentCar = async (car_id) => {
  let data = await fetch("http://localhost:5431/rent_car", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      car_id: car_id,
      reservation_id: reservation_id,
    }),
  });
  data = await data.json();
  console.log(data);
  showYesNoDialog(
    data.status === "success" ? "Erfolgreich" : "Fehler",
    data.message,
    "Ok",
    "",
    "window.location.href='index.html'",
    "dsgfergerer"
  );
};

const openApplyDialog = (car_id) => {
  showYesNoDialog(
    "Wirklich mieten?",
    "Soll dieser Auto wirklich gemietet werden?",
    "Ja",
    "Nein",
    "rentCar(" + car_id + ");",
    "test1233"
  );
};

const createReserveElement = (data) => {
  return /*html */ `
        <span>Name: ${data.full_name}</span>
        <span>Adresse: ${data.address}</span>
        <span>Station: ${data.location}</span>
        <span>Start: ${data.rent_from}</span>
        <span>Ende: ${data.rent_to}</span>
    `;
};

const loadReserveData = async () => {
  const reserve_id = $("#reserve_id").val();
  reservation_id = reserve_id;
  let data = await fetch(`http://localhost:5431/reservation/${reserve_id}`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });
  data = await data.json();
  if (data.length === 0) {
    $(".reserve-data").html("<span>ungültige Reservierungsnummer</span>");
    return;
  }
  console.log(data[0]);
  $(".reserve-data").html(createReserveElement(data[0]));
  loadData(data[0].car_type_id);
};
