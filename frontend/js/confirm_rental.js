const createCarElement = (data) => {
  const features = data.features
    .map((feature) => `<span>- ${feature.name}</span><br>`)
    .join(" ");

  const extras = data.extras
    .map((extra) => `<span>- ${extra.name}</span><br>`)
    .join(" ");
  return /*html*/ `<div class="car-item">
            <div class="car-img">
              <img
                src=${data.imgUrl}
                width="300"
              />
            </div>
            <div class="car-info">
              <div class="car-header">
                <h1 class="car-name">${data.name} oder ähnliche...</h1>
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
                <div class="car-specification car-extras">
                  <h2 class="car-specification-header">
                    <i class="fas fa-map-marker-alt"></i> Ort
                  </h2>
                  ${data.location}
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
              <button onclick="">Auswählen</button>
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
        imgUrl:
          "https://freepngimg.com/thumb/car/3-2-car-free-download-png.png",
        name: car.name,
        manufacturer: car.name,
        type: car.car_class_name,
        type_id: car.cartypeid,
        doors: car.doors,
        seats: car.seats,
        features: car.features,
        extras: car.extras,
        location: car.location,
        price: car.car_price,
      })
    );
  }
};

const createReserveElement = (data) => {
  return /*html */ `
        <span>${data.full_name}</span>
        <span>${data.address}</span>
        <span>${data.location}</span>
        <span>${data.rent_from}</span>
        <span>${data.rent_to}</span>
    `;
};

const loadReserveData = async () => {
  const reserve_id = $("#reserve_id").val();
  let data = await fetch(`http://localhost:5431/reservation/${reserve_id}`, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  });
  data = await data.json();
  console.log(data[0]);
  $(".reserve-data").html(createReserveElement(data[0]));
  loadData(data[0].car_type_id);
};
