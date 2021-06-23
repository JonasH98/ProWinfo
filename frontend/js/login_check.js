const doLogout = () => {
  localStorage.removeItem("user");
  window.location.reload();
};

if (localStorage.getItem("user") !== null) {
  console.log("is logged in");
  const item = document.getElementsByClassName("nav-group-authentication")[0];
  item.style.display = "none";
  const logoutBtn = /*html */ `
    <div class="nav-group">
        <button onclick="doLogout()">Logout</button>
    </div>`;

  document.getElementsByTagName("navbar")[0].innerHTML += logoutBtn;
}
