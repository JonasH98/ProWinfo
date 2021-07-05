const doLogout = () => {
  localStorage.removeItem("user");
  window.location.reload();
};

const showProfileModal = async () => {
  const email = localStorage.getItem("user");
  let data = await fetch(`http://localhost:5431/profile?email=${email}`);
  data = await data.json();
  const content = /*html*/ `<div style="display:flex;flex-direction:column;gap:1rem;">
        <span>Name: ${data.full_name}</span>
        <span>Adresse: ${data.address}</span>
        <span>Email: ${data.email}</span>
        <span>Statuskilometer: ${data.driven_km}</span></div>
  `;
  showYesNoDialog("Profil", content, "", "Schließen", "profilemodal");
};

if (localStorage.getItem("user") !== null) {
  const isAdmin = localStorage.getItem("user") === "admin";
  console.log("is logged in");
  const item = document.getElementsByClassName("nav-group-authentication")[0];
  item.style.display = "none";
  const adminBtn = /*html */ `<a href="admin_dashboard.html"><button>Admin Dashbaord</button></a>`;
  const profileBtn = /*html */ `<button onclick="showProfileModal()">Profil</button>`;
  const logoutBtn = /*html */ `
    <div class="nav-group">
    ${isAdmin ? "" : profileBtn}
        <button onclick="doLogout()">Logout</button>
        ${isAdmin ? adminBtn : ""}
    </div>`;

  document.getElementsByTagName("navbar")[0].innerHTML += logoutBtn;
}
