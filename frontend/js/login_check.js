const doLogout = () => {
  localStorage.removeItem("user");
  window.location.reload();
};

if (localStorage.getItem("user") !== null) {
  const isAdmin = localStorage.getItem("user") === "admin";
  console.log("is logged in");
  const item = document.getElementsByClassName("nav-group-authentication")[0];
  item.style.display = "none";
  const adminBtn = /*html */ `<a href="admin_dashboard.html"><button>Admin Dashbaord</button></a>`;
  const logoutBtn = /*html */ `
    <div class="nav-group">
        <button onclick="doLogout()">Logout</button>
        ${isAdmin ? adminBtn : ""}
    </div>`;

  document.getElementsByTagName("navbar")[0].innerHTML += logoutBtn;
}
