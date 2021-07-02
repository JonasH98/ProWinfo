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
            <button onclick="openReserveApplyDialog('${
              data.type_id
            }')">Reservieren</button>
          </div>
        </div>`;
};

const sampleData = {
  imgUrl: "https://freepngimg.com/thumb/car/3-2-car-free-download-png.png",
  name: "BMW I8",
  manufacturer: "BMW",
  type: "Oberklasse",
  doors: "3",
  features: ["Klimaanlage", "Automatik", "Navigation"],
  extras: ["Reifenschutz", "Haftpflichtversicherung"],
  location: "irgendwo im nirgendwo",
  price: 12345.67,
};

const getFilters = () => {
  const getIds = (selector) => {
    let ids = [];
    $(selector).each((idx, ele) => ids.push(ele.getAttribute("db_id")));
    return ids;
  };
  const cls = getIds(".filter-btn-car-type.is-selected");
  const doors = getIds(".filter-btn-doors.is-selected");
  const features = getIds(".filter-btn-features.is-selected");
  const extras = getIds(".filter-btn-extras.is-selected");
  return {
    classes: cls,
    doors: doors,
    features: features,
    extras: extras,
  };
};
const loadData = async () => {
  $(".content").html("");
  const filters = getFilters();
  let data = await fetch("http://localhost:3000/cars", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(filters),
  });
  data = await data.json();
  console.log(data);
  $("#loading-animation-lottie").css("display", "none");
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

const openReserveApplyDialog = (car_type_id) => {
  showYesNoDialog(
    "Wirklich reservieren?",
    "Soll dieser Auto-Typ wirklich reserviert werden?",
    "Ja",
    "Nein",
    "reserveCar(" + car_type_id + ");",
    "test1233"
  );
};

const openOtherTypesDialog = (data) => {
  const modalid = "reserveoptionsshitlololol";
  let htmlString = "";
  for (car_type of data.data) {
    const features = car_type.features
      .map((feature) => `<span>- ${feature.name}</span><br>`)
      .join(" ");

    const extras = car_type.extras
      .map((extra) => `<span>- ${extra.name}</span><br>`)
      .join(" ");
    htmlString += /*html*/ `
        <div class="car-type-box">
            <h3>${car_type.car_class_name}</h3>
            <div class="car-type-info-box">- ${car_type.doors} Türen</div>
            <div class="car-type-info-box">${features}</div>
            <div class="car-type-info-box">${extras}</div>
            <button onclick="closeModal('${modalid}');reserveCar('${car_type.id}')">Auswählen</button>
        </div>
        `;
  }
  htmlString = `<div class="car-type-boxes">${htmlString}</div>`;
  showYesNoDialog(
    data.message.replace("\n", "<br>"),
    htmlString,
    "",
    "Abbrechen",
    "",
    modalid
  );
};

const reserveCar = async (car_type_id) => {
  let data = await fetch("http://localhost:3000/reservation", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      car_type_id: car_type_id,
      date_from: "2020-03-24",
      date_to: "2020-04-27",
      customer_id: 2,
    }),
  });
  data = await data.json();
  console.log(data);
  if (data.status === "warning" && data.data) {
    openOtherTypesDialog(data);
  } else if (data.status === "success") {
    window.location.href = "wait.html";
  }
};

$(".sidebar-left .sidebar-header").click(function () {
  $(".sidebar-left").toggleClass("sidebar-left-hidden");
});
$(".sidebar-right .sidebar-header").click(function () {
  $(".sidebar-right").toggleClass("sidebar-right-hidden");
});
$(".filter-btn").click(function (e) {
  $(this).toggleClass("is-selected");
});
$(".submit-filter").click(async function (e) {
  $("#loading-animation-lottie").css("display", "block");
  await loadData();
});

loadData();
